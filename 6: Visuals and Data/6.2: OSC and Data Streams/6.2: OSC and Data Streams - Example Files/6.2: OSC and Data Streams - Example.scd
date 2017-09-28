//TODO: make an example using the /netInfo that controls a warp1 Ugen. Also make a Python OSC responder so that you can change the speed of the random number generation on Python side.

//Live data stream examples

//An example using SuperCollider's internal messages, outside of ProxySpace
//set address (if you've already done this no need to do it again)
b = NetAddr.new("127.0.0.1",NetAddr.langPort);
//msg will receive the OSC message as an array, with index 0 being the address and index 1 onwards being the message.
//setting msg[1] as the frequency will give the first parameter of the OSC message as an argument
//setting msg[2] as the pulse width would allow you to send the second message parameter as the pulse width, and so on...
(
OSCdef(\dinger,
	{
		|msg|
		{Pulse.ar(msg[1],rrand(0.01,0.5),0.3)!2 * EnvGen.ar(Env.perc,doneAction:2)}.play
}, '/ding')
)
//make a 900Hz ding
b.sendMsg("/ding",900);
//make a ding at a random pitch
b.sendMsg("/ding",rrand(100,2000))

//An example of using live data
//In this folder there is a Python script: python_randomNumber.py
//To run this you will need Python 2.x and pyOSC (https://pypi.python.org/pypi/pyOSC)
//Once you have got the sketch running, this example should work.
//check that messages are being sent to '/warpPointer', '/warpWindow' and '/warpRate'
OSCFunc.trace
//load setup if you haven't already
("../../../Setup/Setup.scd").loadRelative;
//check this value
NetAddr.langPort
//if it is 57120, continue, if not, close all instances of SuperCollider and start again.
b = NetAddr.new("127.0.0.1", 57120);
//create warp1
~warp1 = {arg pos = 0, winsize = 0.1, rate = 1; Warp1.ar(2,d["lfx"][1],pos,rate,winsize,-1,16,SinOsc.kr(0.01).range(0.0001,0.1),4,0.6)}
//use this OSCdef to use messages coming from Python to change the pointer position of ~warp1
(
OSCdef(\pointerResponder,
	{
		|msg|
		~warp1.set(\pos,msg[1]);
},'/warpPointer')
)
//and the rate
(
OSCdef(\rateResponder,
	{
		|msg|
		~warp1.set(\rate,msg[1]);
},'/warpRate')
)
//and the window size
(
OSCdef(\winSizeResponder,
	{
		|msg|
		~warp1.set(\winsize,msg[1]);
},'/warpWindow')
)