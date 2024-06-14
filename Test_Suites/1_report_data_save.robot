*** Settings ***
Resource    ../Variables/variables.robot
Resource    ../Keywords/report_data.resource
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
...    ${\n}Purpose of the test is to check if previous report data is saved. 
...    ${\n}==========================================================================================


*** Test Cases ***
Save Previous Report Data
    [Documentation]    Save report.html and log.html file created in directory Current_Report_Data 
    ...                when previous test was run, in specific directory created in directory Previous_Report_Data
    ${result}    Report File Create    ${reportPath}     ${previousReportDataPath}
    Set Test Message    ${result}
