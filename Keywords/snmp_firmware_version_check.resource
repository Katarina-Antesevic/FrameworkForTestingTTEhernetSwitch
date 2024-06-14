*** Settings ***
Library    FirmwareVersionCheck

*** Keywords ***
Get Firmware Version
    [Arguments]    
    ${return}    Evaluate    FirmwareVersionCheck.retrieveFirmwareVersionViaSNMP()
    [Return]    ${return}

Compare Firmware Versions
    [Arguments]    
    ${return}    Evaluate    FirmwareVersionCheck.compareTwoFirmwareVersions()
    [Return]    ${return}