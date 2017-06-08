//load setup file
("../../Setup/Setup.scd").loadRelative

//use L-system as a duration value for a kickdrum
(
l = Prewrite(1, // start with 1
        (    1: [0.25,2],
            0.25: [3,3,2]/4,
		3/4: [0.25,1,0.125,0.125],
        ), 4);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,l,\amp,1);
~k.play;
)
/*

With that grammar:

1 -> 0.25,2 -> 3/4,3/4,2/4 -> 0.25,1,0.125,0.125,0.25,1,0.125,0.125 -> etc.

*/
//much like with the euclidean rhythm convergence/divergence pattern, you can use variable l for different patterns too
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1,\rate,Pseq((1..4)/2,inf));
~sn.play;
)
//and transform it
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l,\stretch,Pwhite(0.5,2).round(0.5),\amp,Pwhite(0.2,1));
~h.play;
)
//an off-beat open hat for reference
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)

