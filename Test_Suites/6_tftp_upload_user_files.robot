*** Settings ***
Resource    ../Keywords/tftp_upload_user_files.resource
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
...    ${\n}Purpose of the test is to check if firmware allows upload of User files to NVM (Non-Volatile Memory) using TFTP protocol.
...    ${\n}User files that need to be uploaded: TTC_Firmware.bin, TTC_FWparam.bin, TTC_NetworkCfg.bin, TTC_EScfg.bin, TTC_SWEcfg.bin, 
...    TTC_BITCfg.bin
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

Upload User Files Via Tftp
    [Documentation]    For each User file: find path to valid User file, execute CMD_ARM command, 
    ...                upload User file to NVM via TFTP protocol and check if uploaded file is valid
    ${result}    TFTP Upload User Files   
    Set Test Message    ${result}