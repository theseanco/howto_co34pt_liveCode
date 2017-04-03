//load setup file
("../../Setup/Setup.scd").loadRelative

//make this better
//use L-system as a duration value for a kickdrum
(
l = Prewrite(1, // start with 0
        (    1: [0.25,1,2],
            0.25: [0.25,0.75,1],
        ), 4);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,l,\amp,1);
~k.play;
)