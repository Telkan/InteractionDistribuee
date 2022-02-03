from ivy.ivy import IvyServer
from time import sleep
import random
import threading

class GenericSensor(IvyServer):
    def __init__(self, minValue, maxValue, port,name):
        self.minValue = minValue
        self.maxValue = maxValue


        IvyServer.__init__(self,name)
        self.name = name
        self.start('127.255.255.255:'+port)
        sleep(1)

    def startSensor(self):
        while(True):
            sensorValue = int(random.random()*(self.maxValue-self.minValue) + self.minValue)
            self.send_msg(self.name+";"+str(sensorValue))
            sleep(random.random())

if __name__ == '__main__':
    b = GenericSensor(500,1000,'2010',"Jim")
    b.startSensor()