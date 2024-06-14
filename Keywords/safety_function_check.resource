*** Settings ***
Library    SafetyFunctionCheck

*** Keywords ***
Check Safety Relevant Function
    [Arguments]    
    ${result}    Evaluate    SafetyFunctionCheck.uploadUserFileViaTFTP()
    [Return]    ${result}