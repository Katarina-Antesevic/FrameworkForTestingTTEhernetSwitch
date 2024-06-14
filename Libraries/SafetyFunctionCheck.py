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
ARM_TIMEOUT = 10

user_file_for_upload = "TTC_Firmware.bin"

def uploadUserFileViaTFTP():
    returnSt = ""

    global user_file_for_upload
    
    file_name = user_file_for_upload.split(".")[0]
        
    file_path = last_build.get_valid_file(file_name = file_name, extension = TFTP_EXTENSION)
    time.sleep(1)

    #ARM command
    snmp_request_result= tte_epos_snmp.set_request(oid_value=tte_epos_snmp_objects.TTE_SW_SPACE_ARM, set_value="1")
    returnSt += "CMD_ARM excecuted"
    time.sleep(ARM_TIMEOUT)

    returnSt += "\n10 seconds passed"

    is_file_uploaded = tte_epos_tftp.upload_file(file_path, user_file_for_upload)
    if not is_file_uploaded:
        returnSt += f"\nTFTP upload of User file {user_file_for_upload} NOT successful\n"
    else:
        raise Exception(f"TFTP upload of User file {user_file_for_upload} successful\n")

    return returnSt