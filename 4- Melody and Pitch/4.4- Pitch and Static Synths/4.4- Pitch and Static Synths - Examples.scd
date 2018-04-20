//load the setup file
("../../Setup/Setup.scd").loadRelative

//set a fundamental frequency
~f = {70}
//a fixed pitch sine wave, using a fundamental frequency
(
~sin = {SinOscFB.ar([~f,~f*1.01],0.7,0.3)};
~sin.play;
)
//4 saw waves that are modulated by LFNoise1 Ugens and arranged around the stereo field
//the frequency of the saw waves is a LFNoise1 that is ranged between the fundamental and ten times the fundamental
(
~lfn1 = {Splay.ar(Saw.ar(Array.fill(4,{LFNoise1.kr(0.3).range(~f,~f*10)}),0.3))};
~lfn1.play;
)
//now round this LFNoise1 to the fundamental frequency to get the frequency to sweep the harmonic frequency
(
~lfn1 = {Splay.ar(Saw.ar(Array.fill(4,{LFNoise1.kr(0.3).range(~f,~f*10).round(~f)}),0.3))};
~lfn1.play;
)
//the frequencies are now tuned and sound GREAT (an X/Y scope also looks amazing)
s.scope
//This .range and .round method can be applied to any signal UGen, and also at any multiplication level. Here's a silly extreme example that sounds like shrill bees
(
~lfn1 = {Splay.ar(Saw.ar(Array.fill(40,{SinOscFB.kr(rrand(0.1,0.3),rrand(0.1,2)).range(~f,~f*100).round(~f*4)}),0.4))};
~lfn1.play;
)

//Triggered random frequency changes, using something like TRand
(
~f = {81};
~tChange = {Pulse.ar(TRand.kr(~f,~f*10,Dust.kr(4)).round(~f),SinOsc.kr(0.1).abs,0.6)*SinOsc.ar([~f,~f*1.01])};
~tChange.play;
)

//specific and on-demand frequency changes using Demand.kr - Note that this is *really* verbose for something to be used live.
//I've used an Impulse.kr that recieves the tempo clock as a trigger to show how these synths can be synced to a central tempo clock
//Demand is a lot like having a Pattern inside of a UGen's arguments. Look at the helpfile, it's really cool
(
~f = {66.6};
~dChange = {SawDPW.ar([~f,~f*1.02]*Demand.kr(Impulse.kr(p.clock.tempo*3),0,Dseq([1,8,2,7,3,6,4,5],inf)),SinOsc.kr(40),0.8)};
~dChange.play;
)
//and a kick to show it's synced
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,1,\amp,1);
~k.play;
)
//and more kicks because i really liked this one
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(Pwhite(1,15),16)/6,\amp,2,\rate,Pwrand([1,1.2,1.4,2,4],[0.55,0.2,0.1,1,0.05],inf)*1.5);
~k2 = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,1,\amp,2);
~k2.play;
)

//Scale and DegreeToFreq
//using the Demand example again
//a fifth
(
~scale = {SinOscFB.ar(Scale.minor(\just).degreeToFreq([0,4],48.midicps,1),0.7,0.2)};
~scale.play;
)
//Note that the above does not allow scale notes to be changed once the synth is initiated
~scale = {SinOscFB.ar(Scale.minor(\just).degreeToFreq(TRand.kr(1,10,Impulse.kr(1)),48.midicps,1),0.7,0.2)};

(
//using .midicps to determine pitch
~scale = {SinOscFB.ar(TRand.kr(50,80,Impulse.kr([3,3.01])).midicps,0.7,0.5)};
~scale.play;
)

