//load setup file
("../../Setup/Setup.scd").loadRelative

//Random rhythm with Pwhite
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0),\amp,1);
~sn.play;~h.play;~c.play;~t.play;
)
//even with a regular kickdrum the other rhythms don't sound good
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play
)

//same example but with all rhythms constrained
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0).round(1),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75).round(0.25),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2).round(0.75),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0).round(0.5),\amp,1);
~sn.play;~h.play;~c.play;~t.play;
)
//sounds more palatable with everything arranged properly
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play
)

//same example again
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pwhite(1,5.0).round(1),\amp,1);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwhite(0.25,0.75).round(0.25),\amp,Pwhite(0.2,1));
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pwhite(0.75,2).round(0.75),\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pwhite(1,5.0).round(0.5),\amp,1);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~sn.play;~h.play;~c.play;~t.play;~k.play;
)
//added whole note fx, short, medium and long.
(
~fx1 = Pbind(\instrument,\bplay,\buf,d["sfx"][0],\dur,Pwhite(1,5),\amp,1);
~fx2 = Pbind(\instrument,\bplay,\buf,d["fx"][0],\dur,Pwhite(1,10),\amp,1);
~fx3 = Pbind(\instrument,\bplay,\buf,d["lfx"][0],\dur,Pwhite(10,40),\amp,1);
~fx1.play;~fx2.play;~fx3.play;
)

//layering at different pitches - kicks
(
p.clock.tempo = 2.3;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1.2],inf));
~k.play;
)
//kicks at a different pitch. Evaluate this a few times to get different permutations
(
~k2 = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1,1.8],inf)*4);
~k2.play;
)

//layering of slightly different rhythms
//rhythm 1
(
p.clock.tempo = 1.7;
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t.play;
)
//rhythm 2, using a different tom for contrast
//also re-evaluating rhythm 1 to get them playing together
(
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pseq([1,1,1,0.25],inf),\amp,1);
~t2.play;
)
//rhythm 3 for more
(
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,Pseq([1,1,1,0.5],inf),\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][1],\dur,Pseq([1,1,1,0.25],inf),\amp,1);
~t3 = Pbind(\instrument,\bplay,\buf,d["t"][2],\dur,Pseq([1,1,1,0.75],inf),\amp,1);
~t3.play;
)
//kick underneath to illustrate
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\rate,1);
~oh.play;
~k.play;
)

//complimentary rhythms:
//the 'polyrhythmic clap' from the Basics example
(
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c.play;
)
//clap added at a similar rhythm (euclidean 3,8)
(
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pbjorklund2(3,8)/4,\amp,1);
~c2.play;
)


//StageLimiter throttling
//a complex rhythm
(
l = Prewrite(1, // start with 1
        (    1: [0.25,2],
		0.25: [1,0.75,0.1,0.3,0.6,0.1],
		0.1: [0.5,1,2],
		2: [0.5,0.75,0.5,1]
        ), 4);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l/2,\amp,1,\rate,2);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,l*2,\amp,1);
~t = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,l,\amp,1,\rate,Pseq([1.2,1.4,1.7],inf));
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l*4,\amp,1,\rate,0.8);
~ding = Pbind(\instrument,\bplay,\buf,d["ding"][0],\dur,Pwhite(1,5),\amp,1,\rate,0.2);
~h.play;~c.play;~t.play;~ding.play;~sn.play;
)
//extremely loud kick throttles everything elese
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,4,\amp,100,\rate,0.5);
~k.play;
)

//trap(ish) hi-hats
//Has a choice of four rhythmic patterns with lesser chance for each, results in a mostly 0.25-duration hat which can potentially go quite quickly
(
p.clock.tempo = 75/60;
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwrand([0.25,Pseq([0.125],4),Pseq([0.25]/3,3),Pseq([0.125]/2,4)],[0.6,0.3,0.09,0.01],inf),\amp,1,\rate,2);
~h.play;
)

//occasional variation on 4/4 kick
(
p.clock.tempo = 2.3;
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pwrand([1,Pseq([0.75],4),Pbjorklund2(3,8,1)/4],[0.9,0.08,0.02],inf),\amp,1);
~k.play
)
//open hat for reference
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\rate,1.4);
~oh.play;
)

//cutoff percussion. This Pbind uses (0..100)/100 to split the sample into 100 sections of 0.03 and play over them
(
p.clock.tempo = 2.4;
~perc = Pbind(\instrument,\vplay,\buf,d["fx"][1],\rel,0.03,\dur,0.25,\pos,Pseq((0..100)/100,inf));
~perc.play;
)

//sputtering rhythms based on long percussion sounds
//the Prand for \buf is a flattened array of all fx sounds. If it wasn't flat it would play all sounds from any fx entry all at once
(
p.clock.tempo = 2.3;
~perc = Pbind(\instrument,\vplay,\buf,Prand([d["fx"],d["sfx"],d["lfx"]].flat,inf),\rel,0.1,\dur,0.25,\pos,Pwhite(0,0.9),\rate,Pwhite(1,3.0));
~perc.play;
)
//choose from literally every sample there is in d. Buggy because it'll also play anything else that is in there, but good for a laugh.
(
~perc = Pbind(\instrument,\vplay,\buf,Prand(d.values,inf),\rel,0.1,\dur,0.25,\pos,Pwhite(0.0,0.9),\rate,Pwhite(1,3.0));
~perc.play;
)

//back-and-forth snare
(
~sn = Pbind(\instrument,\vplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(1,6),16)/4,\amp,1,\rate,Prand([-1,1],inf),\pos,Pkey(\rate).linlin(-1,1,0.99,0));
~sn.play;
)


//.normalizeSum rhythmic spread
//spreading 1-20 over four beats
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..20).normalizeSum,inf)*4,\amp,Pwhite(0.2,1));
~h.play;
)
//spreading 1-200 over sixteen beats (gives overtone)
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..200).normalizeSum,inf)*16,\amp,Pwhite(0.2,1));
//spreading 1-18 over 8 beats
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pseq((1..18).normalizeSum,inf)*8,\amp,Pwhite(0.2,1));


//using the \stretch argument - each time a cycle completes change the stretch duration
//a non-synthdef argument is created here - \euclidNum is used to inform both \dur and \stretch to ensure both work with the same number of onsets
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\euclidNum,Pwhite(1,7),\dur,Pbjorklund2(Pkey(\euclidNum),8)/4,\amp,1,\rate,Pseq([3,4,5],inf),\stretch,Pseq([1,0.5,0.25,2],inf).stutter(Pkey(\euclidNum).asStream));
~k.play;
)
