//Find your MIDI device by running this and checking the available devices in the post window
MIDIClient.init;

//edit the MIDI-enabled setup file to include your own MIDI device

//Once you have done this, load the MIDI-enabled setup file
("../../Setup/Setup_MIDI.scd").loadRelative;

//create a scale for the MIDI pattern to use (note: Scales used with MIDI must conform to 12-tone chromatic format)
d[\scale] = Scale.minor

//Create a very basic MIDI/Kick Drum setup to check if the server latency is correct:
//If the MIDI note and the kick drum are playing at exactly the same time, the .latency method on the MIDI set is correct, if not, it will need tweaking. Note that this will need tweaking every time you set a different server latency or a different latency on your sound card.
(
(
~midiPattern = Pbind(
    \type, \midi,
    \midicmd, \noteOn,
	\midiout, d[\m],
    \chan, 0,
	\scale,d[\scale],
	\degree, 0,
	\octave, 3,
	\dur, 1,
	\legato, 0.01
)
);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1,\rate,3);
~k.play;
)

//Example 1 - MIDI Basics:
//create a basic MIDI pattern
(
~midiPattern = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, d[\m],
	\chan, 0,
	\scale,d[\scale],
	\degree, 0,
	\octave, 3,
	\dur, 1,
	\legato, 0.1
)
)
//elaborate on the pattern a little, changing the degree, octave, duration and legato
(
~midiPattern = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, d[\m],
	\chan, 0,
	\scale,d[\scale],
	\degree, Pseq([0,0,3,4],inf),
	\octave, Pwrand([3,2],[10,1].normalizeSum,inf),
	\dur, Pbjorklund2(3,8)/4,
	\legato, Pexprand(0.1,0.99)
)
)
//add some percussion
(
~tom = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pbjorklund2(Pwhite(3,12),16)/4,\amp,1,\rate,Pexprand(1.5,1.6),\pan,Pwhite(-0.8,0.8));
~tom.play;
)
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pwrand([1,Pbjorklund2(5,8,1)/4],[0.8,0.2],inf),\amp,1);
~k.play
)
//expand the MIDI pattern further:
(
~midiPattern = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, d[\m],
	\chan, 0,
	\scale,d[\scale],
	\degree, Pwhite(-3,5),
	\octave, Pwrand([3,2],[10,1].normalizeSum,inf),
	\dur, Pbjorklund2(Pwhite(10,15),16)/4,
	\legato, Pexprand(0.1,0.99)
)
)

//and so on...

//Example 2 - Microtones:
//create a MIDI pattern with a long legato that creates one held note
(
~midiPattern = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, d[\m],
	\chan, 0,
	\scale,d[\scale],
	\degree, 0,
	\octave, 3,
	\dur, 4,
	\legato, 1
))
//create a bend Pbind (within snippet bend)
(
~midiBend = Pbind(
	\type,\midi,
	\midicmd,\bend,
	\midiout,d[\m],
	\chan,0,
	\dur,1,
	\val,Pwhite(8192,8192)
)
)
//change the bend \val key to get a pitch bend
(
~midiBend = Pbind(
	\type,\midi,
	\midicmd,\bend,
	\midiout,d[\m],
	\chan,0,
	\dur,1,
	\val,Pwhite(0,16384)
)
)
//make the \dur of the bend pattern work independently of the ~midiPattern to get a microtonal pattern within the existing MIDI pattern
(
~midiBend = Pbind(
	\type,\midi,
	\midicmd,\bend,
	\midiout,d[\m],
	\chan,0,
	\dur,Pwhite(0.25,0.75).round(0.25),
	\val,Pwhite(0,16384)
)
)
//change the available notes on the original MIDI pattern to get a greater variation of available tones
(
~midiPattern = Pbind(
	\type, \midi,
	\midicmd, \noteOn,
	\midiout, d[\m],
	\chan, 0,
	\scale,Scale.chromatic,
	\degree, Pwhite(0,2),
	\octave, 3,
	\dur, 4,
	\legato, 1
))
//and so on...