import sys, os, glob, time
from tftpy import TftpClient, TftpShared
from Modules.tte_epos_globals import Test_Timeout
from Modules import tte_epos_snmp_objects
from Modules import tte_epos_file_system
from Modules.tte_epos_file_system import FileExtension
from Modules import tte_epos_snmp
from Modules import tte_epos_tftp
from TFTPUploadUserFiles import cmd_arm


TFTP_PORT = 69
TFTP_EXTENSION = FileExtension.TFTP
last_build = tte_epos_file_system.FileSystem()
SNMP_ARM_PARAM = "1"
is_any_file_uploaded = 0

default_files_for_upload = ['TTC_FirmwareDft.bin', 'TTC_FWparamDft.bin', 'TTC_NetworkCfgDft.bin', 'TTC_EScfgDft.bin', 
'TTC_SWEcfgDft.bin',  'TTC_BITCfgDft.bin', 'TTC_FWloader.bin', 'TTC_ProductData.bin']


def uploadDefaultFilesViaTFTP():
    returnSt = ""
    global is_any_file_uploaded
    global default_files_for_upload
    for deafult_file in default_files_for_upload:
        
        file_name = deafult_file.split(".")[0]
        
        file_path = last_build.get_valid_file(file_name = file_name, extension = TFTP_EXTENSION)
        time.sleep(1)
        
        send_cmd_arm = cmd_arm("1")
        if send_cmd_arm:
            returnSt += "CMD_ARM command executed successfully\n"
        else:
            raise Exception("CMD_ARM command NOT executed successfully\n")

        is_file_uploaded = tte_epos_tftp.upload_file(file_path, deafult_file)
        if is_file_uploaded:
            is_any_file_uploaded += 1
            returnSt += f"TFTP upload of file {deafult_file} successful\n"
        else:
            returnSt += f"TFTP upload of file {deafult_file} NOT successful\n"

        returnSt +="\n"
    if is_any_file_uploaded == 0:  
        returnSt += ("\nNo Default file uploaded to NVM")
    else:
        raise Exception("Some Default file uploaded")
    return returnSt 