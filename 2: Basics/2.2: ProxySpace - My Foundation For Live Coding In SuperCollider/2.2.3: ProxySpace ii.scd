/*

Using Patterns in ProxySpace

You don't have to be super well versed in patterns to follow this. This will be explained further on in the repo

If you haven't looked at the 'recommended addons' section, please do so now, as you will need some of the Quarks listed to play these examples.

NOTE: If you have come here from ProxySpace i, please quit the server and recompile

*/

//To start, either execute the setup file or run this
("../../Setup/Setup.scd").loadRelative

//Patterns can also be written directly into ProxySpace. They will be synced to ProxySpace's TempoClock
//The tempoclock is initialised at setup by p.makeTempoClock
//The speed of the clock is controlled by modifying this value
p.clock.tempo = 1

//start a basic kick drum pattern
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;

//start a basic snare pattern
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,2,\amp,1);
~sn.play;

//start a basic hi-hat pattern
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,0.25,\amp,Pwhite(0.2,1));
~h.play;

//double the clock speed.
p.clock.tempo = 2

//with p.clock.tempo at 2, one full cyle in the 'dur' argument of patterns happens twice a second, making the BPM 120
//You can get the BPM value of p.clock.tempo by multiplying it by 60
//You can also do this to set the tempo clock by BPM
p.clock.tempo = 135/60

//the proxyspace clock can be pushed very hard, with super low clock speeds resulting in silence as patterns run too slowly (if only patterns are running)
p.clock.tempo = 0.00001

//Extremely high clock speeds will result in extratone-like drums
p.clock.tempo = 20

//Absurd clock speeds will result in hideous crashing and you having to recompile
p.clock.tempo = 999999
//(go on, I dare you)

//anyway...
p.clock.tempo = 135/60

//Patterns can also have fades applied to them, much like the function proxies in the first tutorial
p.fadeTime = 4;

//hear what fades sound like on patterns, either run these one at a time (shift+return) or all at once (ctrl+return)
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][1],\dur,Pwrand([0.25,Pseq([0.125],2)],[0.8,0.2],inf),\amp,Pwhite(0.2,1));
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(5,16)/4,\amp,1);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1);
)

//Note how all the proxies have stayed in time with one-another no problem. This 'just works'.
//I've experimented with using Pdefs in the past, and never managed to get them to quite sync up, or i've had issues syncing Pdefs together.

//let's make things a little less intense
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwrand([0.25,Pseq([0.125],2)],[0.8,0.2],inf),\amp,Pwhite(0.2,1));
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,2,\amp,1)
)

//You can also use Pbinds to specify melodies
(
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,1,\d,0.3,\a,0.6,\pan,0,\amp,1);
~ring1.play;
)

//The beauty of using patterns inside of ProxySpace is that you can build them up element by element, and evaluate as often as you want, building complexity during performance in a way that you and an audience can hear.

//Evaluate these one by one, waiting a little while between each

//i'm going to change one value at a time to really illustrate how these things can build. In performance i'd usually do more than that before re-evaluating a proxy

//1
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,0.25,\d,0.3,\a,0.6,\pan,0,\amp,1)
//2
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,5,\dur,0.25,\d,0.3,\a,Pexprand(0.6,10),\pan,0,\amp,1)
//3
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,Pwrand([5,4,3],[0.6,0.2,0.2],inf),\dur,0.25,\d,0.3,\a,Pexprand(0.6,10),\pan,0,\amp,1)
//4
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,Pwrand([5,4,3],[0.6,0.2,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4,\d,0.3,\a,Pexprand(0.6,10),\pan,0,\amp,1)
//5
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,0,\octave,Pwrand([5,4,3],[0.6,0.2,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4,\d,0.3,\a,Pexprand(0.6,80),\pan,0,\amp,1)
//6
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\root,0,\degree,Prand([0,2,4,6,7],inf),\octave,Pwrand([5,4,3],[0.6,0.2,0.2],inf),\dur,Pbjorklund2(Pwhite(10,15),16)/4,\d,0.3,\a,Pexprand(0.6,80),\pan,0,\amp,1)

//As you can probably imagine, things can get pretty complicated, but let's keep going.

//So far we're running all patterns, but the beauty of ProxySpace means we can run function proxies alongside pattern proxies
~sines = {SinOscFB.ar([36.midicps,48.midicps+1],SinOsc.kr(0.1).range(0.1,1),0.8)}
~sines.play

//You can also use function proxies to effect patterns. I've been told that this shouldn't work, but i've never had much of a problem with it. I'll create another pattern
~sinfb = Pbind(\instrument,\sinfb,\degree,0,\octave,6,\dur,0.25,\amp,0.7,\fb,0.1)
~sinfb.play

//then create a Control Rate proxy to control that pattern
~sinfbControl = {SinOsc.kr(0.1).range(0.1,1.5)}

//then set an argument on the pattern against the control rate proxy
~sinfb.set(\fb,~sinfbControl)

//And you can chain pattern proxies too

//let's add reverb to ~ring
~verb = {FreeVerb.ar(~ring1,1)}
~verb.play

//and make the reverb ridiculous
~verb = {FreeVerb.ar(~ring1,1,1,0.1)}

//and cut the percussion for some ambience
(
~k.stop;
~sn.stop;
~h.stop;
)

//and make another sinfb pattern a fifth above the old one for more ambience
~sinfb2 = Pbind(\instrument,\sinfb,\degree,4,\octave,6,\dur,0.25,\amp,0.7,\fb,0.1)
~sinfb2.play

//make sure it has the control proxy assigned to it too! Or, make another control proxy to get two alternating washes of feedback
~sinfbControl2 = {SinOsc.kr(0.11).range(0.1,1.5)}
~sinfb2.set(\fb,~sinfbControl2)

//slow the whole thing down a little
p.clock.tempo = 120/60

//super loud kick for the head-nodders out there...
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,1,\amp,10);
~k.play;
)

//percussion crossrhythm
(
~p = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,0.75,\amp,1);
~p.play;
)

//alternate the percussion crossrhythm across itself using a task for maximum enjoyment. Also vary the pitch for even maximumer enjoyment.
(
~p.fadeTime = 4;
(
Tdef(\task,{
	loop{
		~p = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,0.75,\amp,1.5,\rate,rrand(1,1.2));
		rrand(1,5).wait;
}});
);
Tdef(\task).play;
)

//really slow euclidean snare hitting just away from the beat
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(5,32)/4,\amp,4);
~sn.play;
)

//raise the tempo because people had time to go to the bar during the ambient section and now people want to dance
p.clock.tempo = 135/60

//and so on, and so on...

//Oh, you want to do some mixing?
//cool, tweak volumes here
//I don't do this much myself during sets but it's worth knowing about
ProxyMixer.new(p)

//note that you can also do this for individual proxies by specifying this argument. It defaults to 1
~sn.vol = 0.1;

~k.vol = 3;

~sines.vol = 0.5;

//I got a bit carried away, but I think i've gone some way to demonstrating the power of ProxySpace when combined with SuperCollider's native functionality.

//start, stop and modify proxies to your heart's content, change the volumes on the ProxyMixer as you wish, and don't forget to free your proxies when done with them!

//when you're finished
(
~k.clear;
~sn.clear;
~h.clear;
~sines.clear;
~ring1.clear;
~p.clear;
~sinfb.clear;
~sinfb2.clear;
Tdef(\task).stop;
)

//or
(
p.clear;
Server.hardFreeAll;
)