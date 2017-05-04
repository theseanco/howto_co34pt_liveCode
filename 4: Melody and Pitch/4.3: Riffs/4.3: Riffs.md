# Riffs

---------

### Examples in music

A [riff](https://en.oxforddictionaries.com/definition/riff) is a short, repeated musical phrase that is used as an anchor or a refrain in a piece of music.

I've always been drawn to guitar music with [riffs](https://www.youtube.com/watch?v=WgF4ZuXVcIo), and riff-heavy electronic music [is](https://www.youtube.com/watch?v=YDZ9HYCAknc) [no](https://www.youtube.com/watch?v=P8JEm4d6Wu4&feature=youtu.be&t=2m16s) [exception](https://www.youtube.com/watch?v=2FmFXQSIzCo). A _great_ example of riff-heavy live coding is the music of [Belisha Beacon's](https://fractalmeat.bandcamp.com/album/this-is-fine), who makes a network of shifting riffs using [ixi lang](http://www.ixi-audio.net/ixilang/).

Here are a few ways I use riffs

### The 'up-down' riff

A technique I've probably ended up using an awful lot is an 'up-down' riff, which is a way of producing a set of interlocking riffs very quickly on the spot. It can be used with any form of pitch organisation, but more common scales and the harmonic series tend to work the best.

The 'up-down' riff uses SuperCollider's `range` method to generate a sequential set of degrees of a scale playing on a SynthDef and running it alongside the same set of degrees `.reverse`-d, creating a palindrome which runs continuously. A third layer, which uses SuperCollider's `.scramble` method to create a random riff to play against the 'up-down' riff, all played in a uniform rhythm:

```supercollider
//up-down riff
//harmonic series version
//re-evaluate individual directions to create a different riff
(
//up
p.clock.tempo = 1.5;
~r = {75};
~sinfb1 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10),inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.3);
~sinfb1.play;
)
(
//down
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).reverse,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.3);
~sinfb2.play;
)
(
//random
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).scramble,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.0),\rel,0.3);
~sinfb3.play;
)

//up-down riff
//minor scale version
//re-evaluate individual directions to create a different riff
(
p.clock.tempo = 1.5;
//up
~sinfb1 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7),inf),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.2);
~sinfb1.play;
)
(
//down
~sinfb2 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7).reverse,inf),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.2);
~sinfb2.play;
)
(
//random, an octave higher
~sinfb3 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,6,\degree,Pseq((0..7).scramble,inf),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.0),\rel,0.2);
~sinfb3.play;
)

```

An important part of this technique is that by re-evaluating individual riffs the overall structure of the riffs as a whole can be changed, giving the resulting sound a different character each time.

It can also be combined with some `Pwrand` based probabilistic rhythmic change to automatically shift the character of the riff:

```supercollider
//replacing duration of 0.25 with a Pwrand which will automatically shift the riffs
(
p.clock.tempo = 1.5;
~sinfb1 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7),inf),\dur,Pwrand([0.25,Pseq([0.125],2)],[0.9,0.1],inf),\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.2);
~sinfb2 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7).reverse,inf),\dur,Pwrand([0.25,Pseq([0.125],2)],[0.9,0.1],inf),\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.2);
~sinfb3 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7).scramble,inf),\dur,Pwrand([0.25,Pseq([0.125],2)],[0.9,0.1],inf),\amp,0.3,\fb,Pwhite(0.1,1.4),\rel,0.2);
)
~sinfb1.play;
~sinfb2.play;
~sinfb3.play;

```

### 'Phasing'

'Phasing' was used extensively by [Steve](https://www.youtube.com/watch?v=7P_9hDzG1i0) [Reich](https://www.youtube.com/watch?v=g0WVh1D0N50) in his early works, and refers to two or more similar or identical musical forms which are played at slightly differing tempi so that they shift and begin to interfere with each other ([more information](https://en.wikipedia.org/wiki/Phase_music)).

There are a few ways to emulate this during sets, both through subtle interference with playing riffs, rhythmic disturbances and omitting notes. Another example can be seen in the section on Euclidean Rhythms and Offsets.

```supercollider
//Phasing
//Using the riff from Reich's Piano Phase
//inspired by https://ccrma.stanford.edu/courses/tu/cm2008/topics/piano_phase/index.shtml
(
p.clock.tempo = 1.8;
//riff 1 and 2 evaluated at once so that they start together.
//riff 2 will sometimes play 0.125 duration which will knock the two out of phase
~sinfb1 = Pbind(\instrument,\sinfb,\octave,4,\freq,Pseq([64, 66, 71, 73, 74, 66, 64, 73, 71, 66, 74, 73].midicps,inf),\dur,0.25,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb2 = Pbind(\instrument,\sinfb,\octave,4,\freq,Pseq([64, 66, 71, 73, 74, 66, 64, 73, 71, 66, 74, 73].midicps,inf),\dur,Pwrand([0.25,0.125],[0.99,0.01],inf),\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb1.play;
)
//play riff 2
~sinfb2.play;

//another version which uses a second riff which has a slightly different tempo constantly
(
p.clock.tempo = 1.8;
//riff 1 and 2 evaluated at once so that they start together.
//riff 2 will sometimes play 0.125 duration which will knock the two out of phase
~sinfb1 = Pbind(\instrument,\sinfb,\octave,4,\freq,Pseq([64, 66, 71, 73, 74, 66, 64, 73, 71, 66, 74, 73].midicps,inf),\dur,0.25,\amp,0.3,\fb,0.8,\rel,0.3);
~sinfb2 = Pbind(\instrument,\sinfb,\octave,4,\freq,Pseq([64, 66, 71, 73, 74, 66, 64, 73, 71, 66, 74, 73].midicps,inf),\dur,0.255,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb1.play;
)
//play riff 2
~sinfb2.play;
```

### Sample stabs

Another way to make riffs is to use pitched samples, and define the pitch of the riff using the `\rate` argument of `bplay`.

A version of this I use quite a lot is derived from '90s rave music:

```supercollider
//synth stabs - try this with both stab 0 and 1.
(
//stab 1
p.clock.tempo = 2.4;
~stab1 = Pbind(\instrument,\bplay,\buf,d["stab"][1],\euclidNum,Pwhite(3,3),\dur,Pbjorklund2(Pkey(\euclidNum),8)/4,\amp,2,\rate,Pseq([1,1,1,1,1,1,0.9,1.1],inf).stutter(3));
~stab1.play;
)
(
//stab 2 - double speed and greater possible number of onsets
~stab2 = Pbind(\instrument,\bplay,\buf,d["stab"][1],\euclidNum,Pwhite(3,11),\dur,Pbjorklund2(Pkey(\euclidNum),16)/4,\amp,1,\rate,Pseq([1,1,1,1,1,1,0.9,1.1],inf).stutter(3)*2);
~stab2.play;
)
(
//stab 3 - double speed again and greater possible number of onsets again
~stab3 = Pbind(\instrument,\bplay,\buf,d["stab"][1],\euclidNum,Pwhite(6,16),\dur,Pbjorklund2(Pkey(\euclidNum),16)/4,\amp,1,\rate,Pseq([1,1,1,1,1,1,0.9,1.1],inf).stutter(3)*4);
~stab3.play;
)
//drums
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1.1,1.9],inf));
~k2 = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1.1,1.9],inf)*2);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(1,6),16)/4,\amp,1);
~fx = Pbind(\instrument,\bplay,\buf,d["fx"][0],\dur,Pwhite(1,6),\amp,1);
~k.play;~sn.play;~fx.play;~k2.play;
)

```

### Place and compound riffs

[Place](http://doc.sccode.org/Classes/Place.html) is 'interlaced embedding of subarrays'. Simply put, if you put a riff inside of another riff (or an array inside of another array), the first level of the array will be played over, and each subsequent value of the subarrays will be iterated over once every time the first level is played. This is really difficult to explain, so have a look at the first numerical example of the Place documentation for this one. Here is an example of how two riffs can be layered together using Place:

```supercollider
//Place - riffs that contain riffs
(
//first riff
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\degree,Place([0,7],inf),\octave,3,\dur,0.25,\d,0.6,\a,Pseq((1..40),inf),\pan,0,\amp,0.5);
~ring1.play;
)
//stop
~ring1.stop;
(
//second riff
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\degree,Place([2,4,3,5,4,6,8,11],inf),\octave,3,\dur,0.25,\d,0.6,\a,Pseq((1..40),inf),\pan,0,\amp,0.5);
~ring1.play;
)
//stop
~ring1.stop;
(
//two riffs laced together with the longer one on the inner level, playing the first riff and then a note of the second
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.minor,\degree,Place([0,7,[2,4,3,5,4,6,8,11]],inf),\octave,3,\dur,0.25,\d,0.6,\a,Pseq((1..40),inf),\pan,0,\amp,0.5);
~ring1.play
)
```

