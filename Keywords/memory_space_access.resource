*** Settings ***
Library    MemorySpaceAccess

*** Keywords ***
Start Of Shared Memory Keyword
    [Arguments]    ${configFile}
    ${result}    Evaluate    MemorySpaceAccess.testStartOfSharedMemory(${configFile})
    [Return]    ${result}

Value On Start Of Shared Memory Address Keyword
    [Arguments]    
    ${result}    Evaluate    MemorySpaceAccess.valueOnStartOfSharedMemoryAddress()
    [Return]    ${result}

Value For Offset 0x0004 Keyword
    [Arguments]    
    ${result}    Evaluate    MemorySpaceAccess.valueForOffset0x0004()
    [Return]    ${result}

Value For Offset 0x0008 Keyword
    [Arguments]    
    ${result}    Evaluate    MemorySpaceAccess.valueForOffset0x0008()
    [Return]    ${result}


Value For Offset 0x0010 Keyword
    [Arguments]    
    ${result}    Evaluate    MemorySpaceAccess.valueForOffset0x0010()
    [Return]    ${result}

#Get Firmware Into Operational mode
 #   [Arguments]
  #  ${result}    Evaluate    MemorySpaceAccess.firmwareIntoOperationalState()
   # [Return]    ${result}
