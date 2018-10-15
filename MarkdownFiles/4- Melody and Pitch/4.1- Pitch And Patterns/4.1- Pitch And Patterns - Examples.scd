//load the setup file
("../../Setup/Setup.scd").loadRelative

//freq specifying a raw pitch value
(
~sinfb = Pbind(\instrument,\sinfb,\freq,Pwhite(100,800),\dur,0.1,\amp,0.3,\fb,0.1,\rel,0.3);
~sinfb.play;
)
//frequency being detuned gradually using a gradual increasing of \detine argument
(
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq((1..8),inf)*100,\dur,0.1,\amp,0.3,\fb,0.4,\rel,1,\detune,Pseq((1..400),inf));
)

//using scales inside of Pbinds
//Minor scale in Just intonation, octave varying between 4 and 6, root note varying between 0 and 4 each scale repetition.
//\detune can also be used on top of this to detune scale degrees
(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.minor(\just),\root,Pwhite(0,4).stutter(8),\octave,Pwhite(4,6).stutter(8),\degree,Pseq((0..7),inf),\dur,0.25,\amp,0.3,\fb,1,\rel,0.2);
~sinfb.play;
)

//Chords used by specifying a 2-dimensional array in \degree argument.
//same can be done for the \octave argument
(
~sinfb = Pbind(\instrument,\sinfb,
	\scale,Scale.major,
	\root,0,
	\octave,Pwrand([4,[3,4],[2,3,4]],[0.9,0.08,0.02],inf),
	\degree,Prand([[0,2,4],[2,4,6],[7,2,4],[1,2,3],[0,-2,-4]],inf),
	\dur,Pwhite(5,10),
	\atk,2,\sus,1,\rel,3,\amp,0.3,\fb,0.1);
~modulation = {SinOsc.kr(0.1).range(0.01,1.41)};
~sinfb.play;
~sinfb.set(\fb,~modulation);
)
