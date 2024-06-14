*** Settings ***
Resource    ../Keywords/tftp_upload_default_files.resource
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
...    ${\n}Purpose of the test is to check if firmware allows upload of Default files to NVM (Non-Volatile Memory) using TFTP protocol.
...    ${\n}It is expected that firmware will NOT allow upload of any Default file to NVM using TFTP protocol.
...    ${\n}Default files that need to be uploaded: TTC_FirmwareDft.bin, TTC_FWparamDft.bin, TTC_NetworkCfgDft.bin, TTC_EScfgDft.bin, 
...    TTC_SWEcfgDft.bin,  TTC_BITCfgDft.bin, TTC_FWloader.bin, TTC_ProductData.bin
...    ${\n}==========================================================================================


*** Test Cases ***
Pre-Initialization
    [Documentation]    Perform pre-initialization steps of the test environment
    ${result}    Performing Pre-Initialization
    Set Test Message    ${result}

Get Firmware Into Operational Mode
    [Documentation]    Get Firmware into Operational mode
    ${result}    Get Firmware Into Operational Mode
    Set Test Message    ${result}

Upload Default Files Via TFTP
    [Documentation]    For each Deafult file: find path to valid Default file, execute CMD_ARM command, 
    ...                and try to upload Default file to NVM via TFTP protocol
    ${result}    TFTP Upload Default Files
    Set Test Message    ${result}
