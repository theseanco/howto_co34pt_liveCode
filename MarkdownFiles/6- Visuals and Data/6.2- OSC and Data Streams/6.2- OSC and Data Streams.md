# OSC Communication and Data Streams

--------------

I have done a set of performances that revolve around live coding and using data streams in the past, particularly performances where I have a continuous stream of data to interpret during the performance. These performances involve negotiating my relationship with sensor data (e.g. movement data, temperature, light levels), live-coding my interpretation of this data to deliver a performance.

For this type of performance I have used a particular set of technologies mutliple times, and have developed a reasonably quick way to work, which I will share here. Depending on the kind of data you want to use, some of the items described in this part of the guide may not apply to you directly, but using OSC to handle messages in SuperCollider is a really useful skill that can apply to many types of situation, so it's worth knowing if you want to work outside of SuperCollider at all.

[Open Sound Control](http://opensoundcontrol.org/introduction-osc) (hereafter OSC) is an _absurdly_ useful protocol for communicating between programs, and across networks.

Before I learned how to use it I heard people refer to it a lot as 'modern MIDI', which I think is a bit of a misnomer and actually confused me quite a lot while learning it as someone used to MIDI a la DAWs and plugging cables into synthesizers. While MIDI is a set of commonly understood messages between programs (plug a MIDI cable into an interface and you can expect your DAW to react in a certain way), OSC is more of a 'common language' that enables programs to communicate effectively. OSC is very useful for getting multiple programs and machines to 'talk' to each other, and I have found it very useful for performances involving multiple programs and machines running together.

For example:

[sampler-sampler](https://www.youtube.com/watch?v=dY6oSwoRRho) uses OSC to communicate information about emulated stitching between two machines and multiple programs:

`MACHINE 1: Processing -> MACHINE 2: SuperCollider -> Processing`

[tome.](http://www.charliedearnley.com/portfolio/tome/) uses OSC to parse sensor data and manage lighting.

`Sensor array (serial data) -> [Python Serial Parser](https://github.com/theseanco/python-SerialToOSC) -> SuperCollider -> QLCPlus -> OpenDMXUSB`

While the above setups might seem complex or convoluted, using OSC makes these connections very easy, and using OSC is very similar across platforms.

It's first worth understanding a bit about how OSC sends its messages:

OSC Messages are sent over a network, and that network can be internally within a machine (to sent messages between programs), or across machines in a network of any kind (commonly a local network). Messages are sent to a particular port of a particular network address (for example, 127.0.0.1, port 51720), with an address (for example /hello), and parameters that can be [of various types](http://opensoundcontrol.org/spec-1_0) (for example 1, 32.32, 'message').

Sending this message from SCLang to be received by SCLang internally would look like this (adapted from the [OSC Communication tutorial](http://doc.sccode.org/Guides/OSC_communication.html)):

```supercollider
//monitor all incoming OSC Messages
OSCFunc.trace;
//set the relevant IP and port - both arbitrary, but these will be sent to SuperCollider internally (assuming that NetAddr.langPort == 57120)
b = NetAddr.new("127.0.0.1", 57120);
//send the above message, and it should be shown in the post window
b.sendMsg("/hello", 1, 32.32, 'message')
// If this doesn't work, evaluate:
NetAddr.langPort
// Then change the port of NetAddr.new accordingly
```

This is the basic way to send OSC Messages using SuperCollider. These messages can be sent to any IP and port, and the message will be sent regardless whether or not it is received. In order for the message to mean anything, a receiver will have to be built to interpret the message.

Taking the above example, here is a simple setup that will make a sound every time a message is sent to address `/ding`, it uses a class called `OSCdef` which triggers a particular function when an OSC message is received:

```supercollider
// set address
b = NetAddr.new("127.0.0.1",NetAddr.langPort);
// create OSCdef (very similar syntax to SynthDef)
(
OSCdef(\dinger,
	{
    // a simple function that triggers an envelope
		{Pulse.ar(1000,rrand(0.01,0.5),0.3)!2 * EnvGen.ar(Env.perc,doneAction:2)}.play
}, '/ding')
)
// Send a message with no parameters. It'll trigger the function within the OSCdef.
b.sendMsg("/ding")
```

There are a few tools for diagnosing issues with OSC use in SuperCollider, and we have touched on both of them here. To check if messages from another application are being received correctly, evaluate `OSCFunc.trace(true)`, which will print all incoming OSC messages to the post window (incluing any internal communications within sclang). If you are expecting to recieve messages to SuperCollider and they're not coming through (the default port of 57120 is where I usually direct all my messages), evaluate `NetAddr.langPort` to check the internal server port, as it can be re-assigned through multiple instances of SClang.

Messages sent over OSC can also be interpreted and passed into these functions, here is an elaboration on the above example, using a message to set the pitch of the sound:

```supercollider
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
```

In terms of using live data, and live coding your response to the data, the OSCdef can be changed and re-evaluated on the fly, changing data mappings and using OSCdefs to send messages to various items running on the server, and this fits into ProxySpace very nicely. In order to use live data however, you need a live data source, which is not readily available from within SuperCollider - check the examples folder for a Python script which simulates a live data input to be used in a live coding context, covering inter-program communication and live-mapping of data.

If you are wanting to use data from an Arduino to get data into SuperCollider, I wrote [this tool](https://github.com/theseanco/python-SerialToOSC), which generates Python scripts based on a specification you provide that parses Serial data and sends it as a high-speed OSC stream, for which you can build custom OSCdefs in SuperCollider.
