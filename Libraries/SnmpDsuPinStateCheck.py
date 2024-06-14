import time
from Modules import tte_epos_serial
from Modules.tte_epos_serial import TTE_Serial_Number as ser_id
from Modules.tte_epos_globals import USE_CASE
from Modules import tte_epos_snmp
from Modules import tte_epos_snmp_objects
from FIP import Interface
from Modules.tte_epos_globals import Test_Timeout
from Modules import tte_epos_helper_functions


interface = None

def dsuPinToLow():
    returnSt = ""

    global interface
    interface = tte_epos_serial.TTE_EPOS_FT232(ser_id[USE_CASE])
    dsu = interface.disable_dsu()
    time.sleep(2)

    dsu_state = interface.dsu_enabled() #returns 1 if dsu enabled
   
    if not dsu_state:
        returnSt += "DSU_EN pin state changed to low. DSU_EN pin disabled."
    else:
        raise Exception("DSU_EN pin state NOT changed.")

    return returnSt

def checkDsuPinSnmpLow():
    returnSt = ""

    dsu_state = tte_epos_snmp.get_request(tte_epos_snmp_objects.TTE_SW_SPACE_INPUT_PIN_DSU_EN)
    if dsu_state == "0":
        returnSt += "DSU_EN pin state is set to low."
    else:
        raise Exception("DSU_EN state is NOT set to low.")

    return returnSt

def dsuPinToHigh():
    returnSt = ""

    global interface
    dsu = interface.enable_dsu()
    time.sleep(2)

    dsu_state = interface.dsu_enabled()
    if dsu_state:
        returnSt += "DSU_EN pin state changed to high. DSU_EN pin enabled."
    else:
        raise Exception("DSU_EN pin state NOT changed.")

    return returnSt

def checkDsuPinSnmpHigh():
    returnSt = ""

    tte_epos_helper_functions.finish_test(None, True, interface)

    dsu_state = tte_epos_snmp.get_request(tte_epos_snmp_objects.TTE_SW_SPACE_INPUT_PIN_DSU_EN)
    if dsu_state == "1":
        returnSt += "DSU_EN pin state is set to high."
    else:
        raise Exception("DSU_EN state is NOT set to high.")
    
    return returnSt
