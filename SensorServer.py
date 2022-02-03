import time
from ivy.ivy import IvyServer
from threading import Lock
from GenericSensor import GenericSensor
import threading
import paho.mqtt.client as mqtt


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
    
    def startVirtualSensors(self, jsonSchematic):
        print(self.name+" : Starting up the sensor server connected to the port : "+self.sensorPort)
        listOfThreads = []
        listOfSensors = []
        
        sensorNames = jsonSchematic.keys()
        
        for sensor in sensorNames:
            sensorValues = jsonSchematic[sensor]
            listOfSensors.append(GenericSensor(sensorValues["min"],sensorValues["max"],self.sensorPort,sensor))
            listOfThreads.append(threading.Thread(target=listOfSensors[-1].startSensor))
            listOfThreads[-1].start()
        print(self.name+" : All the sensors are connected, things are now in motion that cannot be undone")


if __name__ == '__main__':

    schematic = {
                    "raphaelo": {
                            "min" : 80,
                            "max" : 100
                    },
                    "donatello": {
                            "min" : 150,
                            "max" : 200
                    },
                    
                    "leonardo": {
                            "min" : 0,
                            "max" : 10
                    },
                    
                    "michelangelo": {
                            "min" : 0,
                            "max" : 1000
                    }
                    
                }

    a = SensorServer("kek","2010")
    a.startVirtualSensors(schematic)
    client =mqtt.Client("Hellochief")
    print(client.connect("localhost"))
    client.subscribe("caca")

    while True:
        print("help")
        client.publish("/hello","100")
        time.sleep(1)