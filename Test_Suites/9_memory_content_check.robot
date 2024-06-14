*** Settings ***
Resource    ../Variables/variables.robot
Resource    ../Keywords/memory_space_access.resource
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
...    ${\n}Purpose of the test is to check the address that contains information about start of shared memory address and to
...    ${\n}check value of shared memory when specific offset is provided.
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
    
Start Of Shared Memory Test
    [Documentation]    Read value from address 0x20001000. Value represents start of shared memory.
    ${result}    Start Of Shared Memory Keyword    ${configFile}
    Set Test Message    ${result}

Value On Start Of Shared Memory Address Test
    [Documentation]       Read value from address that respresents start of shared memory.
    ${result}    Value On Start Of Shared Memory Address Keyword
    Set Test Message    ${result}

Value For Offset 0x0004 Test
    [Documentation]    Add offset 0x0004 on start of shared memory address and read value from address.
    ${result}    Value For Offset 0x0004 Keyword
    Set Test Message    ${result}

Value For Offset 0x0008 Test
    [Documentation]    Add offset 0x0008 on start of shared memory address and read value from address.
    ${result}    Value For Offset 0x0008 Keyword
    Set Test Message    ${result}
