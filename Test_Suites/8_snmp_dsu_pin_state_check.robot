*** Settings ***
Resource    ../Variables/variables.robot
Resource    ../Keywords/snmp_dsu_pin_state_check.resource
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
...    ${\n}Purpose of the test is to validate that while in Operational mode, firmware reports if DSU is enabled over SNMP.
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

Set Dsu Pin To Low
    [Documentation]    Set the DSU_EN pin low and check if the DSU_EN pin is disabled with FT232 interface
    ${result}    Set Dsu Pin To Low
    Set Test Message    ${result}

SNMP Dsu Pin State Check Low
    [Documentation]    Check if DSU_EN pin is low using SNMP Get request
    ${result}    SNMP Dsu Pin State Check Low
    Set Test Message    ${result}

Set Dsu Pin To High    
    [Documentation]    Set the DSU_EN pin high and check if the DSU_EN pin is enabled with FT232 interface
    ${result}    Set Dsu Pin To High
    Set Test Message    ${result}

SNMP Dsu Pin State Check High
    [Documentation]    Check if DSU_EN pin is high using SNMP Get request
    ${result}    SNMP Dsu Pin State Check High
    Set Test Message    ${result}
