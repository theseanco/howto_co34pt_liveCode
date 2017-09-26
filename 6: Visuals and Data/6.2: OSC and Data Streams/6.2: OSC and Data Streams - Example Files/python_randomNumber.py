# import python modules
import random
import time
import OSC

c = OSC.OSCClient()
c.connect(('127.0.0.1', 57120))


while True:
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/warpPointer")
    oscmsg.append(random.random())
    c.send(oscmsg)
    time.sleep(random.uniform(0.1, 10))
