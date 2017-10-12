# Good SynthDef writing for co34pt_LiveCode

------

I won't cover the fundamentals of [synthesis](http://sonicbloom.net/en/63-in-depth-synthesis-tutorials-by-sound-on-sound/) or [synthdef](http://danielnouri.org/docs/SuperColliderHelp/Tutorials/Getting-Started/SynthDefs%20and%20Synths.html) writing, as others have done so much better than I ever will.

If you're going to be writing SynthDefs for Patterns in the format I use in these guides and in my sets, there's a few rules to ensure that things run reasonably smoothly.

It's also worth reading the [SynthDef documentation](http://doc.sccode.org/Classes/SynthDef.html) and [Pbind documentation](http://doc.sccode.org/Classes/Pbind.html)

### `freq` and frequency

The carrier of a main frequency of a SynthDef should have the argument name `freq` - this will allow for the use of scales, tunings and detuning within Pattern arguments, from the documentation:

> detunedFreq
> actual "pitch" of a synth, determined by:
> freq + detune;
> freq is determined by:
> (midinote + ctranspose).midicps * harmonic;
> midinote is determined by:
> (note + gtranspose + root)/stepsPerOctave * octave * 12;
> note is determined by:
> (degree + mtranspose).degreeToKey(scale, stepsPerOctave)

There are a couple of instances where you can't use `freq` as the actual frequency, so in which case, use Pkey to reroute the frequency argument like this:

```supercollider
//where x is the frequency argument
Pbind(\instrument,\foo,\x,Pkey(\freq),\scale,Scale.minor,\degree,Pseq([4,5,6],inf))
```

### `out`

Each SynthDef should have an argument `out` in its `Out.ar`. I always leave it as 0, but it can be used to handle effects routing. I don't know why, but if it doesn't have it, it won't work inside of ProxySpace.

### Envelopes

Envelopes will be automatically triggered as part of patterns, on the assumption that the trigger of any envelope is set to `1`. It's also much easier to use envelopes where it does not need a release trigger. I generally use `Env.perc` and `Env.linen`. It's also important to use a `doneAction` which will free the synth once the envelope has completed.

