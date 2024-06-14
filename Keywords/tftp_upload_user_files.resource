*** Settings ***
Library    TFTPUploadUserFiles

*** Keywords ***
TFTP Upload User Files    
    [Arguments]
    ${return}    Evaluate    TFTPUploadUserFiles.uploadUserFilesViaTFTP()
    [Return]    ${return}


