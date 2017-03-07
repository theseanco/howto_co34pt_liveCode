/*

TODO: Document this

*/


(
//enveloped buffer player

SynthDef(\vplaym,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, atk=0.01, rel=1, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0.0,1));
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

SynthDef(\vplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, atk=0.01, rel=1, rel2= 0, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,rel2,1));
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

//wavetable synth using buffers

SynthDef(\wtabl,
	{arg out = 0, buf = 0, freq = 300, amp = 0.5, pan = 0, atk=0.01, rel=1, pos=0;
		var sig, env;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) *freq,1,0,1),pan);
		env = EnvGen.ar(Env.perc(atk,rel),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;


//basic buffer player
//TODO: Look at this, equal power panning etc.
SynthDef(\bplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Mix.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2));
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,Pan2.ar(sig,pan));
}).add;

SynthDef(\bplaym,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
		var sig,env ;
		sig = Pan2.ar(PlayBuf.ar(1,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

SynthDef(\bplaymr,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=3;
		var sig,env ;
		sig = Pan2.ar(PlayBuf.ar(1,buf,rate.neg,1,BufDur.kr(buf)*44100-2,doneAction:2),pan);
		env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
		sig = sig * env;
		sig = sig * amp;
		Out.ar(out,sig);
}).add;

//eli fieldsteel's instrument

(
SynthDef(\bpfsaw, {
	arg atk=2, sus=0, rel=3, ts=1, c1=1, c2=(-1), freq=500, detune=0.2, pan=0, cfhzmin=0.1, cfhzmax=0.3, cfmin=500, cfmax=2000, rqmin=0.1, rqmax=0.2, lsf=200, ldb=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),timeScale:ts,doneAction:2);
	sig = Saw.ar(freq*{LFNoise1.kr(0.5,detune).midiratio}!2);
	sig = BPF.ar(
		sig,
		{LFNoise1.kr(
			LFNoise1.kr(4).exprange(cfhzmin,cfhzmax)
		).exprange(cfmin,cfmax)}!2,
		{LFNoise1.kr(0.1).exprange(rqmin,rqmax)}!2
	);
	sig = BLowShelf.ar(sig,lsf,0.5,ldb);
	sig = Balance2.ar(sig[0],sig[1],pan);
	sig = sig*env*amp;
	Out.ar(out,sig);
}).add;
);

//Henon Chaos Generator - UNFINISHED

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

(
SynthDef(\henonc,
	{arg freq=440,mfreq=440,a=1.3,b=0.3,x0=0.30501993062401,y0=0.20938865431933,atk=0.01,sus=1,rel=1,timescale=1,out=0,pan=0,amp=0.3;
		var sig,env;
		sig = Henon2DC.ar(freq,freq+mfreq,a,b,x0,y0,amp);
		sig = LeakDC.ar(sig);
		Out.ar(out,Pan2.ar(sig,pan));
}).add;
);

//Warp1 constant synth

(
SynthDef(\warp1,
	{arg buf=0, channels=2, pos=0, rate=1, size=0.2, env= -1, olap=8, rand=0, interp=4, poslag=0, ratelag=0, out=0, sizelag=0, pan=0, amp=0.5;
		var sig;
		sig = Warp1.ar(2,buf,Lag.kr(pos,poslag),Lag.kr(rate,ratelag),Lag.kr(size,sizelag),env,olap,rand,interp,1);
		Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);

//GrainBuf synth

(
SynthDef(\grains,
	{arg buf=0, channels=2, dust=2, imp=2, dur=0.2, rate=1, pos=0.5, interp=4, pan=0, dustlag=0, implag=0, out=0, amp=0.5, ratelag=0, maxgrains=512, env= -1;
		var sig;
		sig = GrainBuf.ar(2,Dust.kr(Lag.kr(dust,dustlag))+Impulse.kr(Lag.kr(imp,implag)),dur,buf,Lag.kr(rate,ratelag),pos,interp,pan,env,maxgrains,amp);
		Out.ar(out,sig);
}).add;

);


//Eli Fieldsteel's bpfbuf

(
SynthDef(\bpfbuf, {
	arg atk=0, sus=0, rel=3, c1=1, c2=(-1),
	buf=0, rate=1, spos=0, freq=440, rq = 1,
	bpfmix=0, pan=0, amp=1, out=0;
	var sig, env;
	env = EnvGen.kr(Env([0,1,1,0],[atk,sus,rel],[c1,0,c2]),doneAction:2);
	sig = PlayBuf.ar(1, buf, rate*BufRateScale.ir(buf), startPos:spos);
	sig = XFade2.ar(sig, BPF.ar(sig, freq, rq, 1/rq.sqrt), bpfmix*2-1);
	sig = sig * env;
	sig = Pan2.ar(sig,pan,amp);
	Out.ar(out,sig);
}).add;
);

//SinFB Bass
(
SynthDef(\sinfb, {
	arg freq = 440, atk = 0.01, sus = 0, rel = 1, fb = 0, amp = 0.3, out = 0, pan=0;
	var sig, env;
	env = EnvGen.ar(Env.linen(atk,sus,rel),1,1,0,1,2);
	sig = SinOscFB.ar(freq,fb,1);
	sig = sig*env;
	Out.ar(out,Pan2.ar(sig,pan,amp));
}).add;
);

SynthDef(\ring1,
	{
		arg f = 45, a = 9, d = 0.6, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

SynthDef(\ring2,
	{
		arg f = 9000, a = 2, d = 0.1, amp = 1, pan = 2, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

SynthDef(\ring3,
	{
		arg f = 50, a = 3, d = 1, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;

SynthDef(\ring4,
	{
		arg f = 8000, a = 1, d = 0.3, pan = 0, amp = 1, out = 0;
		var sig, env;
		env = Line.kr(0,1,d);
		env = FreeSelfWhenDone.kr(env);
		sig = Impulse.ar(0);
		sig = Ringz.ar(sig,f,d,a);
		Out.ar(out,Pan2.ar(sig.tanh,pan) * amp)
	};
).add;
)
