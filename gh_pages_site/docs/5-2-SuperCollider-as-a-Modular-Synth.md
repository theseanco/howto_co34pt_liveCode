# SuperCollider as a Modular Synth

-------

A performance technique I don't generally employ a whole lot during Algorave-type sets using SuperCollider as a [modular synth](https://en.wikipedia.org/wiki/Modular_synthesizer) - and ProxySpace is _very_ strong in this regard too. Each NodeProxy can be seen as an individual module, and each module can be plugged into others to create a complex network of interconnected musical and control elements. This is achieved by setting up audio (.ar) and control (*.kr) proxies - for more info on audio vs control rate see [this](http://danielnouri.org/docs/SuperColliderHelp/Tutorials/Mark_Polishook_tutorial/Synthesis/4_Rates.html) and [this](http://danielnouri.org/docs/SuperColliderHelp/Tutorials/UGens-and-Synths.html)

I can't really talk about this in any great depth, so here is an in-depth example of how SuperCollider can be used as a live-codeable modular synth. An important thing to note though is that if you want a lot of freedom in this approach, a lot of familiarity with types of UGens available (as well as some of the stranger quirks of SuperCollider syntax) will be very helpful.


```supercollider
//load setup
("../../Setup/Setup.scd").loadRelative

//run this to smooth out transitions
p.fadeTime=5

//Using SuperCollider as a Modular synth
//snippets help with building these sets a LOT, as standard elements such as modulation signals can be called upon very quickly
//NOTE: this will get !!! L O U D !!! - there's protection from StageLimiter of course, but be aware.
//NOTE II: There may also be some DC bias. Be prepared for this. more information here - http://en.wikiaudio.org/DC_offset

//a sine wave
~sin = {SinOsc.ar([80,82],0,0.5)}
//a pulse wave
~pulse = {Pulse.ar([20,21],SinOsc.kr(0.1).range(0.01,1),0.5)}
//a new proxy multiplying sine and pulse waves
~sinpulse = {~sin.ar * ~pulse.ar}
~sinpulse.play
//feed this into a delay with its delay line modulated slightly
~delay = {CombC.ar(~sinpulse.ar,1,LFNoise1.kr(0.1).range(0.1,0.3),4)}
~delay.play
//increase the pulse speed and decrease the width, play it alongside the original
~pulse2 = {Pulse.ar([40,41],SinOsc.kr(0.1).range(0.001,0.1),0.5)}
~pulse2.play;
//actually no that would sound much better just in the delay, so ~pulse2 from playing and add it into ~delay by using Mix.ar
(
~pulse2.stop;
~delay = {CombC.ar(Mix.ar([~sinpulse.ar,~pulse2.ar]),1,LFNoise1.kr(0.1).range(0.1,0.3),4)};
)
//now we have some drones, some heavily gated and filtered noise would be good.
(
~noise = {RLPF.ar(WhiteNoise.ar(1),LFNoise1.kr(0.1).range(100,2000),SinOsc.kr(0.1).range(0.1,0.4),1)};
~noiseEnv = {EnvGen.ar(Env.perc(0.0001,0.1),Dust.kr(4))};
~totalNoise = {~noise.ar*~noiseEnv.ar};
~totalNoise.play;
)
//oh no. it is mono. i'm going to pan it over 2.
//In order to make a mono proxy stereo, I will have to .clear it and then evaluate a stereo version, as the number of channels is set at initialisation time.
//luckily with Pan2 I will only have to re-evaluate the ~totalNoise proxy
~totalNoise.clear;
(
~totalNoise = {Pan2.ar(~noise.ar*~noiseEnv.ar,SinOsc.kr(0.1))};
~totalNoise.play;
)
//the filtering on the noise isn't extreme enough, change it!
~noise = {RLPF.ar(WhiteNoise.ar(1),LFNoise1.kr(0.6).range(100,2000),SinOsc.kr(0.04).range(0.00001,0.2),1)};
//the noise could also do with some delay, which would sound nice if it was fed back through a pitch shifter:
//set up the delay, and play it
~noiseDelay = {CombC.ar(Mix.ar([~totalNoise.ar]),1,0.4,7,1)}
~noiseDelay.play;
//establish the pitch shifter
~pitchShift = {PitchShift.ar(~noiseDelay,0.2,TRand.kr(0.1,2,Dust.kr(0.5)))}
//play the pitch shifter, it will slow the delay speed by half
~pitchShift.play
//if we then put the results of ~pitchShift back into ~noiseDelay, then things get interesting.
//NB - this is bad practice and gets very loud before ending up in being DC bias, but i'm doing it here to prove a point.
//If you have super high end audio equipment or just don't want any DC bias then skip this step
~noiseDelay = {CombC.ar(Mix.ar([~totalNoise.ar,~pitchShift.ar]),1,0.4,7,1)}
//in order to avoid this getting totally out of control, reduce the volume of ~pitchShift inside of ~noiseDelay
~noiseDelay = {CombC.ar(Mix.ar([~totalNoise.ar,(~pitchShift.ar*0.11)]),1,0.4,7,1)}
//or modulate it to get varying amounts of feedback
~noiseDelay = {CombC.ar(Mix.ar([~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,0.4,7,1)}
//modulating the delay time too will make things get a bit wild
~noiseDelay = {CombC.ar(Mix.ar([~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1)}
//~noiseDelay seems to be glitching a bit and throwing DC bias - add a LeakDC around it
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))}
//let's cut the original pulse/sine waves over a few seconds
~delay.stop(20)
~sinpulse.stop(20)
//then put them inside of a DFM1 that can self-oscillate
//make sure you evaluate ~noiseDelayAdd twice before you .play it
~noiseDelayAdd = {DFM1.ar(Mix.ar([~delay.ar,~sinpulse.ar]),500,SinOsc.kr(0.1).range(0.5,2),1,0,0.03)}
//if you've evaluated the above line twice, play it
~noiseDelayAdd.play
//a lot of these sounds are quite degraded, some harsh sounds would be nice, let's have some chaos
//go to the help file for Henon2DC and copy-paste the second example but don't evaluate it (you'll need sc3-plugins for this)
/*
(
{ Henon2DN.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 }.play(s);
)
*/
//turn it into a node proxy and remove the .play(s) from the end
(
~henon = { Henon2DN.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 0.2 };
)
//make an envelope that has a long sweeping modulation on the amount of envelopes triggered
~chaosEnv = {EnvGen.ar(Env.perc(0,0.02),Dust.kr(SinOsc.kr(0.01).range(1,10)))}
//and combine in stereo
~chaos = {Pan2.ar(~henon*~chaosEnv)}
~chaos.play
//it is SUPER quiet, up the volume on ~henon
(
~henon = { Henon2DN.ar(
    2200, 8800,
    LFNoise2.kr(1, 0.2, 1.2),
    LFNoise2.kr(1, 0.15, 0.15)
) * 3.5 };
)
//add some reverb which will work in parallel
//if you want to change the parameters of any effect without re-evaluating it - set up that value as another NodeProxy
~room = {30};
~time = {3};
~verb = {GVerb.ar(~chaosEnv,~room,~time)}
~verb.play
//increase the reverb time
~time = {40};
//this needs some melody - add two melodies in stereo, slightly out of phase:
~saws = {LFSaw.ar([LFSaw.kr(0.1).range(100,1000).round(50),LFSaw.kr(0.11).range(100,1000).round(50)],0,0.3)}
~saws.play
//too harsh, needs filtering
~saws = {RLPFD.ar(LFSaw.ar([LFSaw.kr(0.1).range(100,1000).round(50),LFSaw.kr(0.101).range(100,1000).round(50)],0,0.8),1000,0.8,0.6,10)};
//another delay would be nice
~sawDelay = {CombC.ar(~saws.ar,1,0.5,10)};
~sawDelay.play;
//some heavy decimation on the delay
~sawDelay = {Decimator.ar(CombC.ar(~saws.ar,1,0.5,10),2200,10)};
//further bit reduction
~sawDelay = {Decimator.ar(CombC.ar(~saws.ar,1,0.5,10),2200,5)};
//even further
~sawDelay = {Decimator.ar(CombC.ar(~saws.ar,1,0.5,10),2020,3)};
//plugging the ~sawDelay into the original for more noise
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))}
//plugging ChaosEnv into ~noiseDelay too
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~chaosEnv.ar,~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))};
//then plugging it also into a more intense ~noiseDelayAdd for more mad effects
~noiseDelayAdd = {DFM1.ar(Mix.ar([~delay.ar,~sinpulse.ar,~noiseDelay]),LFNoise1.kr(100).range(100,10000),SinOsc.kr(0.1).range(0.5,100),1,0,0.03)}
~noiseDelayAdd.play
//it doesn't appear to be playing, probablt because ~noiseDelay is SO loud. Multiply it by half
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~chaosEnv.ar,~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs)]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1)) * 0.3};
//then plug ~noiseDelayAdd into ~noiseDelay and roll off the multiplication for maximum damage
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~chaosEnv.ar,~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs),~noiseDelayAdd.ar]),1,LFNoise1.kr(0.1).range(0.01,0.6),7,1))};
//increase the ridiculousness of the modulation of the delaytime
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~chaosEnv.ar,~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs),~noiseDelayAdd.ar]),1,LFNoise1.kr(1).range(0.001,4),7,1))};
//put another delay on top of that?
~delay2 = {CombC.ar(~noiseDelay.ar,1,0.4,30)}
~delay2.play
//then plug that back into ~noiseDelay (which by now contains most things that are playing.
~noiseDelay = {LeakDC.ar(CombC.ar(Mix.ar([~chaosEnv.ar,~sawDelay.ar,~totalNoise.ar,(~pitchShift.ar*LFNoise1.kr(0.01,0.2).abs),~noiseDelayAdd.ar,~delay2.ar]),1,LFNoise1.kr(1).range(0.001,4),7,1))};
//also modulate ~delay2, really slowly
~delay2 = {LeakDC.ar(CombC.ar(~noiseDelay.ar,1,SinOsc.kr(0.01).range(0.0001,0.2),80))}
//things broke up for me here and I have no idea why, there's multiple things feeding back through each other here.
//and you have noise music!
```


