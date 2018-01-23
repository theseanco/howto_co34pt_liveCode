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

//Building non-grid rhythms into L-systems, and adding complexity beyond self-similar patterns
//Super basic L-system
(
l = Prewrite(1,
	(
		//equal to 2 duration units/beats
		1: #[0.25,0.5,0.5,0.25,2],
		0.25: #[1],
),15);
//play a hi-hat with that L-system as a rhythm
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l,\amp,0.8);
~h.play;
);
//Make the L-system more complex. '2' expands into a rhythm that will still fall with the emphasis of the beat.
// This is done by creating an array of random numbers, and using normalizeSum to constrain the array to equalling 1 overall, and multiplying it to spread those random numbers across multiple beats.
//To get an idea of how this works, evaluate this a few times and look at the output in the post window
Array.fill(rrand(4,10),{rrand(1,10)}).normalizeSum * rrand(1,4);
//use this is a variable within an evaluation (when this block is executed, rhythm will remain as a local variable within that evaluation)
//when '2' is expanded, it will expand into a random rhythm
(
var rhythm = Array.fill(rrand(4,10),{rrand(1,10)}).normalizeSum * rrand(1,4);
l = Prewrite(1,
	(
		//equal to 2 duration units/beats
		1: #[0.25,0.5,0.5,0.25,2],
		0.25: #[1],
		2: rhythm
),15);
//play a hi-hat with that L-system as a rhythm
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l,\amp,0.8);
~h.play;
);
//although h contains some really off-kilter rhythms it will resolve back to the beat, and will also still contain the self-similar patterns laid out in the rest of the L-system, combining self-simliar patterns and 'random' rhythms.
//check this with an on-beat kick
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play
//more extreme values can be used of course
(
var rhythm = Array.fill(rrand(30,40),{rrand(1,30)}).normalizeSum * rrand(1,4);
l = Prewrite(1,
	(
		//equal to 2 duration units/beats
		1: #[0.25,0.5,0.5,0.25,2],
		0.25: #[1],
		2: rhythm
),15);
//play a hi-hat with that L-system as a rhythm
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l,\amp,0.8);
~h.play;
);
//Note every time '2' is expanded into a randomly generated rhythm it will expand differently.

//Reduced version of HSPTLFLDHS
//set the tempo
p.clock.tempo = 2;

//Evaluate the entire block with Cmd/Ctrl+Enter, if the post window shows 'FAILURE IN SERVER /s_new too many nodes', wait a couple of seconds and evaluate again.
(
//The L-System used to generate rhythm. For more information see the Prewrite class
(
l = Prewrite(0.25,
	(
		0.25: #[0.25,0.25,0.25,0.5],
		0.5: #[0.25,0.5,0.125,0.125,0.125,0.125],
		0.125: #[0.375,0.125],
		0.375: #[0.375,0.375,1],
		1: #[0.75,0.25],
		0.75: #[16]
),60)
);
//Offsets for each L-system, used to create 'repeating' effects.
//These will sound when both the offset AND the sample instruments are evaluated, the offset will _not_ be inserted on the fly.
//For example, change d[\offstab2] to 0.125 and d[\offstab3] to 0.25, and re-evaluate the entire
d[\offk] = Pseq([0],1);
d[\offh] = Pseq([0],1);
d[\offsn] = Pseq([0],1);
//Multipliers for durations - A multiplier of 2 will double the duration, 0.5 will half the duration, etc.
//Multipliters generally work best if kept to even multiplications & divisions of 1
//These will sound when they are evaluated and can be changed on the fly
//Once the multipliers have been changed it will be very difficult to make individual sampes sound in unison
//The EP starts with all of these in unison and gradually diverges
//NOTE: Very low multipliers or a zero multiplier will crash the server. Exercise caution.
~multk = {3};
~multh = {1};
~multsn = {4};
//kicks
~k = Pbind(\instrument,\bplaym,\buf,d["k"][0],\dur,Pseq([d[\offk],(l * Pkr(~multk))],inf),\amp,1);
~h = Pbind(\instrument,\bplaym,\buf,d["ch"][0],\dur,Pseq([d[\offh],(l * Pkr(~multh))],inf),\amp,0.8,\rate,0.8,\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~sn = Pbind(\instrument,\bplaym,\buf,d["s"][1],\dur,Pseq([d[\offsn],(l * Pkr(~multsn))],inf),\amp,0.8,\rel,1,\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream),\rate,1);
)
//play these to bring in the various samples, then change the multiplier, or change the offset and re-evaluate either the block or re-evaluate the offset and then the Proxy that uses it.
~k.play;
~sn.play;
~h.play;