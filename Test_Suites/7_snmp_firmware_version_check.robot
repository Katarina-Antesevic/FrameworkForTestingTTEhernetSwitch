*** Settings ***
Resource    ../Variables/variables.robot
Resource    ../Keywords/snmp_firmware_version_check.resource
Resource    ../Keywords/icmp_reply_check.resource
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
...    ${\n}Purpose of the test is to validate that while in Operational mode, firmware provides its firmware version via SNMP.
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

Get Firmware Version Via SNMP
    [Documentation]    Get firmware version from specific OID using SNMP protocol
    ${result}    Get Firmware Version
    Set Test Message    ${result}

Compare Firmware Versions
    [Documentation]    Read firmware version from .ini file and compare firmware version retrieved by SNMP protocol from specific OID and
    ...                firmware version read from .ini file
    ${result}    Compare Firmware Versions
    Set Test Message    ${result}