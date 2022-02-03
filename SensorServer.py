import time
from ivy.ivy import IvyServer
from threading import Lock
from GenericSensor import GenericSensor
import threading
class SensorServer(IvyServer):
    
    def __init__(self, name,port):
        self.lock = Lock()
        self.sensorValues = dict()

        IvyServer.__init__(self,name)
        self.name = name
        self.sensorPort = port
        self.text = ""
        self.bind_msg(self.handleSensor, "(.*);(.*)")
        self.start('127.255.255.255:'+port)
        time.sleep(1)



    def handleSensor(self,sender,sensorName,sensorValue):
        with self.lock:
            self.sensorValues[sensorName] = sensorValue
    
    def startVirtualSensors(self):
        raphaelo     = GenericSensor(80,100,self.sensorPort,"Raphaelo")
        threadR = threading.Thread(target=raphaelo.startSensor)
        threadR.start()

        donatello    = GenericSensor(150,200,self.sensorPort,"Donatello")
        threadD = threading.Thread(target=donatello.startSensor)
        threadD.start()

        leonardo     = GenericSensor(0,10,self.sensorPort,"Leonardo")
        threadL = threading.Thread(target=leonardo.startSensor)
        threadL.start()

        michelangelo = GenericSensor(0,1000,self.sensorPort,"Michelangelo")
        threadM = threading.Thread(target=michelangelo.startSensor)
        threadM.start()
        pass


if __name__ == '__main__':
    a = SensorServer("kek","2010")
    a.startVirtualSensors()