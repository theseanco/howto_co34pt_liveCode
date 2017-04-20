//load the setup file
("../../Setup/Setup.scd").loadRelative

//SinOscFB - A sine wave that can move between pitch and noise and noisy pitch
(
//polling the modulation of the 'feedback' argument, to show the way in which SinOscFB degrades sine waves
~sinfbstatic = {SinOscFB.ar([330,440],XLine.kr(0.1,500,60).poll(10),0.6)};
~sinfbstatic.play;
)

//a pattern I use regularly with its feedback being modulated from 0 to 20. Notice the difference in sound across the spectrum
(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,[3,4,5],\degree,Pseq([0,0,4,5],inf),\dur,Pbjorklund2(3,8)/4,\amp,0.3,\fb,0.1,\rel,0.3);
~feedback = {SinOsc.kr(0.1,-1,1).range(0,20.0).poll(30)};
~sinfb.set(\fb,~feedback);
~sinfb.play;
)

//Extreme modulation of fundamental frequency
//taking the up-down scale given in the 'riffs' section
(
p.clock.tempo = 2.4;
~r = {75};
~sinfb1 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10),inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.4),\rel,0.1);
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).reverse,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.4),\rel,0.1);
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).scramble,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,2.0),\rel,0.1);
~sinfb1.play;~sinfb2.play;~sinfb3.play;
)
//moving the frequency up and beyond sensible into supersonics - after reading around 5000Hz some interesting aliasing starts to happen
(
~r = {XLine.kr(75,8000,60).poll(10)}
)
//and even further, lower frequencies start reappearing
(
~r = {XLine.kr(8000,30000,60).poll(10)};
)
//using very extreme modulation also gives some interesing results
(
~r = {LFNoise1.kr(0.2).range(30000,90000).poll(10)};
)

//extreme multiplaction of fundamental frequency
//using the previous example, a NodeProxy holding a second multiplier is added onto the \freq argument of each Pbind
(
~r = {75};
~mult = {1};
~sinfb1 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10),inf)*(Pkr(~r)*Pkr(~mult)),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.4),\rel,0.1);
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).reverse,inf)*(Pkr(~r)*Pkr(~mult)),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.4),\rel,0.1);
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).scramble,inf)*(Pkr(~r)*Pkr(~mult)),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,2.0),\rel,0.1);
~sinfb1.play;~sinfb2.play;~sinfb3.play;
)
//increase the multiplcation over time using a .round on a Line.kr UGen. Listen to how the scale is distorted as the multiplcation increases, eventually ending as a series of pulses
(
~mult = {Line.kr(1,60,60).round(1).poll(5)}
)

//Henon2DN - Chaos synths and moving between pitch and noise
(
//henon using a minor pentatonic scale at a high octave.
//The chaos Ugens will need some experimentations if you want subtle variance in sound
//For Henon I found that an a value of 1.3 and a b value of 0.3 renders a pitch in a pattern pretty reliably
//note that the pitches aren't quite the same as 'concert pitch'
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,8,\dur,Pbjorklund2(3,8)/4,\a,Pexprand(1.3,1.3),\b,Pexprand(0.3,0.3),\atk,0,\sus,0,\rel,Pexprand(0.1,0.1),\amp,1);
~henon.play;
)
//increase the variation in the a and b arguments to add more noise to the mix
(
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,8,\dur,Pbjorklund2(3,8)/4,\a,Pexprand(1.3,1.31),\b,Pexprand(0.3,0.31),\atk,0,\sus,0,\rel,Pexprand(0.1,0.1),\amp,1);
)
//notice that this gets very noisy VERY fast.
//adding a little more possiblity to the Pexprands in a and b turns it into pure noise very very fast, while still retaining a little of its pitched character
(
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,8,\dur,Pbjorklund2(3,8)/4,\a,Pexprand(1.3,1.35),\b,Pexprand(0.3,0.35),\atk,0,\sus,0,\rel,Pexprand(0.1,0.1),\amp,1);
)
//even more and noises become cut off and non-sounding.
//the cut off sounds would sound as DC bias, but the SynthDef \henon has a LeakDC on its output to prevent this as it can damage sound systems and is generally quite an unpleasant thing to deal with.
(
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,8,\dur,Pbjorklund2(3,8)/4,\a,Pexprand(1.3,1.45),\b,Pexprand(0.3,0.55),\atk,0,\sus,0,\rel,Pexprand(0.1,0.1),\amp,1);
)
//at this point decreasing the \dur and \rel value turns it into rhythmic percussion
(
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,8,\dur,0.25,\a,Pexprand(1.3,1.45),\b,Pexprand(0.3,0.55),\atk,0,\sus,0,\rel,Pexprand(0.01,0.1),\amp,1);
)
//more extreme possible values - \dur varied, octaves doubled up, more variation in a and b values, more octaves
(
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,[8,12,9,10],\dur,Pwrand([0.25,Pbjorklund2(Pwhite(3,5),8,1)/4,Pseq([0.125],4)],[7,4,1].normalizeSum,inf),\a,Pexprand(1.2,1.55),\b,Pexprand(0.21,0.55),\atk,0,\sus,0,\rel,Pexprand(0.01,0.6),\amp,1);
)
//against a kick drum it takes on a really strange character
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)


//sound of different types of interpolation
//the default in my SynthDefs.scd file is currently to use none:
(
SynthDef(\henon,
	{arg freq=440,mfreq=440,a=1.3,b=0.3,x0=0.30501993062401,y0=0.20938865431933,atk=0.01,sus=1,rel=1,ts=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = Henon2DN.ar(freq,freq+mfreq,a,b,x0,y0,amp);
		env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,ts,2);
		sig = LeakDC.ar(sig);
		sig = sig*env;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);
//the example earlier, with no interpolation (default)
(
p.clock.tempo = 2.2;
~henon = Pbind(\instrument,\henon,\scale,Scale.minorPentatonic,\degree,Pseq([0,2,4,6,7],inf),\octave,[8,12,9,10],\dur,Pwrand([0.25,Pbjorklund2(Pwhite(3,5),8,1)/4,Pseq([0.125],4)],[7,4,1].normalizeSum,inf),\a,Pexprand(1.2,1.55),\b,Pexprand(0.21,0.55),\atk,0,\sus,0,\rel,Pexprand(0.01,0.6),\amp,1);
~henon.play;
)
//now with Linear interpolation
(
SynthDef(\henon,
	{arg freq=440,mfreq=440,a=1.3,b=0.3,x0=0.30501993062401,y0=0.20938865431933,atk=0.01,sus=1,rel=1,ts=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = Henon2DL.ar(freq,freq+mfreq,a,b,x0,y0,amp);
		env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,ts,2);
		sig = LeakDC.ar(sig);
		sig = sig*env;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);
//now with Cubic interpolation
(
SynthDef(\henon,
	{arg freq=440,mfreq=440,a=1.3,b=0.3,x0=0.30501993062401,y0=0.20938865431933,atk=0.01,sus=1,rel=1,ts=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = Henon2DC.ar(freq,freq+mfreq,a,b,x0,y0,amp);
		env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,ts,2);
		sig = LeakDC.ar(sig);
		sig = sig*env;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);