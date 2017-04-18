//load setup
("../../Setup/Setup.scd").loadRelative

//Using SuperCollider as a Modular synth
//snippets help with building these sets a LOT, as standard elements such as modulation signals can be called upon very quickly
//NOTE: this will get !!! L O U D !!! - there's protection from StageLimiter of course, but be aware.

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
~room = {300};
~time = {3};
~verb = {GVerb.ar(~chaosEnv,~room,~time)}
~verb.play
//increase the room size
//TODO: finish this