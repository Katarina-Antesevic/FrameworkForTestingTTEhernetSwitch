*** Settings ***
Library    IcmpReplyCheck

*** Keywords ***
Remove Pcap File 
    [Arguments]    ${filePath}
    ${result}    Evaluate    IcmpReplyCheck.deletePcapFile(${filePath})
    [Return]    ${result}

Performing Pre-Initialization
    [Arguments]
    ${result}    Evaluate    IcmpReplyCheck.performingPreInitializationStepsOFTheTestEnvironment()
    [Return]    ${result}

Get Firmware Into Operational Mode
    [Arguments]
    ${result}    Evaluate    IcmpReplyCheck.getFirwmwareIntoOperationalMode()
    [Return]    ${result}
    
Create ICMP Requests
    [Arguments]    ${harwareIpAddress}    ${filePath}
    ${result}    Evaluate    IcmpReplyCheck.createPcapFileBasedOnICMPRequest(${harwareIpAddress}, ${filePath})
    [Return]    ${result}
    
Json 
    [Arguments]    ${protocol}    ${pcapFilePath}    ${jsonFilePath}    ${jsonScript}
    ${result}    Evaluate    IcmpReplyCheck.createJsonFileFromPcapFile(${protocol}, ${pcapFilePath}, ${jsonFilePath}, ${jsonScript})
    [Return]    ${result}

Parse Json File
    [Arguments]    ${jsonFilePath}
    ${result}    Evaluate    IcmpReplyCheck.parseJsonFileIcmp(${jsonFilePath})
    [Return]    ${result}