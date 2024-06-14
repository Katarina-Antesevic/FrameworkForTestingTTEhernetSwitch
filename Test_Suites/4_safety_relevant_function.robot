*** Settings ***
Resource    ../Keywords/safety_function_check.resource
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
...    ${\n}Purpose of the test is to validate that firmware triggers safety relevant function, TFTP upload, only during time interval
...    ${\n}of 10 seconds after receiving the ARM command provided by the firmware.
...    ${\n}It is expected that firmware will NOT allow upload of User file to NVM using TFTP protocol.
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

Check Safety Relevant Function
    [Documentation]    Execute CMD_ARM command, wait 10 seconds and try TFTP upload of User file to NVM
    ${result}    Check Safety Relevant Function
    Set Test Message    ${result}