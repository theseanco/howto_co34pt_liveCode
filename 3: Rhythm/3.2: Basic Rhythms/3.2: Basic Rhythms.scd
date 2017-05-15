//3.2 - Basic Rhythms - Examples

//Load setup file to get examples working
("../../Setup/Setup.scd").loadRelative

//basic kick
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)

//alternate-beat snare
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,2,\amp,1);
~sn.play;
)

//basic hi-hat pattern
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,0.25,\amp,Pwhite(0.25,1));
~h.play
)

//3/4 note clap
(
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c.play;
)

//off-beat open hi-hat
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][0],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)
