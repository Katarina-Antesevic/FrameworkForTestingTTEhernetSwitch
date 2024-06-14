*** Settings ***
Library    SnmpDsuPinStateCheck

*** Keywords ***
Set Dsu Pin To Low
    [Arguments]    
    ${result}    Evaluate    SnmpDsuPinStateCheck.dsuPinToLow()
    [Return]    ${result}

SNMP Dsu Pin State Check Low
    [Arguments]    
    ${result}    Evaluate    SnmpDsuPinStateCheck.checkDsuPinSnmpLow()
    [Return]    ${result}

Set Dsu Pin To High
    [Arguments]
    ${result}    Evaluate    SnmpDsuPinStateCheck.dsuPinToHigh()
    [Return]    ${result}

SNMP Dsu Pin State Check High
    [Arguments]
    ${result}    Evaluate    SnmpDsuPinStateCheck.checkDsuPinSnmpHigh()
    [Return]    ${result}

Firmware Into Operational State
    [Arguments]
    ${result}    Evaluate    SnmpDsuPinStateCheck.getFirwmwareIntoOperationalState()
    [Return]    ${result}
