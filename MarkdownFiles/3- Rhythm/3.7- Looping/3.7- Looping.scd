//load setup file
("../../Setup/Setup.scd").loadRelative

//set tempo to level of breaks
p.clock.tempo = 175/60

//make background for loops
~stab = Pbind(\instrument,\bplay,\buf,d["stab"][0],\dur,Pbjorklund2(3,8)/4,\rate,Pseq([1,1,0.9,1.1],inf).stutter(3),\amp,0.6)


//reload SynthDefs.scd for the updated tempo
("../../Setup/SynthDefs.scd").loadRelative

//make breaks using lplay
~loop = Pbind(\instrument,\lplay,\buf,d["breaks175"][4],\dur,16,\amp,1)
~loop.play

//if they are out of sync, trigger together
(
~loop = Pbind(\instrument,\lplay,\buf,d["breaks175"][4],\dur,16,\amp,1);
~stab = Pbind(\instrument,\bplay,\buf,d["stab"][0],\dur,Pbjorklund2(3,8)/4,\rate,Pseq([1,1,0.9,1.1],inf).stutter(3),\amp,0.6)
)

//if you're going to be reloading the tempo a lot it might be nice to specify this as a function
a = {("../../Setup/SynthDefs.scd").loadRelative}

p.fadeTime = 0

(
//set random tempo
p.clock.tempo = rrand(2.0,3.0);
//reload synthdefs
a.();
~loop = Pbind(\instrument,\lplay,\buf,d["breaks175"][4],\dur,16,\amp,1);
~stab = Pbind(\instrument,\bplay,\buf,d["stab"][0],\dur,Pbjorklund2(3,8)/4,\rate,Pseq([1,1,0.9,1.1],inf).stutter(3),\amp,0.6)
)

//more stabs for fun
~stab2 = Pbind(\instrument,\bplay,\buf,d["stab"][0],\dur,Pbjorklund2(Pwhite(4,11),16)/4,\rate,Pseq([2,2,2,2,2,2,1.8,2.2],inf).stutter(3),\amp,0.7)
~stab2.play

//in its current state, it is a little bit janky, but it does work to set loops to tempo