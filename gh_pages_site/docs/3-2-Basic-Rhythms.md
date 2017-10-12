# Basic Rhythms

-------

This document will be a list of some basic rhythmic techniques that are designed to deliver a simple, solid rhythmic base. Strategies for modifying these simple units will be detailed in the following document. 

### Preamble: How to construct rhythms

According to the [Pbind docs](http://doc.sccode.org/Classes/Pbind.html), duration using Pbinds are determined using the following:

>delta
>   The time until the next event. Generally determined by:
>   dur
>       The time until next event in a sequence of events
>   stretch
>       Scales event timings (i.e. stretch == 2 => durations are twice as long)

I generally use `\dur` for basic rhythms, and when Pbinds are placed directly within ProxySpace, the `\dur` argument is in sync with the ProxySpace [`TempoClock`](http://doc.sccode.org/Classes/TempoClock.html), which is specified in [`Setup.scd`](../../Setup/Setup.scd). This automatic synchronisation is very handy for keeping all of your rhythms running to the same tempo.

As stated in 3.1, for the most part all percussion I use will be sample-based. For playing samples using Pbinds, I have written two simple `SynthDefs` (which can be found in the [`SynthDefs.scd`](../../Setup/SynthDefs.scd) file in setup) - `bplay` and `vplay`. `bplay` is a simple buffer player that takes the following arguments:

- `out`: the bus to be played to (this is needed as an argument for the SynthDef to work correctly inside ProxySpace, and I don't usually touch it
- `buf`: the buffer to be read by the synth (all of which are loaded into dictionary `d` by default
- `rate`: the speed the sample will be played at (with no compensation for pitch)
- `amp`: how loud the sample is, with 1 being the original volume of the sample
- `pan`: where the sound is placed in the stereo field, with `0` being centre
- `pos`: the position from which the sample starts playing, normalised from `0` to `1`, e.g. a value of `0.5` will play the sample from the middle
- `rel`: in this case specifies how long the server is allowed to keep the instance open before freeing it. Normally the instance will be freed when the sample is finished playing, but in the case of very long samples or samples played backwards this freeing may not occur, leading to server load building in the background due to dead running processes. This default value of 15

`bplay` is a general purpose sample player, which is designed for playing back percussive sounds. It is by far my most used SynthDef, and will almost inevitably be used to build the percussion in my sets.

`vplay` also takes another argument:

- `rel1`: controls the amount of a sample played

which is for playing specific sections of a sample, or to create particular effects by cutting the playing of percussive samples short.

### 'The' kick

The iconic sound of a 4/4 kickdrum is probably a good starting point. A `dur` of 1 will play a kick on every beat of the clock  
Stored as snippet `kick`

```supercollider
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
```

### Alternate-beat snare

Played alongside the 4/4 kick, a snare on every other beat  
Stored as snippet `snare`

```supercollider
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,2,\amp,1);
~sn.play;
```

### basic hi-hat pattern

Quarter-note closed hi-hats with random amplitude, good for fleshing out basic rhythms  
Stored as snippet `hat`

```supercollider
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,0.25,\amp,Pwhite(0.25,1);
~h.play
```

### 3/4 note clap

A clap every 0.75 beat. When played against the rhythms above will add a nice polyryhthmic feel  
Stored as snippet `clap`

```supercollider
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c.play;
```

### off-beat open hi-hat

An open hi-hat played every beat, offset every half. I use it alongside straight kicks for a kick-hat-kick-hat pattern. The sample here also sounds *really* good if it's switched out for some vocal chants. Note the `dur` uses an infinite Pbind inside of another Pbind to offset a regular pattern - this is a complexity of offsetting rhythms in SuperCollider, and is one of the only instances in which I currently do it.  
Stored as snippet `oh`.  
The offset `dur` is stored as snippet `offbeat`

```supercollider
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
```
