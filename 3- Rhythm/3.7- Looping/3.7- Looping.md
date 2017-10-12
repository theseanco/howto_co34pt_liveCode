# Looping rhythms and samples with the `lplay` SynthDef

------------------------

A part of rhythmic electronic music that SuperCollider isn't so great at dealing with are loops. In the Pattern library there isn't a defaulting to 'loop'-based musical structures as is the default in DAW environments such as Ableton live.

This is of course extremely powerful, but sometimes for more complex rhythmic forms, loops are a reasonable practical substitute.

I use loops particularly when there are some rhythms that I find hard to articulate by specifying duration values - an example being the classic [Amen Break](https://www.youtube.com/watch?v=5SaFTm2bcac) when I'm trying to make some fast Drum-and-bass style music.

For this, I wrote `lplay`, a variation on the `bplay` Synthdef that is ubiquitous in my Live Coding setup.

```supercollider
(
SynthDef(\lplay,
	{arg out = 0, buf = 0, amp = 0.5, pan = 0 rel=15, dur = 8;
		var sig,env ;
		sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * ((BufFrames.ir(buf)/s.sampleRate)*p.clock.tempo/dur),1,0,doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
)
```

`lplay` takes a `dur` value and plays a buffer exactly over the time period speficied by the `dur` value. For example, if you have a 8 beat drum loop, and you created this `Pbind`:

```supercollider
p.clock.tempo = 175/60
~loop = Pbind(\instrument,\lplay,\buf,d["breaks175"][0],\dur,16)
```

The loop would play over 8 cycles of the `ProxySpace` `TempoClock` (p.clock.tempo). This is achieved by using this equation for the `rate` control:

```supercollider
((BufFrames.ir(buf)/s.sampleRate)*p.clock.tempo/dur)
```

Note that the looping is tied to the rate of playback, so the faster the tempo, the faster the sample will be played. If you try and play a 120bpm sample at 175bpm, it will sound very high-pitched! - Be aware of this when using it during performance.

An important note is that you will have to _reload the synthdef_ when the tempo is changed if you want looping to work with the updated tempo
