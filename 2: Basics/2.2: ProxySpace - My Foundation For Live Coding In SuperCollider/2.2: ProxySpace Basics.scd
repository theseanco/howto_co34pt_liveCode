//SuperCollider ProxySpace tutorial. See ProxySpace.md for explanation.

//Live coding can unexpectedly get loud. Always use protection
StageLimiter.activate

//1: Proxies and patching
//In ProxySpace you live code SuperCollider much like you would live patch a modular synth

//A pair of sine waves:
{SinOsc.ar([400,500],0,0.1)}.play;

//stop the server (Ctrl/Cmd+.)
Server.hardFreeAll

//Start ProxySpace
p = ProxySpace.push(s);

//make the basic sine wave again, but with a named proxy
/*
A few notes:

Proxies work on a couple of naming conventions, one is:

~foo123 (has to start with a lowercase letter)

or:

p[\name]

single letter variables can't hold a proxy, I generally use them to hold other things such as lists if I need them during performances.

I don't know why single letter variables don't work. They just don't.

You also can ONLY store proxies in those two naming conventions. If you need to store lots of variables elsewhere, i'd suggest making a dictionary on a single letter variable to refer to later.

*/
~sine1 = {SinOsc.ar([400,500],0,0.1)};

//play those sine waves
~sine1.play;

//change the frequency of those sine waves instantly
~sine1 = {SinOsc.ar([500,600],0,0.1)};

//add a fade to ProxySpace
p.fadeTime = 3;
//you can also assign individual fade times to proxies
~sine1.fadeTime = 3;

//change the frequencies again and hear a fade
~sine1 = {SinOsc.ar([200,300],0,0.1)};

//make a second sine wave and play it alongside the first
~sine2 = {SinOsc.ar([350,450],0,0.1)};
~sine2.play;

//add modulation to the second sine wave
~sine2 = {SinOsc.ar([350+Saw.kr(1,100),450+Saw.kr(0.99,100)],0,0.1)};

//stop the two sine waves
~sine1.stop;
//stops can also be faded
~sine2.stop(5);

//make two modulated saw waves
~saw = {Saw.ar([LFNoise1.kr(0.1).range(8,12),LFNoise1.kr(0.1).range(8,12)],2)}

//Amplitude modulate the original second sine with the saw
~sine2 = {SinOsc.ar([350,450],0,0.1*~saw)};
~sine2.play

//frequency modulate the sine wave with the saw
~sine2 = {SinOsc.ar([350,450]*~saw,0,0.1)};

~sine2.stop;

//you can also combine proxies in a new proxy for modulation
~modSine = {~sine2 * ~saw}
~modSine.play

//mix in other proxies
~modSine = {Mix.ar([~sine1 * ~saw,~sine2]) * ~saw}

//Create an effects proxy, to send other proxies to
//(note the multichannel expansion in ~delay)
~delay = {CombN.ar(~modSine,0.2,[0.2,0.21],2,1)}
~delay.play

//Create another effects proxy, just for fun
~decimator = {Decimator.ar(~delay,2205,10)}
~decimator.play

//Note that when you create a new proxy, the old one will always keep going, so chaning like this will keep sounding more and more layers unless you stop the existing ones
~modSine.stop
~delay.stop

/*

Note, if you .stop a proxy, it will keep running in proxyspace, but it won't be sounding (but if it is affecting any other proxies it will still do so).

This means that if you have any particularly CPU intensive proxies running but not sounding, or affecting any other proxies, and you don't intend to use that proxy again, you should use the .free method to kill them completely:

i.e. (don't evaluate these now)
~modSine.free
~delay.free

*/


//You can plug any part of this proxy chain into any other part (but not a proxy into itself)
//This can get very loud and unruly very quickly.

//plugging the end of the effects chain back into the frequency of the first sine wave, this will get some nice modulation
~sine1 = {SinOsc.ar([200,300]* ~decimator,~delay * ~saw,0.4 * ~decimator)};

//plugging the results of the delay back into the delay again. This will get unruly and REALLY loud.
//Turn down your volume. You have been warned.
~delay = {CombN.ar(~modSine+~decimator,0.2,[0.2,0.21],2,1)}

//note, you can't plug a proxy into itself.
//see also: dividing by zero
~delay = {CombN.ar(~modSine,0.2,[0.2,0.21]*~delay,2,1)}

//free all proxies in ProxySpace.
//wasn't that fun?
p.clear

//For using patterns in ProxySpace, see ProxySpace ii
