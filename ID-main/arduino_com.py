import serial

msg = ""


def traitement_reception(msg):
    print(msg)
    index1 = msg.find("A")
    index2 = msg.find("B")
    index3 = msg.find("C")
    distance = str(msg[index1+1:index2-1])
    clap = str(msg[index2+1:index3-1])
    eau = str(msg[index3+1:])
    print("A"+distance+"B"+clap+"C"+eau+"\n")
    return 0,0,0
    

try:
    #arduino1=serial.Serial("COM4",timeout=1)
    arduino2=serial.Serial("COM5",timeout=1)
except:
    print("Verifier le port utilise")


while True:
    #print("COM4:",arduino1.readline())
    msg = arduino2.readline()
    distance,eau,clap = traitement_reception(msg)

