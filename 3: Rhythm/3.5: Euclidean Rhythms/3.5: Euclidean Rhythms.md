# Euclidean Rhythms

---------------------------

### Introduction

Euclidean Rhythms are described in a 2005 paper by Godfried Toussaint entitled ['The Euclidean Algorithm Generates Traditional Musical Rhythms'](http://cgm.cs.mcgill.ca/~godfried/publications/banff.pdf), which describes the organisation of rhythm by placing onsets as evenly as possible within a number of possible spaces using Bjorklund's algorithm. It's not the easiest thing to verbally describe, but [this online tool](https://reprimande.github.io/euclideansequencer/) explains it much better, and the paper contains a bunch of illustrated examples.

As mentioned in 3.1, When I was learning how to perform Live Coding I found creating compelling, complex rhythm in SuperCollider quite hard. Euclidean Rhythms and the [Bjorklund quark](https://github.com/supercollider-quarks/Bjorklund) have ended up becoming major fixtures of my performance as a result as they handle a lot of the difficulties i have around developing rhythmic complexity in real-time as part of performance. I've always wanted to be able to make rhythms like [DJ Rashad](https://www.youtube.com/watch?v=SWTsLnYO68U), and using Euclidean Rhythms has got me some way n that quest.

### Effort-free rhythmic complexity

The problem I had with rhythm was in the fact that all rhythms for all proxies had to be specified as `dur` values, and each one had to be specified independently. Constructing TidalCycles-like 'riffs' containing multiple percussion samples is really quite hard in SuperCollider. As a result, most rhythms I ended up creating involved either using simple on-beat/off-beat patterns, or constraining a `Pwhite` or `Pexprand` into producing random rhythms in time with the ProxySpace tempo clock, and random rhythms with a uniform distribution generally sound quite boring.

The Bjorklund quark contains a few classes that help in using Euclidean Rhythms. I particularly use `Pbjorklund2`, which takes arguments for:

- `k`: Number of 'hits'
- `n`: Number of possible onsets
- `length`: Number of repeats
- `offset`: Starting onset in the pattern

and using this, outputs an array of durations for use as `dur` values in a pattern, for instance: `Pbjorklund2(3,8)` would produce duration arrays of `[ 3, 3, 2 ]`.

Because `Pbjorklund2` is a pattern class, it can be nested and have its arguments modulated by other pattern classes, using its inputs to generate sequences, rather than single values. In this way, 'random rhythms' create a much more interesting result, as random values will be used to create a network of onsets, which perceptually appear to be very complex interlocking rhythms.

```supercollider
//four 'randomised' rhythms, sounds okay.
(
p.clock.tempo = 2.2;
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,Pwhite(0.25,1).round(0.25),\amp,1);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,Pwhite(0.25,1).round(0.25),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][1],\dur,Pwhite(0.25,1).round(0.25),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(0.25,1).round(0.25),\amp,1);
~k.play;
~sn.play;
~h.play;
~t.play;
)

//four randomised euclidean rhythms with four different samples.
//sounds better, producing a much greater variety of rhythmic forms.
(
p.clock.tempo = 2.2;
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][1],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pwhite(1,8),Pwhite(1,16))/4,\amp,1);
~k.play;
~sn.play;
~h.play;
~t.play;
)
```

### Euclidean Rhythms vs 'the beat'

The benefit of using the Bjorklund quark like this is that it also lines up with the regular clock of ProxySpace, allowing for scattered, hypercomplex, undanceable rhythms to be established over time, and then in one movement unified under a regular rhythm, such as a straight kick drum with a `dur` of a subdivision of 1.

Here's an example that's sort-of inspired by the lasting impression that Basic Channel's [Phylyps Trak](https://www.youtube.com/watch?v=CUD4RaRSSio) made on me some time ago.

```supercollider
//Complex rhythm that obfuscates the central rhythmic centre
(
p.clock.tempo = 1.5;
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pbjorklund2(Pwhite(10,35),41,inf,Pwhite(0,10).asStream)/8,\amp,Pexprand(0.1,1),\pan,-1);
~h2 = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pbjorklund2(Pwhite(10,35),40,inf,Pwhite(0,10).asStream)/8,\amp,Pexprand(0.1,1),\pan,1);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(1,5),Pwhite(1,32))/4,\amp,1,\rate,Pwrand([1,-1],[0.8,0.2],inf),\pos,Pkey(\rate).linlin(1,-1,0,0.999));
~ding = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,Pbjorklund2(Pwhite(1,3),25)/4,\amp,0.6,\rate,0.6,\pan,-1);
~ding2 = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,Pbjorklund2(Pwhite(1,3),20)/4,\amp,0.6,\rate,0.7,\pan,1);
~t1 = Pbind(\instrument,\bplay,\buf,d["mt"][0],\dur,Pbjorklund2(Pseq([1,1,1,Pwhite(10,15,1).asStream],inf),36,inf,Pwhite(0,2).asStream)/8,\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pseq([1,1,1,Pwhite(10,15,1).asStream],inf),40,inf,Pwhite(0,2).asStream)/8,\amp,1,\rate,2);
~t1.play;~t2.play;~h.play;~h2.play;~sn.play;~ding.play;~ding2.play;
)
//a slightly more rhythmic element, tracing the rhythm out a bit more
(
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\degree,Pwrand([0,4],[0.8,0.2],inf),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,0.125,\d,0.25,\a,Pexprand(0.0001,200),\pan,0,\amp,1);
~ring1.play
)
//Add unce unce unce and simmer gently to unify flavours.
(
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\degree,Pwrand([0,4],[0.8,0.2],inf),\octave,Pwrand([2,3,4],[0.6,0.2,0.2],inf),\dur,0.125,\d,0.2,\a,Pexprand(0.02,900),\pan,0,\amp,1);
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,0.5,\amp,2);
~k.play;
)
//offbeat hat because cheesy rhythms are good fun
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf)/2,\amp,1)
~oh.play
)
```

### Using offsets

By utilising the `offset` argument of `Pbjorklund2`, small rhythmic elements can be used multiple times with slight variation to pretty powerful effect. 

The following example shows what a few basic offsets can do to liven up a very simple rhythmic pattern

```supercollider
//working with offsets - doing a lot with a little
//basic kick
(
p.clock.tempo = 2.13;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)
//Basic 5-16 euclidean rhythm
(
~c = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16)/4,\amp,0.7);
~c.play;
)
//add another layer at a different pitch
//NOTE: These two might not sound at the same time even though they are the same rhythm, as the rhythmic cycle is longer than 1 beat
(
~c2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16)/4,\amp,0.7,\rate,1.1);
~c2.play;
)
//if you want them to sound together, trigger them together
(
~c2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16)/4,\amp,0.7,\rate,1.1);
~c = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16)/4,\amp,0.7);
)
//offset both
(
~c = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16,inf,Pwhite(1,10).asStream)/4,\amp,0.7);
~c2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(5,16,inf,Pwhite(1,15).asStream)/4,\amp,0.7,\rate,1.1);
~c.play;
~c2.play;
)
//and another, slightly different sample
(
~c3 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pbjorklund2(5,16,inf,Pwhite(0,8).asStream)/4,\amp,0.7,\rate,0.9);
~c3.play
)
//now do the same to the kick
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1.2],inf));
)
//another kick, slightly different rhythm
(
~k2 = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(3,16,inf,Pwhite(1,10).asStream)/4,\amp,1,\rate,Pseq([1.1,1.4],inf));
~k2.play;
)
//add sub kick on 1, and you have minimal techno.
(
~sk = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,1,\amp,2);
~sk.play;
)
```

### Convergence & Divergence, using variables inside ProxySpace 

As I mentioned in my introduction to ProxySpace, ProxySpace reserved all global variables with the format `~variableName`. I use single letter variables (besides `s` which is reserved for the server and `p` which is reserved for ProxySpace) to hold variables for use in patterns. This is handy for a technique that establishes a set of euclidean rhythms like above, and them unifies them under a central rhythm, which can be deviated from during performance.

Here are the basics of the technique. Variable `l` is used to carry a pattern, which is evaluated alongside each pattern that it contains.

```supercollider
//give a central rhythm to be used by other patterns
l = Pbjorklund2(Pseq([3,3,3,4,3,3,3,5],inf),8)/4;
//block-execute (Ctrl/Cmd+Enter) between these brackets
(
p.clock.tempo = 2.1;
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,0.9);
~c3 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,1.1);
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~c.play;
~c2.play;
~c3.play;
)
//now individually execute (Shift+Enter) some of these lines to refresh the 'dur'. Listen for variations in rhythm.
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,0.9);
~c3 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,1.1);
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
//if you want to reset, execute the block again
```

Here is a fully fleshed-out example. As `Pwhite` creates random values, each pattern will create random rhythms independently of one another. Then when they are unified under a `Pseq`, they will all sound at the same time. With this technique I build up complex rhythms, then convert them to one single rhythm and texture, which I can then build structures on top of.

```supercollider
//A more fleshed-out example
//Start with a random central rhythm, to keep all of the individual parts
//also using a scale as a one-letter variable for quickness
(
p.clock.tempo = 2.32;
l = Pbjorklund2(Pwhite(3,10),16)/4;
e = Scale.chromatic(\et53);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,30),\amp,0.5,\pan,1);
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,30),\amp,0.5,\pan,-1);
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([4,5],[0.8,0.2],inf),\dur,l,\d,0.5,\a,Pexprand(0.5,30),\amp,0.5,\pan,0);
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,0.2,\a,Pexprand(0.5,200),\amp,0.9,\pan,0);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,l,\amp,Pwhite(0.2,1));
~ring1.play;~ring2.play;~ring3.play;~ring4.play;~sn.play;~c.play;~h.play;
)
//unify all of these rhythms
//sounds very different
//execute individual lines to make them diverge from this pattern
(
p.clock.tempo = 2.32;
l = Pbjorklund2(Pseq([3,8,2,5,9,10,14,3,5,5,4,9,14],inf),16)/4;
e = Scale.chromatic(\et53);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,1);
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,-1);
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([4,5],[0.8,0.2],inf),\dur,l,\d,0.5,\a,Pexprand(0.5,90),\amp,0.5,\pan,0);
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,Pexprand(0.2,0.6),\a,Pexprand(1,200),\amp,0.9,\pan,0);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,l,\amp,Pwhite(0.2,1))
)
//throw some straight rhythms in to show where the beat lies
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,1,\rate,1,\amp,3);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,Pwhite(0.5,1),\rate,0.8);
~k.play;
~oh.play;
)
```
