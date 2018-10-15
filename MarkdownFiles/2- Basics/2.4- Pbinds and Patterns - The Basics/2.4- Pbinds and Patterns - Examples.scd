/*

These examples are extracted from section 2.4 - Pbinds and Patterns - The Basics

I'd advise hard-stopping (Ctrl+.) between examples

*/

//Load setup file to get examples working
("../../Setup/Setup.scd").loadRelative

//So, if I wanted to have a kick drum playing once each beat in time with the ProxySpace timer, after I had run my setup file I would do the following:
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1);
~k.play;
)


//This will return a syntax error
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\rate);

//As part of these key-value pairs, Pbinds can take Pattern classes as inputs. [`Pwhite`](http://doc.sccode.org/Classes/Pwhite.html) gives random values between a minimum and maximum. If I wanted to specify a random pitch of the kick drum, I could add this to the pattern:
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\rate,Pwhite(1,1.2));
~k.play;
)

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

//Here, the `freq` argument is the pitch of the oscillator. Pitch can be specified manually, like so:
(
~sinfb = Pbind(\instrument,\sinfb,\dur,0.25,\freq,Pwhite(100,900));
~sinfb.play;
)

//run up and down chromatic scale one degree at a time
(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.chromatic(\et12),\degree,Pseq((0..12).pyramid.mirror,inf),\octave,6,\dur,0.125/2,\amp,0.3,\fb,0.8,\rel,0.1);
~sinfb.play;
)
