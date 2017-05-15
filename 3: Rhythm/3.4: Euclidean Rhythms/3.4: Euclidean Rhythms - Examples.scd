/*

These examples are extracted from section 3.x - Euclidean Rhythms

Individual examples are separated by a blank line

I'd advise hard-stopping (Ctrl+.) between examples

*/

//Load setup file to get examples working
("../../Setup/Setup.scd").loadRelative

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


//Complex rhythm that obfuscates the central rhythmic centre
(
p.clock.tempo = 1.45;
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
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf)/2,\amp,1);
~oh.play
)

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
//now individually evaluate (Shift+Enter) some of these lines to refresh the 'dur'. Listen for variations in rhythm.
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,0.9);
~c3 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1,\rate,1.1);
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
//if you want to reset, execute the block again


//A more fleshed-out example
//Start with a random central rhythm, to keep all of the individual parts seperate
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
//sounds very different, with all elements sounding at the same time.
//execute individual lines to make them diverge from this pattern
(
p.clock.tempo = 2.32;
l = Pbjorklund2(Pseq([3,8,2,5,9,10,14,3,5,5,4,9,14],inf),16)/4;
e = Scale.chromatic(\et53);
~ring1 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,1);
~ring2 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-2,2),\octave,Pwrand([3,4],[0.8,0.2],inf),\dur,l,\d,0.4,\a,Pexprand(0.5,90),\amp,0.5,\pan,-1);
~ring3 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([4,5],[0.8,0.2],inf),\dur,l,\d,0.5,\a,Pexprand(0.5,90),\amp,0.5,\pan,0);
~ring4 = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,e,\root,0,\degree,Pwhite(-5,5),\octave,Pwrand([2,3],[0.8,0.2],inf),\dur,l,\d,Pexprand(0.2,0.6),\a,Pexprand(1,900),\amp,0.9,\pan,0);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l,\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,l,\amp,Pwhite(0.2,1))
)
//throw some straight rhythms in to show where the beat lies - this one i could genuinely listen to for a while...
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,1,\rate,1,\amp,3);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,Pwhite(0.5,1),\rate,0.8);
~k.play;
~oh.play;
)
