import sys, os, glob, time
from Modules import epos_init
from tftpy import TftpClient, TftpShared


TFTP_PORT = 69

default_files_for_download = ['TTC_FirmwareDft.bin', 'TTC_FWparamDft.bin', 'TTC_NetworkCfgDft.bin', 'TTC_EScfgDft.bin', 
'TTC_SWEcfgDft.bin',  'TTC_BITCfgDft.bin', 'TTC_FWloader.bin', 'TTC_ProductData.bin']

user_files_for_download = ['TTC_Firmware.bin', 'TTC_FWparam.bin', 'TTC_NetworkCfg.bin', 'TTC_EScfg.bin', 'TTC_SWEcfg.bin', 
'TTC_BITCfg.bin']

all_files_for_download = default_files_for_download + user_files_for_download

number_of_files_downloaded = 0

def clearMyDirectory(dir_path):
    files = glob.glob(dir_path+'/*')
    for f in files:
        os.remove(f)

    return "Directory for storing default and user files is emptied"
    

def downloadFileViaTftp(file_name, dest_path):
    client = TftpClient(epos_init.EPOS_IP, TFTP_PORT)
    client.download(file_name, dest_path+'/'+file_name)

    end_file_path = dest_path+"/"+file_name

    if os.path.exists(end_file_path):
        global number_of_files_downloaded
        number_of_files_downloaded += 1
        return f"TFTP download of file {file_name} successful\n"
    else:
        raise Exception(f"Error while downloading file {file_name}")


def downloadFilesViaTftp(dest_path):
    returnSt = ""

    global all_files_for_download
    for file_name in all_files_for_download:
        returnSt += downloadFileViaTftp(file_name, dest_path)

    if len(all_files_for_download) == number_of_files_downloaded:
        returnSt += "\nAll default and user files downloaded successfully"
    else:
        raise Exception("Error while downloading files!")
    
    return returnSt
