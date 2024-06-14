*** Settings ***
Library    TFTPUploadDefaultFiles

*** Keywords ***
TFTP Upload Default Files
    [Arguments]
    ${return}    Evaluate    TFTPUploadDefaultFiles.uploadDefaultFilesViaTFTP()
    [Return]    ${return}