//Boilerplate code for basic live coding functionality
//Run this with Ctrl/Cmd + Enter
(
//increase number of buffers the server has access to for loading samples
s.options.numBuffers = 1024 * 16;
//increase the memory available to the server
s.options.memSize = 8192 * 64;
//boot the server
s.boot;
//display the oscilloscope
s.scope;
//start proxyspace
p=ProxySpace.push(s);
//start tempo clock
p.makeTempoClock;
//give proxyspace a tempo
p.clock.tempo = 2;
Task({
	3.wait;
	d = Dictionary.new;
	d.add(\foldernames -> PathName(thisProcess.nowExecutingPath.dirname +/+ "../../samples/set1").entries);
	for (0, d[\foldernames].size-1,
		{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
			arg sf;
			Buffer.read(s,sf.fullPath);
		});
	)});
	("SynthDefs.scd").loadRelative;
	//loads snippets from setup folder
	//("Snippets.scd").loadRelative;
	//wait, because otherwise it won't work for some reason
	3.wait;
	//activate StageLimiter - Part of the BatLib quark
	//StageLimiter.activate;
	"Setup done!".postln;
}).start;
)


//WINDOWS USERS!
//RUN THIS AFTERWARDS (Ctrl + Enter)
(
d = Dictionary.new;
d.add(\foldernames -> PathName(thisProcess.nowExecutingPath.dirname +/+ "../../samples/set1").entries);
for (0, d[\foldernames].size-1,
	{arg i; d.add(d[\foldernames][i].folderName -> d[\foldernames][i].entries.collect({
		arg sf;
		Buffer.read(s,sf.fullPath);
	});
)});
)
