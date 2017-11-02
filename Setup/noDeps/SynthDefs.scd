/*

coï¿¥ï¾¡pt SynthDef library

used as part of howto_co34pt_livecode

*/
(
/*

vplaym: enveloped mono buffer player
For mono buffers only

Arguments:

out = Channel out
buf = Buffer index
rate = Speed of playback
amp = volume
pan = pan (stereo)
atk = attack
rel = release
pos = position to start playback from 0 to 1

*/

SynthDef(\vplaym,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, atk=0.01, rel=1, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0.0,1));
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

/*

vplay: enveloped stereo buffer player
For stereo buffers only
The default is to have no attack, as I use this to create a 'chopped-up' effect

Arguments:

out = Channel out
buf = Buffer index
rate = Speed of playback
amp = volume
pan = pan (stereo)
atk = attack
sus = sustain
rel = release
pos = position to start playback from 0 to 1

*/

SynthDef(\vplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, atk=0.0, sus=1, rel= 0, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(atk,sus,rel,1),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

/*

wtabl: wavetable synth using looped buffers via PlayBuf

out = channel out
buf = buffer index. This should be a wavetable buffer, but it *can* be anything
freq = frequency of the buffer, this can be used in conjunction with scale/degree/octave
amp = volume
pan = pan in stereo
atk = attack
rel = release

*/

SynthDef(\wtabl,
	{arg out = 0, buf = 0, freq = 300, amp = 0.5, pan = 0, atk=0.01, rel=1;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) *freq,1,0,1),pan);
		env = EnvGen.ar(Env.perc(atk,rel),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

/*
(
//SynthDef based on an overdriven DFM1 - this is very CPU intensive
//Using resonance values of >1 only will sound the freq value and detune it.
//good for stabs, but is buggy
SynthDef(\dfm1, {
	arg out = 0, freq = 440,mul = 0.5, res = 1,type = 0, noise = 0.0003, atk = 0.01, rel = 1;
	var sig, env;
	env = EnvGen.ar(Env.perc(atk,rel),doneAction:2);
	sig = DFM1.ar(SinOsc.ar,freq,res,1,type,noise,mul);
	sig = sig*env;
	Out.ar(out,Splay.ar([sig]));
}).add;
);
*/

/*

bplay: basic stereo buffer player
This is the bread and butter of my SynthDef library
Designed for simple repeated playback of stereo buffers inside of a pattern
TODO: This - Stereo samples are currently mixed down to mono and positioned in a stereo field by using the Pan2 Ugen. I'm going to correct this soon

out = channel out
buf = buffer index
rate = rate of playback (or pitch)
amp = volume
pan = stereo panning of sample
pos = position of playback (usually not used)
rel = release (usually not used, this is only really in case I accidentally play a sample backwards, and need the synth to free at some point in the future, or schedule very long samples to be played. This is a security measure in case I box my processor.)

*/

SynthDef(\bplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;

/*

bplaym: basic mono buffer player
Designed for simple repeated playback of mono buffers inside of a pattern

out = channel out
buf = buffer index
rate = rate of playback (or pitch)
amp = volume
pan = stereo panning of sample
pos = position of playback (usually not used)
rel = release (usually not used, this is only really in case I accidentally play a sample backwards, and need the synth to free at some point in the future, or schedule very long samples to be played. This is a security measure in case I box my processor.)

*/

SynthDef(\bplaym,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

/*

bplaymr: basic reversed mono buffer player
plays back a mono sample in reverse. I designed this for a specific instance but kept it in the setupfile because why not. It takes away some of the extra work needed to schedule the playing of backward sample within my other SynthDefs

out = channel out
buf = buffer index
rate = rate of playback (or pitch)
amp = volume
pan = stereo panning of sample
pos = position of playback (usually not used)
rel = release (usually not used, this is only really in case I accidentally play a sample backwards, and need the synth to free at some point in the future, or schedule very long samples to be played. This is a security measure in case I box my processor.)

*/


SynthDef(\bplaymr,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=3;
		var sig,env ;
		sig = Pan2.ar(PlayBuf.ar(1,buf,rate.neg,1,BufDur.kr(buf)*44100-2,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

/*

lplay - a looping player for stereo samples that uses the dur value to automatically pitch samples for looping over a given number of beats. I built this to grab a bunch of drum loops and percussion loops at roughly the correct tempo and use them at the clock rate of my set.

out = channel out
buf = buffer index
amp = volume
pan = stereo panning
rel = release (mostly here to prevent runaway PlayBufs)
dur = duration, in beats, that you would like your sample scaled to. For example a sample played over 8 beats would have a dur of 8 specified. Note that this repitches the sample in order to scale it to the correct beat, so it could end up at a _very_ different pitch

*/
SynthDef(\lplay,
	{arg out = 0, buf = 0, amp = 0.5, pan = 0, rel=15, dur = 8;
		var sig,env ;
		sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * ((BufFrames.ir(buf)/s.sampleRate)*p.clock.tempo/dur),1,0,doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;

/*

bpfsaw: an instrument by Eli Fieldsteel as part of his SuperCollider tutorial series
A detuned slow-enveloped saw wave which sounds lush and beautiful, especially with some extended chords
Has a lot of arguments,

atk = attack
sus = sustain
rel = release
ts = timescale of the envelope
c1 = start of envelope curve
c2 = end of envelope curve
freq = frequency
detune = detuning (multiple of frequency), works well with low values, higher ones get quite silly
pan = panning in stereo
cfhzmin = minimum modulation of filter frequency
cfhzmax = maximum modulation of filter frequency
cfmin = minimum filter frequency
cfmax = maximum filter frequency
rqmin = controls filter sweeping. Lower values = greater effects of filtering
rqmax = controls filter sweeping. Lower values = greater effects of filtering
lsf = frequency at which low shelf is activated
ldb = low shelf boost (in dB) - gets really glitchy over around 16 dB, but sounds great so I keep it high
amp = volume
out = channels out

*/

(
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, ts=1, c1=1, c2=(-1), freq=500, detune=0.02, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig,lsf,0.5,ldb);
	sig = Balance2.ar(sig[0],sig[1],pan);
	sig = sig*env*amp;
	Out.ar(out,sig);
}).add;
);

/*

henonN: using the non-interpolated Henon Ugen as a synth
Contains a LeakDC Ugen to stop any DC bias in the signal from disturbing the rest of the mix
Arguments for a, b, x0 and x1 are at their default values which gives a periodic signal, and only slight deviation will change the properties of the signal a LOT.
The non-interpolated version gives the most 'harsh' signal

it uses the equation x(n+2) = 1 - a * x(n+1)^2 + b * x(n)

freq = frequency
a = a
b = b
x0 = first value of x
x1 = second value of x
atk = attack
sus = sustain
rel = release
ts = timescale
out = channels out
pan = panning in stereo
amp = volume

*/

/*

(
SynthDef(\henon,
	{arg freq=440,a=1.3,b=0.3,x0=0.30501993062401,x1=0.20938865431933,atk=0.01,sus=1,rel=1,ts=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = HenonN.ar(freq,a,b,x0,x1,amp);
		env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,ts,2);
		sig = LeakDC.ar(sig);
		sig = sig*env;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);


*/


/*

henonC: using the cubic-interpolated Henon Ugen as a synth
Contains a LeakDC Ugen to stop any DC bias in the signal from disturbing the rest of the mix
Arguments for a, b, x0 and x1 are at their default values which gives a periodic signal, and only slight deviation will change the properties of the signal a LOT.
The cubic-interpolated version gives the most 'soft' signal

it uses the equation x(n+2) = 1 - a * x(n+1)^2 + b * x(n)

freq = frequency
a = a
b = b
x0 = first value of x
x1 = second value of x
atk = attack
sus = sustain
rel = release
ts = timescale
out = channels out
pan = panning in stereo
amp = volume

*/

/*

(
SynthDef(\henonc,
	{arg freq=440,a=1.3,b=0.3,x0=0.30501993062401,x1=0.20938865431933,atk=0.01,sus=1,rel=1,ts=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = HenonC.ar(freq,a,b,x0,x1,amp);
		sig = LeakDC.ar(sig);
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);

*/

/*

warp1: a SynthDef to leverate Warp1 (my favourite granular buffer player) within patterns
I don't use this that much, as Warp1 is much better suited going straight into ProxySpace and modulated by Ugens, but it's in here in case it is useful within a Pmono
The arguments are quite convoluted, and they can be much better understood by looking at Warp1's helpfile

buf = buffer number
channels = number of channels of the buffer
rate = rate of playback of grains
size = window size of grains
env = envelope number of grains
olap = overlap of grains
rand = random playback window of grains
interp = interpolation (4 = cubic)
poslag = lag in the position for use within a Pmono (in seconds)
ratelag = lag in the rate for use within a Pmono (in seconds)
out = channels out
sizelag = lag in the window size for use within a Pmono (in seconds)
pan = pan within a stereo field
amp = volume

*/

(
SynthDef(\warp1,
	{arg buf=0, channels=2, pos=0, rate=1, size=0.2, env= -1, olap=8, rand=0, interp=4, poslag=0, ratelag=0, out=0, sizelag=0, pan=0, amp=0.5;
		var sig;
		sig = Warp1.ar(2,buf,Lag.kr(pos,poslag),Lag.kr(rate,ratelag),Lag.kr(size,sizelag),env,olap,rand,interp,1);
		Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);


/*

bpfbuf: a synth created by Eli Fieldsteel as part of his SuperCollider tutorials series
Plays looped buffers through a band pass filter, and in the tutorial is used to create pitched 'clouds' of percussion
I don't use this one much, but it can be very useful.

atk = attack
sus = sustain
rel = release
c1 = start of the envelope curve
c2 = end of the envelope curve
buf = buffer index
rate = rate of buffer played
pos = start position
freq = frequency of buffer player
rq = Q of Band Pass Filter
bpfmix = amount of band pass filter included in signal
pan = pan in the stereo field
amp = volume
out = channels out

*/

(
SynthDef(\bpfbuf, {
	arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
	buf=0, rate=1, pos=0, freq=440, rq = 1,
	bpfmix=0, pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf), startPos:pos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig * env;
	sig = Pan2.ar(sig,pan,amp);
	Out.ar(out,sig);
}).add;
);

/*

sinfb: General purpose SinOscFB Ugen designed to mutate between pure sine waves and noise using the feedback argument.
A SynthDef that gets heavy use from me, works well for bass, chords and melody.

freq = frequency
atk = attack
sus = sustain
rel = release
fb = feedback (generally useful values are from 0-2, with 0 being pure sine waves and 2-20 being noise. More info on this in 'Between Pitch and Noise' section of guides)
amp = volume
out = channels out
pan = panning in stereo

*/

(
SynthDef(\sinfb, {
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SinOscFB.ar(freq,fb,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);

/*

ring1: a Ringz-based synth which is inspired by this: http://sccode.org/1-1b
ring2, ring3 and ring4 represent the other tones used in this example, but I don't use them. They have been left in in case I would like to use the original combination of frequencies
the .tanh gives a wonderful squelch when driven very hard, and at low frequencies it resembles an acid bass

f = frequency (the reason this isn't freq is because it doesn't seem to work)
a = amplitude of Ringz (before the final multiplier so that a heavily distorted signal can be later scaled by amp)
d = duration of envelope on Ringz
pan = Pan in stereo
amp = overall volume
out = channels out

*/

SynthDef(\ring1,
	{
		arg f = 45, a = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;
SynthDef(\ring2,
	{
		arg f = 9000, a = 2, d = 0.1, amp = 1, pan = 2, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;
SynthDef(\ring3,
	{
		arg f = 50, a = 3, d = 1, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;
SynthDef(\ring4,
	{
		arg f = 8000, a = 1, d = 0.3, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

/*
//this needs to be re-evaluated every time there is a note played - so it needs work.
//not working thus far
SynthDef(\randomChaos,
	{ arg out = 0, atk = 0, rel = 0.1, sus = 0;
		var sig, env, chaosUgen, chaosUgenPick;
		env = EnvGen.ar(Env.linen(atk,sus,rel),doneAction:2);
		chaosUgen = ChaosGen.allSubclasses;
		sig = chaosUgen[rrand(0,10)].ar;
		sig = sig*env;
		Out.ar(out,Pan2.ar(sig));
}).add;
*/

)
