*** Settings ***
Library    TftpDownload

*** Keywords ***
Clear Directory
    [Arguments]    ${dest_path}
    ${result}    Evaluate    TftpDownload.clearMyDirectory(${dest_path})
    [Return]    ${result}

TFTP Download Files
    [Arguments]    ${dest_path}
    ${result}    Evaluate    TftpDownload.downloadFilesViaTftp(${dest_path})
    [Return]    ${result}

