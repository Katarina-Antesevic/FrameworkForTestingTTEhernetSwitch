*** Settings ***
Resource    ../Keywords/tftp_download.resource
Resource    ../Keywords/icmp_reply_check.resource
Resource    ../Variables/variables.robot
Library    DateTime
Documentation    Project : Robot Framework.
...    ${\n}##Test PC:
...    ${\n}Hostname: rtrkbl76-lin.domain.local
...    ${\n}Kernel: 5.15.0-94-generic
...    ${\n}Distributor: Ubuntu
...    ${\n}Description: Ubuntu 20.04.6 LTS
...    ${\n}Release: 20.04
...    ${\n}##Tested firmware: 
...    ${\n}Firmware version: 0.14.2.
...    ${\n}==========================================================================================
...    ${\n}Purpose of the test is to check if firmware allows download of Default and User files from NVM (Non-Volatile Memory) using TFTP protocol.
...    ${\n}Default files that need to be downloaded: TTC_FirmwareDft.bin, TTC_FWparamDft.bin, TTC_NetworkCfgDft.bin, TTC_EScfgDft.bin, 
...    TTC_SWEcfgDft.bin,  TTC_BITCfgDft.bin, TTC_FWloader.bin, TTC_ProductData.bin
...    ${\n}User files that need to be downloaded: TTC_Firmware.bin, TTC_FWparam.bin, TTC_NetworkCfg.bin, TTC_EScfg.bin, TTC_SWEcfg.bin, 
...    TTC_BITCfg.bin
...    ${\n}==========================================================================================


*** Test Cases ***
Clear Directory
    [Documentation]    Delete all files previously downloaded in directory TFTP_Files 
    ${result}    Clear Directory    ${tftpFilesPath}
    Set Test Message    ${result}

Pre-Initialization
    [Documentation]    Perform pre-initialization steps of the test environment
    ${result}    Performing Pre-Initialization
    Set Test Message    ${result}

Get Firmware Into Operational Mode
    [Documentation]    Get Firmware into Operational mode
    ${result}    Get Firmware Into Operational Mode
    Set Test Message    ${result}

Download Files Via TFTP
    [Documentation]    Download all necessary default and user files
    ${result}    TFTP Download Files    ${tftpFilesPath}
    Set Test Message    ${result}
