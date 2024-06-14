import time, json
from FIP import Flash
from distutils.command.config import config
from FIP import Interface
from Modules.tte_epos_helper_functions import reset_ft232
from Modules.tte_epos_globals import Test_Timeout
from Modules import tte_epos_helper_functions


startOfSharedMemory = 537261056
startOfSharedMemoryHex = 0x2005f400
valueOnstartOfSharedMemory=0x534D0300
constantValue = 0x87654321
firmwareTypeIdentifier = 0x45500101
interface = None

def firmwareIntoOperationalState():
    global interface
    interface = Interface.ft232("TT5YRQXL", 115200)
    interface.reset_swe()
    time.sleep(Test_Timeout.RESET_TIMEOUT)

    return "Firmware is in OPERATIONAL mode"


def testStartOfSharedMemory(configFile):
    returnSt = ""
    global interface
    interface = Interface.ft232("TT5YRQXL", 115200)

    f = open(configFile)
    data = json.load(f)
    fl = data['product configuration']['flash'][0]

    Flash.Flash(fl).setup_asic(interface)
    
    address1 = interface.read_32(0x20000000)
    address2 = interface.read_32(0x20001000)

    if(hex(address2) != hex(startOfSharedMemory)):
        raise Exception("Start of shared memory is not correct!")

    #returnSt += f"\nValue on address 0x20000000: {hex(address1)}"
    returnSt += f"Value on address 0x20001000: {hex(address2)}, i.e. Start of shared memory" 

    return returnSt


def valueOnStartOfSharedMemoryAddress():
    returnSt = ""
    value = interface.read_32(startOfSharedMemoryHex)

    if(value != int(0x534d0300)):
        raise Exception(f"Value on address {hex(startOfSharedMemoryHex)} is not correct!")
    returnSt += f"Value on address {hex(startOfSharedMemoryHex)}: {hex(value)}, i.e. Interface Version number " 

    return returnSt


def valueForOffset0x0004():
    returnSt = ""
    offset = startOfSharedMemoryHex+0x0004
    value = interface.read_32(offset)

    if(value != int(constantValue)):
        raise Exception(f"Value on address {hex(offset)} is not correct!")
    
    returnSt += f"Value on address {hex(offset)}: {hex(value)}, i.e. Constant value " 

    return returnSt


def valueForOffset0x0008():
    returnSt = ""
    offset = startOfSharedMemoryHex+0x0008

    value = interface.read_32(offset)

    if(value != int(firmwareTypeIdentifier)):
        raise Exception(f"Value on address {hex(offset)} is not correct!")
    
    returnSt += f"Value on address {hex(offset)}: {hex(value)}, i.e. Firmware type identifier " 

    interface.close()
    return returnSt


def valueForOffset0x0010():
    returnSt = ""
    offset = startOfSharedMemoryHex+0x0010
    #global interface 
    value = interface.read_32(offset)
    returnSt += f"Value on address {hex(offset)}: {value}, i.e. IP address " 

    interface.close()
    return returnSt
