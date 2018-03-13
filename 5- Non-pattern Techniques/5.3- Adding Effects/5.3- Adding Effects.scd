//load setup file
("../../Setup/Setup.scd").loadRelative


/*

Effects Chain Examples

*/

//Basic effects chain example
//basic kick, example from earlier on in the repo
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
//add a [0] to the name of the proxy
~k[0] = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
//add some reverb
~k[1] = \filterIn -> {|in| FreeVerb.ar(in)}
//re-evaluate 'index 0' of the NodeProxy, and effect will be kept
~k[0] = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pseq([0.25,0.5,0.75],inf),\rate,Pseq([1,1.2,1.3,1.4],inf),\amp,1);
//note that indexes can be re-evaluated on the fly, e.g. to change the values of an effect UGen or to add modulation
~k[1] = \filterIn -> {|in| FreeVerb.ar(in,0.6,0.6,0.01)}

//Example using wet/dry effects
//slightly more complex starting kick
~k[0] = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pwhite(0.5,1.5).round(0.25),\amp,1,\rate,10);
~k.play;
//create a more complex effects, in this case a bitcrushed modulated delay. Note the original kick disappears
~k[1] = \filterIn -> {|in| Decimator.ar(CombC.ar(in,0.6,0.1+SinOsc.kr(0.1,0,0.05),LFNoise1.kr(0.1).range(0.1,3)),1000)}
//mix in a lot of dry signal so that the original kick is still heard above the effects
//the format is \wetNUMBER, where NUMBER is the index specified for the \filterIn containing the effect
~k.set(\wet1,0.3)

/*

Something that was pointed out to me by @cappelnord:

'Use BASIC style line numbering for the NodeProxy slots, so [0], [10], [20], [30] ... you'll never know when you want to put something inbetween two effects in the heat of the night'


*/

//Using this BASIC-style numbering allows for a gap where other effects can be inserted after chains have been constructed
(
~one[0] = Pbind(\instrument,\ring1,\f,Pkey(\freq),\scale,Scale.chromatic(\et53),\degree,Pwhite(-10,10),\octave,3,\dur,Pbjorklund2(3,8)/4,\d,0.6,\a,Pwhite(1,10),\pan,0,\amp,0.5);
~one.play;
)
//add light ring modulation at index 10
(
~one[10] = \filterIn -> {|in| in*SinOsc.ar(500,0,1)};
~one.set(\wet10,0.1);
)
//add delay at index 20 with some dry signal added
(
~one[20] = \filterIn -> {|in| CombC.ar(in,2,p.clock.tempo/4,2)};
~one.set(\wet20,0.2);
)
/*
currently
~one[0] -> ring mod[10] -> Delay[20] -> out
*/
//add a modulated filter before ring mod
(
~one[5] = \filterIn -> {|in| RHPF.ar(in,LFTri.kr(0.1).exprange(10,500),0.4)};
)
//add wavefolding before the delay
(
~one[15] = \filterIn -> {|in| LeakDC.ar(in.fold(0.1,0.4))};
~one.set(\wet15,0.9)
)
/*
now:
~one[0] -> filter[5] -> ring mod[10] -> wavefolding[15] -> delay[20] -> out
*/

//an example using other proxies to modulate a proxy in a chain. You can insert other proxies in an effects chain to cross-modulate
//a nice Streson.ar drone
(
~stres[0] = { Streson.ar(LFSaw.ar([220, 180], 0, mul:EnvGen.kr(Env.asr(0.5, 1, 0.02), 1.0) * 0.2), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 377).reciprocal, 0.9, 0.7) };
~stres.play;
)
//a kick drum
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)
//use the amplitude of ~k to modulate the amplitude of ~stres
~stres[10] = \filterIn -> {|in| in*(Amplitude.kr(~h.ar,0.01,0.1,7))}
//stop the kick
~k.stop
//create a harmonic series sinfb riff
(
~sinfb = Pbind(\instrument,\sinfb,\freq,Pseq([1,2,3,4,5],inf)*90,\dur,0.25,\amp,0.1,\fb,0.1,\rel,0.3);
~sinfb.play;
)
//modulate ~stres with it
//Frequency being modulated by ~sinfb, amplitude being modulated by ~k
~stres[20] = \filterIn -> {|in| (in*~sinfb)*10}
//stop the sinfb
~sinfb.stop
//add a delay to top it all off, why not
(
~stres[30] = \filterIn -> {|in| CombC.ar(in,0.6,p.clock.tempo/14,1)};
~stres.set(\wet30,0.3)
)


//TODO: Performance practices with these, be careful not to put anything without an index after it as it may end up wiping out the effects later on.

/*

Effects NodeProxy/'bus' example

*/
//a complete drum groove of sorts
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pwrand([1,0.5,0.25,Pseq([0.125],2),Pseq([0.125/2],4)],[0.5,2,14,3,2].normalizeSum,inf),\amp,Pexprand(0.05,1),\rate,Pexprand(0.9,1.1),\pan,Pwhite(-0.5,0.5));
~k = Pbind(\instrument,\bplay,\buf,d["k"][1],\dur,Pseq([0.5,1,2],inf),\amp,1);
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,4.375,\amp,1);
~sn = Pbind(\instrument,\bplay,\buf,d["s"][1],\dur,Pbjorklund2(3,8)/4,\amp,1);
~h.play;~k.play;~c.play;~sn.play;
)
//creating invididual reverbs for all four drums is time consuming and CPU-intensive
//two ways to combine them
//quicker, and more risky, wrap it all straight in a Ugen
(
~verb = {FreeVerb.ar(~h+~k+~c+~sn,1,0.6,0.5,0.3)};
~verb.play;
)
//more seamless, but takes longer, make a bus of all the NodeProxies you want to effect
~verbBus = {~h+~k+~c+~sn}
//add it to the verb
~verb = {FreeVerb.ar(~verbBus,1,0.6,0.5,0.3)};
//sounds the same, but adding NodeProxies to ~verbBus is easier and FreeVerb won't have to restart:
(
~sin = Pbind(\instrument,\sinfb,\octave,[4,3],\degree,Pseq([0,4,7,0,4],inf).stutter(10),\dur,0.25,\amp,0.7,\fb,Pseq([Pseries(0,0.05,40)],inf),\rel,0.1,\detune,[0,-20]);
~sin.play;
)
//add ~sin to ~verbBus for instant results
~verbBus = {~sin+~h+~k+~c+~sn}
//you can also then put chains on buses, of course.
~verbBus[0] = {~sin+~h+~k+~c+~sn}
~verbBus[10] = \filterIn -> {|in| Decimator.ar(in,10000,8)}

//effects

/*

for writing:

Ring Modulation
Delay
Reverb
Chorus
Wavefolding
Distortion & Crossover Distortion
Bitcrushing
Filters
Tremolo
Compression
Noise

*/
