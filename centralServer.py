from flask import Flask
import paho.mqtt.client as mqtt
from threading import Lock
from SensorServer import SensorServer
import threading
import time
import json

def deployServers(schematic):
    slotNames = schematic.keys()
    portToSet = 2000
    for slot in slotNames:
        print("[CENTRAL] DEPLOYING "+slot)
        slotSchematic = schematic[slot]
        a = SensorServer(slot,str(portToSet))
        a.startVirtualSensors(slotSchematic)
        t = threading.Thread(target=a.startBroadcastingResults)
        t.start()
        portToSet +=1
    print("[CENTRAL] DEPLOYMENT SUCCESSFUL")
    time.sleep(1)

def connectToMQTT():
    client =mqtt.Client("CENTRAL")
    client.on_message=on_message
    client.connect("127.0.0.2")
    client.loop_start()
    client.subscribe("centralServer")

def on_message(client, userdata, message):
    global lock
    global database

    #print("newMessage =",str(message.payload.decode("utf-8")))
    received = str(message.payload.decode("utf-8"))
    [slotName,values] = received.split(";")
    dataToStore = json.loads(values)
    with lock:
        database[slotName] = dataToStore



#with open('Schematic.json', 'w') as f:
#    json.dump(schematic,f)

with open('Schematic.json', 'r') as f:
    schematic = json.load(f)

lock = Lock()
database = dict()

deployServers(schematic)
connectToMQTT()


app = Flask(__name__)

@app.route("/")
def giveData():
    global lock
    global database
    with lock:
        return json.dumps(database)

app.run(debug=False)
