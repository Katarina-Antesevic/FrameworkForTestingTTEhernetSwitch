import sys, os, glob, time
from tftpy import TftpClient, TftpShared
from Modules.tte_epos_globals import Test_Timeout
from Modules import tte_epos_snmp_objects
from Modules import tte_epos_file_system
from Modules.tte_epos_file_system import FileExtension
from Modules import tte_epos_snmp
from Modules import tte_epos_tftp


TFTP_PORT = 69
TFTP_EXTENSION = FileExtension.TFTP
last_build = tte_epos_file_system.FileSystem()
SNMP_ARM_PARAM = "1"

user_files_for_upload = ["TTC_Firmware.bin", 'TTC_FWparam.bin', 'TTC_NetworkCfg.bin', 'TTC_EScfg.bin', 'TTC_SWEcfg.bin', 'TTC_BITCfg.bin']

dictionary = { "TTC_Firmware.bin": [tte_epos_snmp_objects.TTE_SW_SPACE_USR_FW_A_FILE_VALID, tte_epos_snmp_objects.TTE_SW_SPACE_USR_FW_B_FILE_VALID],
            "TTC_FWparam.bin" : [tte_epos_snmp_objects.TTE_SW_SPACE_USR_PARAM_A_FILE_VALID, tte_epos_snmp_objects.TTE_SW_SPACE_USR_PARAM_B_FILE_VALID],
            "TTC_NetworkCfg.bin": [tte_epos_snmp_objects.TTE_SW_SPACE_USR_NET_A_FILE_VALID, tte_epos_snmp_objects.TTE_SW_SPACE_USR_NET_B_FILE_VALID],
            "TTC_EScfg.bin" : [tte_epos_snmp_objects.TTE_SW_SPACE_USR_ES_A_FILE_VALID, tte_epos_snmp_objects.TTE_SW_SPACE_USR_ES_B_FILE_VALID] ,
            "TTC_SWEcfg.bin" : [tte_epos_snmp_objects.TTE_SW_SPACE_USR_SWE_A_FILE_VALID, tte_epos_snmp_objects.TTE_SW_SPACE_USR_SWE_B_FILE_VALID],
            "TTC_BITCfg.bin" : [tte_epos_snmp_objects.TTE_SW_SPACE_USR_BIT_A_FILE_VALID , tte_epos_snmp_objects.TTE_SW_SPACE_USR_BIT_B_FILE_VALID],
            }


def uploadUserFilesViaTFTP():
    returnSt = ""

    global user_files_for_upload
    for user_file in user_files_for_upload:
        file_name = user_file.split(".")[0]
        
        file_path = last_build.get_valid_file(file_name = file_name, extension = TFTP_EXTENSION)
        time.sleep(1)
        
        send_cmd_arm = cmd_arm("1")
        if send_cmd_arm:
            returnSt += "CMD_ARM command executed successfully\n"
        else:
            raise Exception("CMD_ARM command NOT executed successfully\n")

        is_file_uploaded = tte_epos_tftp.upload_file(file_path, user_file)
        if is_file_uploaded:
            returnSt += f"TFTP upload of file {user_file} successful\n"
        else:
            raise Exception(f"TFTP upload od file {user_file} NOT successful\n")

        time.sleep(20)

        is_file_valid = check_file_validity(user_file)

        returnSt += is_file_valid

        returnSt +="\n"
        
    returnSt += "\nAll user files uploaded successfully"
    return returnSt 
    

def cmd_arm(set_value):
    snmp_request_result= tte_epos_snmp.set_request(oid_value=tte_epos_snmp_objects.TTE_SW_SPACE_ARM, set_value=set_value)
    time.sleep(2)

    snmp_request_result = ''.join(data for data in snmp_request_result if data.isalnum())
    set_value = ''.join(data for data in set_value if data.isalnum())

    return snmp_request_result == str(set_value)


def check_file_validity(set_value):
    file_name = set_value

    returnSt = ""
    snmp_request_result = tte_epos_snmp.set_request(oid_value= tte_epos_snmp_objects.TTE_SW_SPACE_VERIFY_FILE, set_value= set_value)
    time.sleep(20)

    snmp_request_result = ''.join(data for data in snmp_request_result if data.isalnum())
    set_value = ''.join(data for data in set_value if data.isalnum())

    if snmp_request_result == str(set_value):
        returnSt += f"SNMP request to verify the file {file_name} passed.\n"

        global dictionary
        fileA_oid = dictionary[file_name][0]
        fileB_oid = dictionary[file_name][1]
        
        fileA_valid = tte_epos_snmp.get_request(fileA_oid)
        if fileA_valid == "0":
            returnSt += f"SNMP returns value 0 for fileCopyValid identifier of copy A of {file_name}. File copy A is VALID.\n"
        else:
            raise Exception(f"SNMP returns value 1 for fileCopyValid identifier of copy A of {file_name}. File copy A is NOT VALID.")

        fileB_valid = tte_epos_snmp.get_request(fileB_oid)

        if fileB_valid == "0":
            returnSt += f"SNMP returns value 0 for fileCopyValid identifier of copy B of {file_name}. File copy B is VALID.\n"
        else:
            raise Exception(f"SNMP returns value 1 for fileCopyValid identifier of copy B of {file_name}. File copy B is NOT VALID.")
    else:
        raise Exception(f"SNMP request to verify the file {file_name} failed.\n")
    
    return returnSt 
