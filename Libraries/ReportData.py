import os
import time
import shutil
from datetime import datetime


def savePreviousReportFile(reportPath, reportDataPath):

    if os.path.exists(reportPath+'/report.html') and os.path.exists(reportPath+'/log.html'):

        directoryName = time.ctime(os.path.getctime(reportPath+"/report.html"))
        
        directoryName = str(directoryName).replace("    ", "_")
        directoryName = str(directoryName).replace("  ", "_")
        directoryName = str(directoryName).replace(" ", "_")
        
        parts = directoryName.split("_")
        directoryName = parts[1]+"_"+parts[2]+"_"+parts[4]+"_"+parts[3]

        directoryPath = reportDataPath+"/"+directoryName

        if not os.path.exists(directoryPath):
            os.makedirs(directoryPath)

        shutil.copyfile(reportPath+'/report.html',
                        directoryPath+'/report.html')
        shutil.copyfile(reportPath+'/log.html', directoryPath+'/log.html')

        if not os.path.exists(directoryPath+'/report.html'):
            raise Exception(directoryPath+'/report.html' +
                            " file is not created")

        if not os.path.exists(directoryPath+'/log.html'):
            raise Exception(directoryPath+'/log.html'+" file is not created")

        return f"Previously created report.html and log.html files saved in directory {directoryName}"
    else:
        return "No test suite has been run yet"