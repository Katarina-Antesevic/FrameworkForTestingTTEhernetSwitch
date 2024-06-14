from Modules import epos_init
from Modules import ws_preinitialization
from Modules import tte_epos_snmp
from Modules import tte_epos_snmp_objects
from Modules import tte_param_file_parser as param_file
import re


fw_version_snmp = ""

#Helper function
def version(fw_ver):
    """Returns firmware version.

    Parameters:
        Version read with SNMP.
    Returns:
        major.minor.patch.
    """
    patch = str(fw_ver & 0xffff)
    minor = str((fw_ver >> 16) & 0xff)
    major = str((fw_ver >> 8) & 0xff)
    return major + "." + minor + "." + patch

def retrieveFirmwareVersionViaSNMP():
    returnSt = ""

    fw_ver = tte_epos_snmp.get_request(tte_epos_snmp_objects.TTE_SW_SPACE_FW_VERSION)
    fw_ver = int(fw_ver.replace(" ", ""), 16)
    versionFw = version(fw_ver)

    global fw_version_snmp
    fw_version_snmp = versionFw

    returnSt += f"Firmware version retrieved via SNMP: {fw_version_snmp}"

    return returnSt


def compareTwoFirmwareVersions():
    returnSt = ""

    ini_file_instance = param_file.ParametersParser.get_instance()
    ini_file_param_ver = ini_file_instance.get_current_config_param(param_file.ParamName.TT_PARAM_NAME_CURRENT_FW_VERSION)

    version_ini_file = re.search('\d+\.\d+\.\d+', ini_file_param_ver).group(0)
    
    global fw_version_snmp
    if fw_version_snmp == version_ini_file:
        returnSt += f"Firmware version retrieved via SNMP ({fw_version_snmp}) is equal to firmware version read from .ini file ({version_ini_file})"
    else:
        raise Exception("Firmware version retrieved via SNMP is NOT equal to firmware version read from .ini file")

    return returnSt

