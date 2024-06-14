import time, threading, os, subprocess,  json
from Modules import tcp_dump
from Modules import epos_init
from Modules import ws_preinitialization
from Modules.tte_epos_helper_functions import reset_ft232
from Modules.tte_epos_globals import Test_Timeout


def performingPreInitializationStepsOFTheTestEnvironment():
    returnStatement = ""
    
    returnStatement += f"- EPOS interface {epos_init.interface_EPOS} has IP address {epos_init.WS_EPOS_IP}\n"
    returnStatement += ws_preinitialization.do_preinitialization()
    
    return returnStatement
    

def getFirwmwareIntoOperationalMode():
    reset_ft232()
    time.sleep(Test_Timeout.RESET_TIMEOUT)

    return "Firmware is in OPERATIONAL mode"


def createPcapFileBasedOnICMPRequest(harwareIpAddress, pcapFilePath):
    returnStatement = "" 
    
    t1 = threading.Thread(target=tcp_dump.tcpDumpIcmp , args=(pcapFilePath,epos_init.interface_EPOS))
    
    t1.start()
    time.sleep(2)

    #p = subprocess.Popen(cmd_line, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    cmd_line = f"ping -c {tcp_dump.numberOfICMPRequests} {harwareIpAddress}"
    proc = subprocess.run(cmd_line, stdout = subprocess.PIPE, stderr = subprocess.PIPE, shell=True)
    
    returnStatement += f"Created {tcp_dump.numberOfICMPRequests} ICMP ping requests"
    
    t1.join()
    pcap = pcapFilePath.split('/')
    pcapFileName = pcap[len(pcap)-1]
    
    if os.path.exists(pcapFilePath):
        returnStatement += f"\nPcap file {pcapFileName} created"
    else:
        raise Exception("Pcap file is NOT created")

    return returnStatement


def deletePcapFile(filePath):
	fN = filePath.split('/')
	fileName = fN[len(fN)-1]
	if os.path.exists(filePath):
		os.remove(filePath)
		if not os.path.exists(filePath):
			return "Previously created file %s deleted"%fileName
		else:
			raise Exception("Previously created file %s NOT deleted"%fileName)
	else:
		return "Pcap file %s doesn't exists or is already deleted"%fileName


def createJsonFileFromPcapFile(protocol, pcapFilePath, jsonFilePath, jsonScript):
	if os.path.exists(jsonFilePath):
		os.remove(jsonFilePath)

	time.sleep(1)

	cmd = "python %s %s %s %s"%(jsonScript, protocol, pcapFilePath, jsonFilePath)
	out_str = subprocess.check_output(cmd, shell=True)

	file = jsonFilePath.split("/")
	jsonFileName = file[len(file)-1]

	result = out_str.decode('UTF-8')
	if "created" in result:
		return "Json file %s created"%jsonFileName
	else:
		raise Exception("Json file %s NOT created"%jsonFileName)


def parseJsonFileIcmp(jsonFilePath):
    returnStatement = ""
    with open(jsonFilePath,'r') as f:
        json_obj = json.load(f) #json_obj is list
		    
        data_len = 0
        dict = {}
        returnStatement = ""
        responseCounter = 0.0

        for data in json_obj:
            if len(json_obj) <= 1:
                raise Exception("Error occured!")

            icmp_type = data['_source']['layers']['icmp']['icmp.type']
            if icmp_type == '0': #icmp reply
                responseCounter += 1.0
                icmp_sequence_number = data['_source']['layers']['icmp']['icmp.seq']
                icmp_reply_time = float(data['_source']['layers']['icmp']['icmp.data_time_relative'])
                dict.update({icmp_sequence_number:icmp_reply_time})

        if responseCounter < tcp_dump.numberOfICMPRequests:
            raise Exception("Not every request has response!")
        
        for key, value in dict.items():
            if value >= 2.00:
                raise Exception(f"ICMP ping reply number {key} is longer than 2 s")

        index = 1
        for key, value in dict.items():
            if index == int(key):
                returnStatement += "Response time for ICMP ping request number %s - %f s\n"%(key, value)

            index += 1

    returnStatement += "\nAll ICMP replies are shorter than 2 s"
    return returnStatement
