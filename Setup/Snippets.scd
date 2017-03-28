//generic drum patterns
DDWSnippets.put("kick", "~k = Pbind(\\instrument,\\bplay,\\buf,d[\"k\"][0],\\dur,##1##,\\amp,1);");
DDWSnippets.put("hat","~h = Pbind(\\instrument,\\bplay,\\buf,d[\"ch\"][0],\\dur,##0.25##,\\amp,Pwhite(0.2,1));");
DDWSnippets.put("snare","~sn = Pbind(\\instrument,\\bplay,\\buf,d[\"s\"][0],\\dur,##2##,\\amp,1);");
DDWSnippets.put("clap","~c = Pbind(\\instrument,\\bplay,\\buf,d[\"c\"][0],\\dur,##0.75##,\\amp,1);");
DDWSnippets.put("oh","~oh = Pbind(\\instrument,\\bplay,\\buf,d[\"oh\"][1],\\dur,##Pseq([0.5,Pseq([1],inf)],inf)##,\\amp,1);");

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
DDWSnippets.put("DFMDrone","{DFM1.ar(SinOsc.ar([##100,101##],0,0.1),200,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};");
DDWSnippets.put("ring1","Pbind(\\instrument,\\ring1,\\f,Pkey(\\freq),\\scale,d[\\scale],\\root,Pkr(~r),\\degree,0,\\octave,4,\\dur,##1##,\\d,0.6,\\a,1,\\pan,0,\\amp,0.5);");
DDWSnippets.put("ring1f","Pbind(\\instrument,\\ring1,\\f,Pkr(~r2),\\dur,##1##,\\d,0.6,\\a,1,\\pan,0,\\amp,0.5);");
DDWSnippets.put("sinfb","Pbind(\\instrument,\\sinfb,\\freq,Pseq([##1,2,3,4,5##],inf)*Pkr(~r2),\\dur,0.25,\\amp,0.3,\\fb,0.1,\\rel,0.3);");
DDWSnippets.put("sinfbscale","Pbind(\\instrument,\\sinfb,\\scale,d[\\scale],\\root,Pkr(~r),\\octave,4,\\degree,##0##,\\dur,0.25,\\amp,0.3,\\fb,0.1,\\rel,0.3);");
DDWSnippets.put("henon","Pbind(\\instrument,\\henon,\\freq,44100,\\dur,0.25,\\a,Pexprand(1.3,1.3),\\b,Pexprand(0.3,0.3),\\atk,0,\\sus,0,\\rel,Pexprand(##0.01,0.1##),\\amp,1);");

//effects
DDWSnippets.put("LPF","
//Low Pass
~lpfSend = {NumChannels.ar(Splay.ar([##Silent.ar(2)##]),2)};
~lpf = {RLPF.ar(~lpfSend,SinOsc.kr(0.1).range(440,440),0.1)};
~lpf.play;");
DDWSnippets.put("HPF","
//High Pass
~hpfSend = {NumChannels.ar(Splay.ar([##Silent.ar(2)##]),2)};
~hpf = {RHPF.ar(~lpfSend,SinOsc.kr(0.1).range(440,440),0.1)};
~lpf.play;");
DDWSnippets.put("Delay","
//delay
~delaySend = {NumChannels.ar(Mix.ar([##Silent.ar(2)##]),2)};
~delay = {CombN.ar(Splay.ar([~delaySend]),p.clock.tempo*4,p.clock.tempo/16,1)};
~delay.play;");





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

