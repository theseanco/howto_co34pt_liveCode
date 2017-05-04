# Pbinds and Patterns

---------------------------

### Introduction

According to SuperCollider's [Practical Guide to Patterns](http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_01_Introduction.html)

> Patterns describe calculations without explicitly stating every step. They are a higher-level representation of a computational task. While patterns are not ideally suited for every type of calculation, when they are appropriate they free the user from worrying about every detail of the process. Using patterns, one writes what is supposed to happen, rather than how to accomplish it.

A large part of my live coding performances involve using patterns, specifically [Pbinds](http://doc.sccode.org/Classes/Pbind.html) as Proxies inside of ProxySpace (see section 2.2.1) to create rhythmic elements that are synchronised to ProxySpace's [TempoClock](http://doc.sccode.org/Classes/TempoClock.html). In this case, 'rhythmic elements' can mean percussion, melody, bass, pads, or generally anything that is played 'in tempo'.

### SynthDefs, Arguments and Pbinds

The Pbinds I perform with work in conjunction with a set of [SynthDefs](http://doc.sccode.org/Classes/SynthDef.html) (these can be found in the SynthDefs.scd file of the Setup folder) which serve various musical purposes, and plays them with specifies arguments at a given duration. This isn't a particularly intuitive concept to explain, but an example can help illustrate how this works. Take the SynthDef I use the most, `bplay`:

```supercollider
SynthDef(\bplay,
    {arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
        var sig,env ;
        sig = Pan2.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
        env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
        sig = sig * env;
        sig = sig * amp;
        Out.ar(out,sig);
}).add;
```

`bplay` is a simple stereo-panned sample player driven by the [PlayBuf](http://doc.sccode.org/Classes/PlayBuf.html) class, which takes the following arguments:

- `out`: the bus to be played to (this is needed as an argument for the SynthDef to work correctly inside ProxySpace, and I don't usually touch it
- `buf`: the buffer to be read by the synth (all of which are loaded into dictionary `d` by default
- `rate`: the speed the sample will be played at (with no compensation for pitch)
- `amp`: how loud the sample is, with 1 being the original volume of the sample
- `pan`: where the sound is placed in the stereo field, with `0` being centre
- `pos`: the position from which the sample starts playing, normalised from `0` to `1`, e.g. a value of `0.5` will play the sample from the middle 
- `rel`: in this case specifies how long the server is allowed to keep the instance open before freeing it. Normally the instance will be freed when the sample is finished playing, but in the case of very long samples or samples played backwards this freeing may not occur, leading to server load building in the background due to dead running processes. This default value of 15 

Pbinds also have some arguments that need satisfying:

- `instrument`: the SynthDef that will be used to deliver this 'instance' in the pattern
- `dur`: The duration of each 'instance', if used directly in ProxySpace, a `dur` value of 1 results in an 'instance' once every clock cycle. 
Note: the default `dur` value of a Pbind is 1, and the default `instrument` value is SuperCollider's built in Piano synth, but specifying both anyway (especially `instrument`) is good practice.

So, if I wanted to have a kick drum playing once each beat in time with the ProxySpace timer, after I had run my setup file I would do the following:

```supercollider
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1);
~k.play;
)
```

This Pbind `~k`, spefifies that the instrument it will be using is `bplay`, the buffer `bplay` reads from will be the first index of the `k` entry in the dictionary (which contains kick drums), and that the `dur`/duration is `1`, once per cycle. If any arguments that the SynthDef takes are not specified as part of the Pbind, the SynthDef's default values will be used. Pbind arguments have to be given as key-value pairs, anything else will result in a syntax error, eg:

```supercollider
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\rate);
```

As part of these key-value pairs, Pbinds can take Pattern classes as inputs. [`Pwhite`](http://doc.sccode.org/Classes/Pwhite.html) gives random values between a minimum and maximum. If I wanted to specify a random pitch of the kick drum, I could add this to the pattern:

```supercollider
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\rate,Pwhite(1,1.2));
```

### Nesting pattern classes

Pattern classes can also be [nested](https://en.wikipedia.org/wiki/Nesting_(computing)). Here are a few examples of some more complex percussive patterns. Once you start nesting pattern classes, things can get complicated quite quickly.

```supercollider
//to play with these examples, make sure the Setup File has been run

//footwork kickdrums
(
p.clock.tempo = 2.4;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(Pseq([3,3,3,5],inf),8)/4,\amp,1,\rate,Pseq([1,1.2],inf));
~k.play;
)

//skittery hi-hats
(
p.clock.tempo = 1.5;
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwrand([0.25,Pseq([0.125],2),0.5,Pseq([0.125/2],4)],[4,1,1,0.5].normalizeSum,inf),\amp,Pwhite(0.2,1));
~h.play;
)

//offset percussion patterns for techno feel behind a basic kick
(
p.clock.tempo = 135/60;
~c = Pbind(\instrument,\bplay,\buf,d["sfx"][6],\dur,Pbjorklund2(Pexprand(2,15).round(1),16,inf,Pwhite(1,5).asStream)/4,\amp,1,\rate,2.2);
~c2 = Pbind(\instrument,\bplay,\buf,d["sfx"][6],\dur,Pbjorklund2(Pexprand(2,15).round(1),16,inf,Pwhite(1,5).asStream)/4,\amp,1,\rate,1.9);
~k = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,1,\amp,5);
~c.play;
~c2.play;
~k.play;
)

//snare running forwards and back
(
p.clock.tempo = 150/60;
~sn = Pbind(\instrument,\bplay,\buf,d["s"][4],\dur,Pwhite(1,4)/2,\amp,1,\rate,Prand([1,-1],inf),\pos,Pkey(\rate).linlin(-2,2,0.9,0));
~sn.play;
)
```

### Extra arguments for melody/pitch

Pbinds also have some additional trickery for anything involving pitch.

Let's look at the `sinfb` SynthDef (the arguments are listed in the code block for simplicity)

```supercollider
//SinFB Bass
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
freq: frequency
atk: attack
sus: sustain
rel: release
fb: phase feedback
amp: amplitude
out: output bus
pan: stereo panning
*/
```

Here, the `freq` argument is the pitch of the oscillator. Pitch can be specified manually, like so:

```supercollider
~sinfb = Pbind(\instrument,\sinfb,\dur,0.25,\freq,Pwhite(100,900));
```

However, if a variable in a SynthDef is given the name `freq`, Pbind allows the specification of the following in place of `freq` to activate a 'scale mode':

- `scale`: the scale and tuning used - scales can be listed with `Scale.directory` and tunings with `Tuning.directory` (default `Scale.major(\et12)`)
- `degree`: the degree of the scale to be played (default `0`)
- `octave`: the octave of the scale to be played (default `5`)

Only one of these arguments needs to be specified to be in 'scale mode', for example:

```supercollider
//run up the major scale
~sinfb = Pbind(\instrument,\sinfb,\dur,0.25,\degree,Pseq((0..7),inf));
```

But using all three gives full control over the parameters of the pitch used inside of a musical scale

```supercollider
//run up and down chromatic scale one degree at a time
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.chromatic(\et12),\degree,Pseq((0..12).pyramid.mirror,inf),\octave,6,\dur,0.125/2,\amp,0.3,\fb,0.8,\rel,0.1)
```

By using the 'scale mode' of Pbinds you can easily adopt pitch structures that are organised around any scale and tuning you wish - SuperCollider has a bunch bundled in, but way more can be added with the Scala Scale library through quarks such as [TuningLib](https://github.com/supercollider-quarks/TuningLib) and [TuningTheory](https://github.com/thormagnusson/TuningTheory), and arbitrary scales can be specified.

### Why I don't use Pdefs

Another approach to using patterns is to make metapatterns by placing Pbinds (and Pmonos) inside of a `Pdef`, but i've found this to be too verbose to use while performing, and i've personally had some problems getting them to sync for performances that reply on strict metric patterns.

### More on Patterns

Patterns form a huge part of my live sets, so I will be referencing them frequently throughout this repo, talking about their use in both rhythmic and melodic arrangement.

