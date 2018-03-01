//generic drum patterns
DDWSnippets.put("kick", "~k = Pbind(\\instrument,\\bplay,\\buf,d[\"k\"][0],\\dur,##1##,\\amp,1);");
DDWSnippets.put("hat","~h = Pbind(\\instrument,\\bplay,\\buf,d[\"ch\"][0],\\dur,##0.25##,\\amp,Pexprand(0.05,1));");
DDWSnippets.put("snare","~sn = Pbind(\\instrument,\\bplay,\\buf,d[\"s\"][0],\\dur,##2##,\\amp,1);");
DDWSnippets.put("clap","~c = Pbind(\\instrument,\\bplay,\\buf,d[\"c\"][0],\\dur,##0.75##,\\amp,1);");
DDWSnippets.put("oh","~oh = Pbind(\\instrument,\\bplay,\\buf,d[\"oh\"][1],\\dur,##Pseq([0.5,Pseq([1],inf)],inf)##,\\amp,1);");
DDWSnippets.put("backforth","~sn = Pbind(\\instrument,\\vplay,\\buf,d[\"s\"][0],\\dur,Pbjorklund2(Pwhite(1,6),16)/4,\\amp,1,\\rate,Prand([-1,1],inf),\\pos,Pkey(\\rate).linlin(-1,1,0.99,0));");
//rave drums
DDWSnippets.put("ravedrums","(
~kbk = Pbind(\\instrument,\\bplay,\\buf,Prand(d[\"breaks175\"],inf),\\dur,16,\\amp,1);
~kbk2 = Pbind(\\instrument,\\bplay,\\buf,Prand(d[\"breaks175\"],inf),\\dur,16,\\amp,1);
)");
//rave piano
DDWSnippets.put("ravepiano","(
~piano1 = Pbind(\\instrument,\\bplay,\\buf,d[\"piano\"][1],\\dur,16,\\amp,1);
~piano2 = Pbind(\\instrument,\\bplay,\\buf,d[\"piano\"][1],\\dur,32,\\amp,1,\\rate,0.5);
)");
//quarter note Piano Chop
DDWSnippets.put("pianochop","~pianoChop = Pbind(\\instrument,\\vplay,\\buf,d[\"piano\"][1],\\dur,0.25,\\atk,0,\\sus,0.04,\\rel,0,\\pos,Pexprand(0.2,0.5),\\amp,1,\\rate,2)");
//Rave piano stabs
DDWSnippets.put("pianostab","~ravestab2 = Pbind(\\instrument,\\bplay,\\buf,d[\"stab\"][2],\\dur,Pbjorklund2(3,8)/4,\\rate,Pseq([50,52,55,57].midicps/120,inf).stutter(6),\\amp,1)");
//strings
DDWSnippets.put("strings","~strings = Pbind(\\instrument,\\bplay,\\buf,d[\"strings\"][0],\\dur,10,\\rate,3,\\amp,2)");


//hi pass
DDWSnippets.put("hipass","~hipass = {HPF.ar(Mix.ar([~kbk.ar,~kbk2.ar]),1200,0.6)}");


//Specific pattern generators
DDWSnippets.put("Prand","Prand([##1,0##],inf)");
DDWSnippets.put("Pwrand","Pwrand([##1,0##],[10,1].normalizeSum,inf)");
DDWSnippets.put("e8", "Pbjorklund2(##3##,8)/4");
DDWSnippets.put("e16","Pbjorklund2(##3##,16)/4");
DDWSnippets.put("offbeat","Pseq([0.5,Pseq([1],inf)],inf)");
DDWSnippets.put("Pexprand","Pexprand(##0.001,1##)");
DDWSnippets.put("Pseq","Pseq([##1,2,3,4,5##],inf)");

//Scales
DDWSnippets.put("scale","Scale.chromatic(\\et53);");
DDWSnippets.put("root","~r = {0}");

//Modulation snippets
DDWSnippets.put("EnvPerc","EnvGen.ar(Env.perc(##0.01,1##),Impulse.kr(p.clock.tempo),1,0,1,0)");
DDWSnippets.put("LFN1","LFNoise1.kr(0.1).range(##100,3000##).round(100)");
DDWSnippets.put("SinOsc","{SinOsc.kr(0.1).range(##0.01,1.01##)}");

//instrument generators
//DFM1 drone
DDWSnippets.put("DFMDrone","{DFM1.ar(SinOsc.ar([##100,101##],0,0.1),200,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};");
//'ring' acid bass sound
DDWSnippets.put("ring1","Pbind(\\instrument,\\ring1,\\f,Pkey(\\freq),\\scale,d[\\scale],\\root,Pkr(~r),\\degree,0,\\octave,4,\\dur,##1##,\\d,0.6,\\a,1,\\pan,0,\\amp,0.5);");
//ring sound with no scale
DDWSnippets.put("ring1f","Pbind(\\instrument,\\ring1,\\f,Pkr(~r2),\\dur,##1##,\\d,0.6,\\a,1,\\pan,0,\\amp,0.5);");
//sinfb Pbind - no scale
DDWSnippets.put("sinfb","Pbind(\\instrument,\\sinfb,\\freq,Pseq([##1,2,3,4,5##],inf)*Pkr(~r2),\\dur,0.25,\\amp,0.3,\\fb,0.1,\\rel,0.3);");
//sinfb Pbind - using a scale
DDWSnippets.put("sinfbscale","Pbind(\\instrument,\\sinfb,\\scale,d[\\scale],\\root,Pkr(~r),\\octave,4,\\degree,##0##,\\dur,0.25,\\amp,0.3,\\fb,0.1,\\rel,0.3);");
//henon Pbind
DDWSnippets.put("henon","Pbind(\\instrument,\\henon,\\freq,44100,\\dur,0.25,\\a,Pexprand(1.3,1.3),\\b,Pexprand(0.3,0.3),\\atk,0,\\sus,0,\\rel,Pexprand(##0.01,0.1##),\\amp,1);");
//RLPFD instrument - a drone using LFSaws. 'speed' argument is for quickness when setting up harmonic series sweeps
DDWSnippets.put("rlpfd","~rlpfd = {arg speed = 0.5; RLPFD.ar(Mix(LFSaw.ar([120, 180], 0, 0.33)), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 1500), 0.6, 0.5, mul:3).dup }");
//Streson instrument - a drone using LFSaws. 'speed' argument controls speed of sweep and min/max. res controls strength of the effect.
DDWSnippets.put("stresondrone","{ Streson.ar(LFSaw.ar([220, 180], 0, mul:EnvGen.kr(Env.asr(0.5, 1, 0.02), 1.0) * 0.2), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 377).reciprocal, 0.9, 0.3) }");
//rave stabs
DDWSnippets.put("ravestabs","~ravestab = Pbind(\\instrument,\\bplay,\\buf,d[\"stab\"][1],\\dur,Pbjorklund2(3,8)/4,\\rate,Pseq([1,1,1,1,1,1,0.9,1.1]##*1##,inf).stutter(3),\\amp,1)");
//warp1 - scrolls a buffer
DDWSnippets.put("warp1","~warp1 = {arg speed = 0.01, winsize = 0.2, rate = 1; Warp1.ar(2,##d[\"rhodes\"][0]##,LFTri.kr(speed),rate,winsize,-1,16,0.02,4,0.5)}");

//effects
//Low Pass Filter
DDWSnippets.put("LPF","
//Low Pass
~lpfSend = {Mix.ar([##~one##])};
~lpf = {RLPF.ar(NumChannels.ar([~lpfSend]),SinOsc.kr(0.1).range(440,440),0.1)};
~lpf.play;");
//Hi-Pass Filter
DDWSnippets.put("HPF","
//High Pass
~hpfSend = {Mix.ar([##~one##])};
~hpf = {RHPF.ar(NumChannels.ar([~lpfSend]),SinOsc.kr(0.1).range(440,440),0.1)};
~lpf.play;");
//Delay - CombC
DDWSnippets.put("Delay","
//delay
~delaySend = {Mix.ar([##~one##])};
~delay = {CombC.ar(NumChannels.ar([~delaySend]),p.clock.tempo*4,p.clock.tempo/16,1)};
~delay.play;");
//Reverb - GVerb
DDWSnippets.put("Reverb","
//delay
~reverbSend = {Mix.ar([##~one##])};
~reverb = {arg size = 10, time = 5, damping = 0.5, spread = 15, dry = 0, amp = 0.8; GVerb.ar(Mix.ar([~reverbSend.ar]),size,time,damping,0.5,spread,dry,mul:amp)}
~reverb.play;");
//low shelf on rave drums
DDWSnippets.put("lowshelf","~lsf = {LowShelf.ar(Mix.ar([~kbk.ar,~kbk2.ar]),200,1,##10##)}");

//Streson - speed controls speed of sweep and min/max control minimum and maximum values. Keep them low and with not a lot between for sensible effects and don't for silly ones. res controls the severity of the effect
DDWSnippets.put("stresonsend","
//streson
~stresonSend = {Mix.ar([##~one##])};
~streson = {arg speed = 0.01, min = 0.00001, max = 0.0001, res = 0.99; Streson.ar(NumChannels.ar([~stresonSend.ar]),SinOsc.kr(speed).range(min,max),res)};
~streson.play;");
//rlpfd filter
DDWSnippets.put("rlpfdFilter","
//rlpfd
~rlpfdSend = {Mix.ar([##~one##])};
~rlpfd = {arg speed = 0, min = 200, max = 500, res = 0.5, dist = 0.5; RLPFD.ar(NumChannels.ar([~rlpfdSend]),SinOsc.kr(speed).range(min,max),res,dist,3)};
~rlpfd.play;");
//DFM1 filter - freq, res, noise self-explanatory. type 0 = LPF 1 = HPF
DDWSnippets.put("dfm1Filter","
~dfm1Send = {Mix.ar([##~one##])};
~dfm1Filt = {arg freq = 1000, res = 0.7, noise = 0.0003, type = 0; DFM1.ar(NumChannels.ar([~dfm1Send]),freq,res,1,type,noise,1)};
~dfm1Filt.play;");




//generic Tdef snippet
DDWSnippets.put("Tdef","
(
Tdef(\\task,{
	loop{
		##stuff.do##
		1.wait;
}});
)
Tdef(\\task).play;");

//added on 22nd September 2017

//generic MIDI snippet
DDWSnippets.put("MIDI","
(
~midiPattern = Pbind(
    \\type, \\midi,
    \\midicmd, \\noteOn,
	\\midiout, d[\\m],
    \\chan, 0,
	\\scale,d[\\scale],
    \\root,Pkr(~r),
	\\degree, ##0##,
	\\octave, 3,
	\\dur, 1,
	\\legato, 0.1
)
)");

//generic Pitch Bend snippet for microtonal patterns
DDWSnippets.put("bend","
(
~midiBend = Pbind(
\\type,\\midi,
\\midicmd,\\bend,
\\midiout,d[\\m],
\\chan,0,
\\dur,1,
\\val,Pwhite(##8192,9182##)
)
)");

//offbeat cymbal
DDWSnippets.put("cym","~cym = Pbind(\\instrument,\\bplay,\\buf,d[\"cym\"][0],\\dur,Pseq([0.5,Pseq([1],inf)],inf),\\rel,##0.5##,\\amp,0.5)");

//toms
DDWSnippets.put("tom","~tom = Pbind(\\instrument,\\bplay,\\buf,d[\"t\"][0],\\dur,Pbjorklund2(3,16)/4,\\amp,1,\\rate,1)");

//synth verb
DDWSnippets.put("synthverb","~synth = {Pan2.ar(FreeVerb.ar(SoundIn.ar(0),0.33,##0.7##,0.5))}");

//looped sound
DDWSnippets.put("loop","~loop = Pbind(\\instrument,\\lplay,\\buf,d[\"breaks\"][0],\\dur,##8##,\amp,0.5)");

//enveloped warp1
DDWSnippets.put("warpenv","(
~warpEnv = {var env = EnvGen.ar(Env.perc(0.01,0.5,0.1),Impulse.kr(LFNoise1.kr(0.1).range(0.5,4)),1,0,1,0);
	Warp1.ar(2,##d[\"rhodes\"][0]##,LFTri.kr(0.01)+env,2,0.2,-1,32,0.01,4,env*4)}
)");

//Reverb send
DDWSnippets.put("reverbsend","(
~verbSend = {
	var array = [##~none.ar##];
	FreeVerb.ar(Mix.ar(array),0.33,0.5,0.5,1.5)
}
)");

//Delay send
DDWSnippets.put("delaysend","(
~delaySend = {
	var array = [##~none.ar##];
    CombC.ar(Mix.ar(array),1,0.1,1,1)
}
)");

//synth external reverb send
DDWSnippets.put("synthexternal","
(
~synthExt = {Out.ar(2,Pan2.ar(SoundIn.ar(0)))};
~synthDry = {Pan2.ar(SoundIn.ar(0),0)};
~synthWet = {SoundIn.ar([2,3],1.4)};
)
");

//generic external effects send
DDWSnippets.put("external","
(
~extSend = {Out.ar(2,##Pan2.ar(SoundIn.ar(0))##)};
~extDry = {Pan2.ar(SoundIn.ar(0),0)};
~extWet = {SoundIn.ar([2,3],1.4)};
)
");

//trap rhythm, designed for those crisp 808 hi hats
DDWSnippets.put("trap","Pwrand([1,0.5,0.25,Pseq([0.125],2),Pseq([0.125/2],4)],[0.5,2,14,3,2].normalizeSum,inf)");

//Chords, taken/adapted from Eli Fieldsteel's video on compositions in SuperCollider
DDWSnippets.put("chords","
(
~chords = Pbind(\\instrument,\\bpfsaw,
	\\dur,Pwhite(4.5,7.0,inf),
	\\scale,Scale.chromatic,
	\\root,Pkr(~r),
	\\octave,4,
	\\degree,Pseq(ChordProg.getMinorProg(\\c,\\sad),inf),
	\\detune, Pexprand(0.05,0.2,inf),
	\\cfmin,100,
	\\cfmax,1500,
	\\rqmin,Pexprand(0.02,0.15,inf),
	\\atk,Pwhite(2.0,2.5,inf),
	\\rel,Pwhite(6.5,10.0,inf),
	\\ldb,6,
	\\amp,Pwhite(0.8,2.0),
	\\out,0)
)
");

//a rhythmic l system
DDWSnippets.put("lsysrhythm","
(
l = Prewrite(0.25,
	(
		0.25: #[0.25,0.25,0.25,0.5],
		0.5: #[0.25,0.5,0.125,0.125,0.125,0.125],
		0.125: #[0.375,0.125],
		0.375: #[0.375,0.375],
		1: #[1,0.25]
),10)
)
");

DDWSnippets.put("StabScaffolding",
	"(
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

d[\\offk] = Pseq([0],1);
d[\\offh] = Pseq([0],1);
d[\\offsn] = Pseq([0],1);

d[\\offstab] = Pseq([0],1);
d[\\offstab2] = Pseq([0],1);
d[\\offstab3] = Pseq([0],1);

d[\\offtom] = Pseq([0],1);
d[\\offtom2] = Pseq([0],1);
d[\\offtom3] = Pseq([0],1);


~multk = {1};
~multh = {1};
~multsn = {1};

~multstab = {1};
~multstab2 = {1};
~multstab3 = {1};

~multtom = {1};
~multtom2 = {1};
~multtom3 = {1};

~stab1rate = 1;
~stab2rate = 1;
~stab3rate = 1;

~tom1rate = 1;
~tom2rate = 1;
~tom3rate = 1;

//kicks
~k = Pbind(\\instrument,\\bplaym,\\buf,d[\"k\"][2],\\dur,Pseq([d[\\offk],(l * Pkr(~multk))],inf),\\amp,1);
~h = Pbind(\\instrument,\\bplay,\\buf,d[\"ch\"][2],\\dur,Pseq([d[\\offh],(l * Pkr(~multh))],inf),\\amp,0.8,\\rate,2,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~sn = Pbind(\\instrument,\\bplaym,\\buf,d[\"s\"][5],\\dur,Pseq([d[\\offsn],(l * Pkr(~multsn))],inf),\\amp,0.8,\\rel,1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));


/*
//good stabs

5 -
25
119 organ
134
145
168
175
190
201
213 (ish)
233 (just a beep)
260

*/

//stabs
~stab = Pbind(\\instrument,\\bplay,\\buf,d[\"stabs\"][5],\\dur,Pseq([d[\\offstab],(l * Pkr(~multstab))],inf),\\amp,0.7,\\rate,Pkr(~stab1rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~stab2 = Pbind(\\instrument,\\bplay,\\buf,d[\"stabs\"][5],\\dur,Pseq([d[\\offstab2],(l * Pkr(~multstab2))],inf),\\amp,0.7,\\rate,Pkr(~stab2rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~stab3 = Pbind(\\instrument,\\bplay,\\buf,d[\"stabs\"][5],\\dur,Pseq([d[\\offstab3],(l * Pkr(~multstab3))],inf),\\amp,0.7,\\rate,Pkr(~stab3rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));

//toms
~tom = Pbind(\\instrument,\\bplaym,\\buf,d[\"t\"][2],\\dur,Pseq([d[\\offtom],(l * Pkr(~multtom))],inf),\\amp,0.7,\\rate,Pkr(~tom1rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~tom2 = Pbind(\\instrument,\\bplaym,\\buf,d[\"t\"][2],\\dur,Pseq([d[\\offtom2],(l * Pkr(~multtom2))],inf),\\amp,0.7,\\rate,Pkr(~tom2rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
~tom3 = Pbind(\\instrument,\\bplaym,\\buf,d[\"t\"][2],\\dur,Pseq([d[\\offtom3],(l * Pkr(~multtom3))],inf),\\amp,0.7,\\rate,Pkr(~tom3rate),\\rel,0.1,\\pan,Pwhite(-0.8,0.8).stutter(Pwhite(40,100).asStream));
)
");

//Streson string effect
DDWSnippets.put("streson","~streson = {Streson.ar(##Silent.ar##,0.0003,1,1)}");
