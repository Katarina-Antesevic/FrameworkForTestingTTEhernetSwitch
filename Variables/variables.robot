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
