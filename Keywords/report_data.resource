*** Settings ***
Library    ReportData

*** Keywords ***
Report File Create
    [Arguments]    ${reportPath}    ${reportDataPath}
    ${result}    Evaluate    ReportData.savePreviousReportFile(${reportPath},${reportDataPath})
    [Return]    ${result}





    