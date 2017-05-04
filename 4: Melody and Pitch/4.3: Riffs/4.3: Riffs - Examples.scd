//load setup file
("../../Setup/Setup.scd").loadRelative

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