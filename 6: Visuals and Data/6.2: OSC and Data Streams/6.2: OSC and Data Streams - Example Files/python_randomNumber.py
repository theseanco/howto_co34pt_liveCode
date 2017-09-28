# import python modules
import random
import time
import OSC

# Connect to SuperCollider's internal port
c = OSC.OSCClient()
c.connect(('127.0.0.1', 57120))

# Repeatedly send random messages which will be turned into a Warp1 Ugen pointer in ProxySpace
while True:
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/warpPointer")
    oscmsg.append(random.random())
    c.send(oscmsg)
    time.sleep(random.uniform(0.1, 1))
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/warpRate")
    oscmsg.append(random.uniform(0.1,3))
    c.send(oscmsg)
    time.sleep(random.uniform(0.1,1))
    oscmsg = OSC.OSCMessage()
    oscmsg.setAddress("/warpWindow")
    oscmsg.append(random.uniform(0.01,0.9))
    c.send(oscmsg)
    time.sleep(random.uniform(0.1,1))
