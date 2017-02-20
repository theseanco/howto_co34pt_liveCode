
//generic drum patterns
DDWSnippets.put("kick", "~k = Pbind(\\instrument,\\bplay,\\buf,d[\"k\"][0],\\dur,##1##,\\amp,1)");
DDWSnippets.put("hat","~h = Pbind(\\instrument,\\bplaym,\\buf,d[\"ch\"][0],\\dur,##0.25##,\\amp,Pwhite(0.2,1))");
DDWSnippets.put("snare","~sn = Pbind(\\instrument,\\bplay,\\buf,d[\"s\"][0],\\dur,##2##,\\amp,1)");
DDWSnippets.put("clap","~c = Pbind(\\instrument,\\bplay,\\buf,d[\"c\"][0],\\dur,##0.75##,\\amp,1)");


//Specific pattern generators
DDWSnippets.put("Prand","Prand([##1,0##],inf)");
DDWSnippets.put("Pwrand","Pwrand([##1,0##],[10,1].normalizeSum,inf)");
DDWSnippets.put("e8", "Pbjorklund2(##3##,8)/4");
DDWSnippets.put("e16","Pbjorklund2(##3##,16)/4");
DDWSnippets.put("offbeat","Pseq([0.5,Pseq([1],inf)],inf)");
DDWSnippets.put("Pexprand","Pexprand(##0.001,1##)");
DDWSnippets.put("Pseq","Pseq([##1,2,3,4,5##],inf)");

//Scales
DDWSnippets.put("scale","Scale.chromatic(\\et53)");
DDWSnippets.put("root","~root = {0}");

//Modulation snippets
DDWSnippets.put("EnvPerc","EnvGen.ar(Env.perc(##0.01,1##),Impulse.kr(p.clock.tempo),1,0,1,0)");
DDWSnippets.put("LFN1","LFNoise1.kr(0.1).range(##100,3000##).round(100)");
DDWSnippets.put("SinOsc","SinOsc.kr(0.1).range(##0.01,1.01##)");

//instrument generators
DDWSnippets.put("DFMDrone","{DFM1.ar(SinOsc.ar([##100,101##],0,0.1),200,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)}");
DDWSnippets.put("ring1","Pbind(\\instrument,\\ring1,\\f,Pkey(\\freq),\\scale,s,\\root,Pkr(~r),\\degree,0,\\octave,4,\\dur,1,\\d,0.6,\\a,1,\\pan,0,\\amp,0.5)");
DDWSnippets.put("sinfb","Pbind(\\instrument,\\sinfb,\\freq,##100##,\\dur,0.25,\\amp,0.3,\\fb,0.1)");

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

