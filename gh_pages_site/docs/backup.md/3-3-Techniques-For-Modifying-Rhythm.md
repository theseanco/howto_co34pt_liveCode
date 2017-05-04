# Techniques for Modifying Rhythm

======

In 3.2 I went over a few basic rhythmic units for some simple dance music rhythms, here I will elaborate on a few of the more simple techniques I use to get a bit of complexity in my rhythms.

### Why I don't use (total) randomness

The [Pwhite](TODO) class is a great way to incorporate randomness into patterns, and one of the first things I tried to do when adding complexity to rhythms was to simply randomise them, however the results were often quite disappointing, especially with multiple random rhythms played at once for sounds that are played regularly (i.e. snares, hats):

```supercollider
//Random rhythm with Pwhite
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0),\amp,1);
~sn.play;~h.play;~c.play;~t.play;
)
//even with a regular kickdrum the other rhythms don't sound good
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play
)
```

With rhythms that use random floating point numbers, the durations that are used have no relationship to any central pulse, and will end up cutting across the beat a lot of the time in a way that I feel does not make sense in dance music. Instead, randomness can be incorporated within various techniques (for a great example see the way that Pwhite is used in the section on Euclidean Rhythms), or constrained to fit within a more regular pattern by using methods (which can be found in the [Pattern Documentation](TODO)).

Here is an example of using methods to constrain Pwhite into a form that is more palatable:

```supercollider
//same example but with all rhythms constrained
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0).round(1),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75).round(0.25),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2).round(0.75),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0).round(0.5),\amp,1);
~sn.play;~h.play;~c.play;~t.play;
)
//sounds more palatable with everything arranged properly
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play
)
```

Pwhite also only gives floating point results if one of the values specified is a floating point number, so for quick whole-beat durations (especially useful for occasional longer sounds) I use Pwhite to generate whole beats:

```supercollider
//same example again
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0).round(1),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75).round(0.25),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2).round(0.75),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0).round(0.5),\amp,1);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~sn.play;~h.play;~c.play;~t.play;~k.play;
)
//added whole note fx, short, medium and long.
(
~fx1 = Pbind(\instrument,\bplay,\buf,d["sfx"][0],\dur,Pwhite(1,5),\amp,1);
~fx2 = Pbind(\instrument,\bplay,\buf,d["fx"][0],\dur,Pwhite(1,10),\amp,1);
~fx3 = Pbind(\instrument,\bplay,\buf,d["lfx"][0],\dur,Pwhite(10,40),\amp,1);
~fx1.play;~fx2.play;~fx3.play;
)
```

### Layering

Some great advice I received from a lecturer was 'if one of them is good, lots of them will be great' (paraphrased), when talking about the work of [an artist](TODO: Who is this again?). This works really well when applied to rhythmic percussion, particularly if each layer of similar percussion serves to re-contextualise the last.

When I'm layering rhythms, there are generally a few techniques I employ to make doing so 'work', or just to sound better:

- Layer at different pitches:
```supercollider
//layering at different pitches - kicks
(
p.clock.tempo = 2.3;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1.2],inf));
~k.play;
)
//kicks at a different pitch. Evaluate this a few times to get different permutations
(
~k2 = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1.8],inf)*4);
~k2.play;
)
```
- Layer very slightly different rhythms, rhythmic units of different lengths
```supercollider
//layering of slightly different rhythms
//rhythm 1
(
p.clock.tempo = 1.7;
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t.play;
)
//rhythm 2, using a different tom for contrast
//also re-evaluating rhythm 1 to get them playing together
(
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pseq([1,1,1,0.25],inf),\amp,1);
~t2.play;
)
//rhythm 3 for more
(
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pseq([1,1,1,0.25],inf),\amp,1);
~t3 = Pbind(\instrument,\bplay,\buf,d["t"][2],\dur,Pseq([1,1,1,0.75],inf),\amp,1);
~t3.play;
)
//kick underneath to illustrate
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\rate,1);
~oh.play;
~k.play;
)
```
- Layer interlocking or complimentary rhythms
```supercollider
//complimentary rhythms:
//the 'polyrhythmic clap' from the Basics example
(
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c.play;
)
//clap added at a similar rhythm (euclidean 3,8)
(
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pbjorklund2(3,8)/4,\amp,1);
~c2.play;
)
```
- Link with StageLimiter to establish rhythms underneath other ones (more on this in the StageLimiter Abuse section)
```supercollider
//StageLimiter throttling
//a complex rhythm
(
l = Prewrite(1, // start with 0
        (    1: [0.25,2],
		0.25: [1,0.75,0.1,0.3,0.6,0.1],
		0.1: [0.5,1,2],
		2: [0.5,0.75,0.5,1]
        ), 4);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l/2,\amp,1,\rate,2);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l*2,\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,l,\amp,1,\rate,Pseq([1.2,1.4,1.7],inf));
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l*4,\amp,1,\rate,0.8);
~ding = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,Pwhite(1,5),\amp,1,\rate,0.2);
~h.play;~c.play;~t.play;~ding.play;~sn.play;
)
//extremely loud kick throttles everything elese
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,4,\amp,100,\rate,0.5);
~k.play;
)
```
TODO: is there any more of these?

### Pwrand - Weighted distribution and hassle-free controlled randomness

A technique that I started using after being inspired by Trap instrumentals (such as Ace Hood's [Bugatti](https://www.youtube.com/watch?v=-2KF2JbrQ94)) was hi-hats that snapped between 1/4, 1/8, 1/6 and 1/16th note patterns. The best way I found to do this was to use [Pwrand](TODO: this). Pwrand takes an array of items, and will select those items randomly within a weighted distribution, allowing control over the frequency of occurrence of particular elements.

The trap hi-hats looked like this:
```supercollider
//trap(ish) hi-hats
//Has a choice of four rhythmic patterns with lesser chance for each, results in a mostly 0.25-duration hat which can potentially go quite quickly
(
p.clock.tempo = 75/60
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwrand([0.25,Pseq([0.125],4),Pseq([0.25]/3,3),Pseq([0.125]/2,4)],[0.6,0.3,0.09,0.01],inf),\amp,1,\rate,2);
~h.play;
)
```

Pwrand is great to use whenever you want to control the occurrence of particular types of rhythm without explicitly specifying an order for these types of rhythm to occur. A one I've used quite a lot is to inject some variety into kick drums by switching out a straight `dur` of 1 with other values

```supercollider
//occasional variation on 4/4 kick
(
p.clock.tempo = 2.3;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pwrand([1,Pseq([0.75],4),Pbjorklund2(3,8,1)/4],[0.9,0.08,0.02],inf),\amp,1);
~k.play
)
//open hat for reference
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\rate,1.4);
~oh.play;
)
```

### Clipped percussion - stuttering

The SynthDef `vplay` is designed to deliver samples controlled by an envelope which by default is a square - it will abruptly start and stop sample playback according to envelope settings:

```supercollider
//cutoff percussion. This Pbind uses (0..100)/100 to split the sample into 100 sections of 0.03 and play over them
(
p.clock.tempo = 2.4;
~perc = Pbind(\instrument,\vplay,\buf,d["fx"][1],\rel,0.03,\dur,0.25,\pos,Pseq((0..100)/100,inf))
~perc.play
)
```

This is a useful technique for creating sputtering rhythms out of much longer sound effects or samples, which can be chopped up on-the-fly and recombined around a central rhythm with `vplay`. This approach tends to yield interesting results by each individual sample playback taking on irregular characteristics even when played inside a regular rhythm - some complexity with pretty minimal effort:

```supercollider
//sputtering rhythms based on long percussion sounds
//the Prand for \buf is a flattened array of all fx sounds. If it wasn't flat it would play all sounds from any fx entry all at once
(
p.clock.tempo = 2.3;
~perc = Pbind(\instrument,\vplay,\buf,Prand([d["fx"],d["sfx"],d["lfx"]].flat,inf),\rel,0.1,\dur,0.25,\pos,Pwhite(0,0.9),\rate,Pwhite(1,3.0));
~perc.play;
)
//choose from literally every sample there is in d. Buggy because it'll also play anything else that is in there, but good for a laugh.
(
~perc = Pbind(\instrument,\vplay,\buf,Prand(d.values,inf),\rel,0.1,\dur,0.25,\pos,Pwhite(0.0,0.9),\rate,Pwhite(1,3.0));
~perc.play
)
```

### Back-and-forth - Pkey and linking values

[Pkey](TODO: this) is a pattern class used to embed the same value multiple times in the same pattern - for example if the release value of a SynthDef needed to be the same as the duration of the note:

```supercollider
Pbind(\instrument,\something,\dur,Pseq([2,3,4,5],inf),\rel,Pkey(\dur))
```

One way to use this in rhythm is to create sample playback that flips back and forth. Due to how the [`bplay`](TODO: This) Ugen works, if a buffer is to be played backwards it will need to be started just before the end of the sample as the Synth will release once the sample is finished (for more information see [Ugen done-actions](TODO: this)). Using the `.linlin` linear scaling method this value can then be scaled into the rate of playback to create a back-and-forth pattern in percussion, shown here on a snare:

```supercollider
//back-and-forth snare
(
~sn = Pbind(\instrument,\vplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(1,6),16)/4,\amp,1,\rate,Prand([-1,1],inf),\pos,Pkey(\rate).linlin(-1,1,0.99,0));
~sn.play;
)
```

### .normalizeSum and 'keeping it on 1'

Sometimes greater granularity or oddities of rhythm are needed, but still within the confines of some kind of regularity. This can be achieved with the `.normalizeSum` method, which will take an array and normalize all of its elements so that they add up to 1, for example `[10,20,30].normalizeSum` will produce the array `[ 0.16666666666667, 0.33333333333333, 0.5 ]`. This can be used to create arrays inside of `Pseq` that can easily create complex rhythmic bursts that still resolve around the central beat. Particularly useful here is to generate a sequential array and normalize it to create a rhythmic spread:

```supercollider
//.normalizeSum rhythmic spread
//spreading 1-20 over four beats
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..20).normalizeSum,inf)*4,\amp,Pwhite(0.2,1));
~h.play;
)
//spreading 1-200 over sixteen beats (gives overtone)
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..200).normalizeSum,inf)*16,\amp,Pwhite(0.2,1));
//spreading 1-18 over 8 beats
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..18).normalizeSum,inf)*8,\amp,Pwhite(0.2,1));
```

### \stretch

Another option for rhythmic variation is to use the `\stretch` argument built in to `Pbind`. This argument will multiply the `\dur` argument by `\stretch` to create a final duration which will be used in the pattern. I don't use this too much as it stands (April 2017), but it can be used very effectively

```supercollider
//using the \stretch argument - each time a cycle completes change the stretch duration
//a fake argument is created here - \euclidNum is used to inform both \dur and \stretch to ensure both work with the same number of onsets
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\euclidNum,Pwhite(1,7),\dur,Pbjorklund2(Pkey(\euclidNum),8)/4,\amp,1,\rate,Pseq([3,4,5],inf),\stretch,Pseq([1,0.5,0.25,2],inf).stutter(Pkey(\euclidNum).asStream));
~k.play;
````
