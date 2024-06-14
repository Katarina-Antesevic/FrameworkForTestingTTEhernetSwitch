*** Variables ***
${rootDir}    '/home/rtrk/Desktop/robotPractise'

${reportPath}     ${rootDir} + '/Report/Current_Report_Data'
${previousReportDataPath}     ${rootDir} + '/Report/Previous_Report_Data'

${tftpProtocol}    'tftp'
${icmpProtocol}    'icmp'

${pcapDir}     ${rootDir} + '/Pcap_TFTP_File/'
${tftpPcapFilePath}     ${rootDir} + '/Pcap_TFTP_File/tftpPcap.pcap'
${tftpPcapFilePathUpload}     ${rootDir} + '/Pcap_TFTP_File/tftpPcapUpload.pcap'

${tftpFilesPath}    ${rootDir} + '/TFTP_Files' 

${pcapICMPDir}    ${rootDir} + '/Pcap_ICMP_File/'
${icmpPcapFilePath}    '/home/rtrk/Desktop/robotPractise/Pcap_ICMP_File/icmpPcap.pcap'
${icmpJsonFilePath}    ${rootDir} + '/Pcap_ICMP_File/icmpJson.json'

${jsonScript}     ${rootDir} + '/Libraries/Modules/pcap_to_json_parser.py'
${jsonFilePath}     ${rootDir} + '/Pcap_TFTP_File/tftpJson.json'
${jsonFilePathUpload}     ${rootDir} + '/Pcap_TFTP_File/tftpJsonUpload.json'

${textFileToMovePath}     ${rootDir} 
${newPathForMovedTextFile}     ${rootDir} + '/Text_TFTP_Files'
${tftpFileNameForDownload}    'myfile.txt'

${cwdDirForUpload}     '/home/rtrk/Desktop'
${fileForUpload}    'commands.txt'

${configFile}    '/home/rtrk/Desktop/robotPractise/FW_jenkins_download/SWE/FW_S-TT-EPOS-BIN-05-001/SpaceASIC/configuration/TT-EPOS_Firmware-0.14.2-SWE.json'

${windowsIPAddress}    '10.21.10.93'
${linuxIPAddress}    '10.21.10.37'
${interfaceLinux}    'enp3s0'
${hardwareIPAddress}    '10.0.1.5'