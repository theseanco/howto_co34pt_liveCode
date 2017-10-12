# StageLimiter abuse and 'The Guetta Effect'

---------

Listen to the chorus of ['Titanium' by David Guetta ft Sia](https://www.youtube.com/watch?v=JRfuAukYTKg). That 'pumping' sound heard around the kick drums in the synth parts is (probably) a result of [Sidechain Compression](http://www.sonicscoop.com/2013/06/27/beyond-the-basics-sidechain-compression/), an effect that's pretty common in dance music which (essentially) uses the volume of a track to duck the volume of other tracks. 

I've found it very helpful to employ this technique at various points during performance to reinforce the dominant rhythmic pulse of a set. Take [this rehearsal excerpt for example](https://soundcloud.com/co-3-4-pt/rehearsal_170220_114908), where the 'bell' sounds are being 'pumped' by the bass drum, it's not too subtle. Or skip to 1.22 in [this glitchy excerpt](https://soundcloud.com/co-3-4-pt/broken_rehearsal_151117_225533), the irregular pitched-up clap is literally cutting off the atonal chimes underneath it. There's also the first half of [this set](https://co34pt.bandcamp.com/album/live-icmus-introducing-bar-loco-15-6-16) where I am attempting to riff on some tropes from [Psytrance](https://youtu.be/HdxQJ_C0kdQ?t=34m2s), using the kick drum to modulate the two interlocking distorted synth riffs that are being played.

With the exception of the 'Psytrance' riff, I almost always achieve this pseudo-sidechaining effect in the most brutal way possible - by abusing StageLimiter. As StageLimiter is just a [Limiter.ar on the output](https://github.com/supercollider-quarks/BatLib/blob/master/StageLimiter.sc), any sounds over an amplitude of 0dB in the mix will reduce the volume of any other sounds in the mix without distorting. As I tend to use percussion that is normalised to 0dB, any percussion that is played with an `\amp` value of greater than `1` will compress the rest of the mix in proportion to the volume that they hit above 0dB. This can range from subtle to completely ridiculous. 

Here are a few examples of this.

```supercollider
//1:
//a complex polyrhythm - no need to worry about the construction of this.
(
p.clock.tempo = 2.3;
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pbjorklund2(Pseq([3,3,3,5],inf),8)/4,\amp,1);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\stretch,Pwhite(1,0.25).round(0.25));
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(3,10),16),\amp,1);
~t1 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,1/5*4,\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,1/9*4.5,\amp,1,\rate,2);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pbjorklund2(Pwhite(10,16),16)/8,\amp,Pwhite(0.2,1.4));
~fx1 = Pbind(\instrument,\bplay,\buf,d["sfx"][0],\dur,Pwhite(1,4.0).round(0.5),\amp,1);
~fx2 = Pbind(\instrument,\bplay,\buf,d["sfx"][1],\dur,Pwhite(1,8.0).round(0.25),\amp,1);
~c.play;~c2.play;~oh.play;~sn.play;~t1.play;~t2.play;~h.play;~fx1.play;~fx2.play;
)
//A 0db kick which doesn't really do anything in the mix
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)
//A >0dB kick which compresses everything else and audibly 'centers' everything around it because it is so loud.
//There's probably some psychoacoustics involved in this that i'm not qualified to talk about.
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,4);
~k.play;
)
//a really *really* loud, very occasional percussion which silences everything else (slowed down for exaggerated effect)
(
~hugesnare = Pbind(\instrument,\bplay,\buf,d["mt"][0],\dur,Pwhite(8,16),\amp,4000000,\rate,1);
~hugesnare.play;
)

//2:
//some beautiful pads
//thanks Eli Fieldsteel
(
p.clock.tempo = 2;
(
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(4.5,7.0,inf),
	\midinote,Pxrand([
		[23,35,54,63,64],
		[45,52,54,59,61,64],
		[28,40,47,56,59,63],
		[42,52,57,61,63],
	],inf),
	\detune, Pexprand(0.0001,0.1,inf),
	\cfmin,100,
	\cfmax,1500,
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\amp,Pwhite(0.8,2.0),
	\out,0)
);
~chords.play;
)
//pulse them slightly with a low-passed kick
(
~k = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,Pbjorklund2(3,8)/2,\amp,2);
//Low Pass
~lpfSend = {[~k]};
~lpf = {RLPF.ar(Mix.ar([~lpfSend]),SinOsc.kr(0.1).range(200,100),1)};
~lpf.play;
)
//eliminate them completely with an absurdly loud low-passed kick (those with subwoofers be careful!)
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,9000,\rate,5);
//Low Pass
~lpfSend = {[~k]};
~lpf = {RLPF.ar(Mix.ar([~lpfSend]),SinOsc.kr(0.1).range(100,80),0.3)};
~lpf.play;
)
```
