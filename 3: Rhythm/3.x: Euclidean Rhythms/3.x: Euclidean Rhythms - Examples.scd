/*

These examples are extracted from section 3.x - Euclidean Rhythms

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
//sounds even better with a banging donk on it
(
~sk = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,1,\amp,4);
~sk.play;
)