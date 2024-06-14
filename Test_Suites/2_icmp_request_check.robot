*** Settings ***
Resource    ../Variables/variables.robot
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
...    ${\n}Purpose of the test is to check if hardware sends response to an ICMP ping request within 2 seconds.
...    ${\n}This is done by traffic capturing and parsing result file.
...    ${\n}==========================================================================================


*** Test Cases ***
Remove Old Pcap File
    [Documentation]    Delete previously created pcap file, if file exists
    ${result}    Remove Pcap File    ${icmpPcapFilePath}
    Set Test Message    ${result}

Pre-Initialization
    [Documentation]    Perform pre-initialization steps of the test environment
    ${result}    Performing Pre-Initialization
    Set Test Message    ${result}

Get Firmware Into Operational Mode
    [Documentation]    Get Firmware into Operational mode
    ${result}    Get Firmware Into Operational Mode
    Set Test Message    ${result}

Create ICMP Requests
    [Documentation]    Create specific number of ICMP ping requests
    ${result}    Create ICMP Requests    ${hardwareIPAddress}    ${icmpPcapFilePath}
    Set Test Message    ${result}

Create Json file
    [Documentation]    Create json file based on pcap file
    ${result}    Json    ${icmpProtocol}    ${icmpPcapFilePath}    ${icmpJsonFilePath}   ${jsonScript}
    Set Test Message    ${result}


Parse Json File
    [Documentation]    Parse previously created pcap file to find reply time of every
    ...                ICMP response
    ${result}    Parse Json File    ${icmpJsonFilePath}
    Set Test Message    ${result}