//load setup file
("../../Setup/Setup.scd").loadRelative

//a complex polyrhythm
(
p.clock.tempo = 2.3;
~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.75,\amp,1);
~c2 = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,Pbjorklund2(Pseq([3,3,3,5],inf),8)/4,\amp,1);
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1,\stretch,Pwhite(1,0.25).round(0.25));
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,Pbjorklund2(Pwhite(3,10),16),\amp,1);
~t1 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,1/5*4,\amp,1);
~t2 = Pbind(\instrument,\bplay,\buf,d["t"][0],\dur,1/9*4.5,\amp,1,\rate,2);
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,Pbjorklund2(Pwhite(10,16),16)/8,\amp,Pwhite(0.2,1.4));
~fx1 = Pbind(\instrument,\bplay,\buf,d["sfx"][0],\dur,Pwhite(1,4.0).round(0.5),\amp,1);
~fx2 = Pbind(\instrument,\bplay,\buf,d["sfx"][1],\dur,Pwhite(1,8.0).round(0.25),\amp,1);
~c.play;~c2.play;~oh.play;~sn.play;~t1.play;~t2.play;~h.play;~fx1.play;~fx2.play;
)
//A 0db kick which doesn't really do anything in the mix
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,1);
~k.play;
)
//A >0dB kick which compresses everything else and audibly 'centers' everything around it because it is so loud.
//There's probably some psychoacoustics involved in this that i'm not qualified to talk about.
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,1,\amp,4);
~k.play;
)
//a really *really* loud, very occasional percussion which silences everything else (slowed down for exaggerated effect)
(
~hugesnare = Pbind(\instrument,\bplay,\buf,d["mt"][0],\dur,Pwhite(8,16),\amp,4000000,\rate,1);
~hugesnare.play;
)


//some beautiful pads
//thanks Eli Fieldsteel
(
p.clock.tempo = 2;
(
~chords = Pbind(\instrument,\bpfsaw,
	\dur,Pwhite(4.5,7.0,inf),
	\midinote,Pxrand([
		[23,35,54,63,64],
		[45,52,54,59,61,64],
		[28,40,47,56,59,63],
		[42,52,57,61,63],
	],inf),
	\detune, Pexprand(0.0001,0.1,inf),
	\cfmin,100,
	\cfmax,1500,
	\rqmin,Pexprand(0.02,0.15,inf),
	\atk,Pwhite(2.0,4.5,inf),
	\rel,Pwhite(6.5,10.0,inf),
	\ldb,6,
	\amp,Pwhite(0.8,2.0),
	\out,0)
);
~chords.play;
)
//pulse them slightly with a low-passed kick
(
~k = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,Pbjorklund2(3,8)/2,\amp,2);
//Low Pass
~lpfSend = {[~k]};
~lpf = {RLPF.ar(Mix.ar([~lpfSend]),SinOsc.kr(0.1).range(200,100),1)};
~lpf.play;
)
//eliminate them completely with an absurdly loud low-passed kick (those with subwoofers be careful!)
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,9000,\rate,5);
//Low Pass
~lpfSend = {[~k]};
~lpf = {RLPF.ar(Mix.ar([~lpfSend]),SinOsc.kr(0.1).range(100,80),0.3)};
~lpf.play;
)

