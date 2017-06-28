# Drones

-------

[Drones](https://www.youtube.com/watch?v=H3EjxgPBm0Q) [are](https://youtu.be/COz1DFfBgcc?t=9m44s) [great](https://youtu.be/V3c84gRX4aY?t=1h11m2s), both standing on their own as drone music or within other forms of music.

I've always found SuperCollider to be a really strong tool for making drones of all kinds as the types of subtle, durational modulations that can be achieved with `.kr` UGens allows for the creation of drones that vary over time very easily. The variation of these drones makes the background of sets interesting without having to maintain them directly - especially if the modulation in multiple drones are out of sync for instance. This sustained background interest can keep a set moving forward while time is spent working on preparing foreground elements without the background becoming boring too quickly (which is a problem I've come across a lot when performing live coding sets).

### DFM1

[sc3-plugins](https://github.com/supercollider/sc3-plugins) contains a great filter - [DFM1](http://doc.sccode.org/Classes/DFM1.html). A 'Digitally Modelled Analog Filter', it is packed with features. It can be used a high pass and low pass, has a variable noise setting, and can self-oscillate at high resonances.

The most important feature of this for me is the self-oscillation. When overdriven, DFM1 produces a gorgeous 'warm' tone, which tends to distort softly the harder it is driven.

When this self-oscillating distortion is paired with a sine wave using the same fundamental frequency as the filter, some rich drones are created:

```supercollider
/*
A standard DFM1 drone I use an awful lot.
The filter self-oscillates at a 'res' value of >1, so here I have used a SinOsc moving from 0.9-1.1, so the self-oscillated distortion fades in and out.
Here I am using the harmonic series to organise pitch. with the frequency of the filter being double that of the SinOsc.
!!!!NOTE!!!!! - In my installation of SuperCollider, DFM1 is buggy and NodeProxies it contains need to be evaluated twice slowly otherwise they will cut all sound from the server when played. I don't know why this is (or whether it is a version/platform/OS specific issue), but if the experience is any different for you please raise an issue on GitHub or otherwise let me know. This only happens once per NodeProxy, once it is initialised and playing it can be re-evaluated and changed with no effect on the sound in the rest of the server
*/
//set the fundamental frequency
~r = {80}
//evaluate this twice with a couple of seconds of gap in between
//the stereo sine wave creates a 'beating' in stereo. For more information see https://en.wikipedia.org/wiki/Beat_(acoustics)
~dfm1 = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),~r*2,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};
//play
~dfm1.play;
//changing the resonance changes the character of the self-oscillation, detuning it and distorting it
~dfm1 = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),~r*2,SinOsc.kr(0.05).range(0.9,1.6),1,0,0.0003,0.5)};
//The higher the resonance value gets, the more distortion
~dfm1 = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),~r*2,SinOsc.kr(0.05).range(0.9,5.6),1,0,0.0003,0.5)};
//extreme resonance values get LOUD, but don't really change sonically past around the 10 mark
~dfm1 = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),~r*2,SinOsc.kr(1).range(10,400),1,0,0.0003,0.5)};

//DFM1 multiple drones
//Using the harmonic series technique, a number of drones at various multiplications layered together
//Note - the modulation of the resonance is a slightly different speed for each, to create an overall variation and non-repetition in sound
//set fundamental frequency
~r = {54};
(
//evaluate this twice with a couple of seconds of gap in between
//the argument 'mult' is used for speed - to copy and paste the entire NodeProxy and set multiplications quickly during performance
~dfm1 = {arg mult = 1; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};
~dfm2 = {arg mult = 2; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,SinOsc.kr(0.06).range(0.9,1.1),1,0,0.0003,0.5)};
~dfm3 = {arg mult = 3; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,SinOsc.kr(0.056).range(0.9,1.1),1,0,0.0003,0.5)};
~dfm4 = {arg mult = 4; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,SinOsc.kr(0.07).range(0.9,1.1),1,0,0.0003,0.5)};
)
//now play all
~dfm1.play;~dfm2.play;~dfm3.play;~dfm4.play;
//changing modulation from a SinOsc to an LFNoise, increasing modulation scope in lower multiples
(
//evaluate this twice with a couple of seconds of gap in between
//the argument 'mult' is used for speed - to copy and paste the entire NodeProxy and set multiplications quickly during performance
//this sounds like distorted guitars and is VERY rich.
~dfm1 = {arg mult = 1; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,LFNoise1.kr(0.05).range(0.9,4.5),1,0,0.0003,0.5)};
~dfm2 = {arg mult = 2; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,LFNoise1.kr(0.06).range(0.9,2.3),1,0,0.0003,0.5)};
~dfm3 = {arg mult = 3; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,LFNoise1.kr(0.056).range(0.9,1.9),1,0,0.0003,0.5)};
~dfm4 = {arg mult = 4; DFM1.ar(SinOsc.ar([~r,~r*1.01]*mult,0,0.1),(~r*2)*mult,LFNoise1.kr(0.07).range(0.9,1.5),1,0,0.0003,0.5)};
)
```

Another way to use DFM1 as an oscillator is to run it up and down the harmonic series and use it as a 'melody' alongside some already running drones, and smooth it out by using the `noiselevel` argument:

```supercollider
//using DFM1 as a melody
//set harmonic frequency
~r = {60};
//start the first drone from the first example in this document
//evate this twice with a couple of seconds in between
~dfm1 = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),~r*2,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};
//play
~dfm1.play
//another drone, but one that contains a LFNoise1 used to give sweeps around the harmonic series
//evaluate this twice with a couple of seconds in between
~dfmharm = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),LFNoise1.kr(0.1).range(100,1000).round(~r),SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)};
//play
~dfmharm.play;
//up the resonance
~dfmharm = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),LFNoise1.kr(0.1).range(100,1000).round(~r),SinOsc.kr(0.05).range(0.9,1.4),1,0,0.0003,0.5)};
//up the speed of pitch change
~dfmharm = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),LFNoise1.kr(1.4).range(100,1000).round(~r),SinOsc.kr(0.05).range(0.9,1.4),1,0,0.0003,0.5)};
//up the noise
~dfmharm = {DFM1.ar(SinOsc.ar([~r,~r*1.01],0,0.1),LFNoise1.kr(1.4).range(100,1000).round(~r),SinOsc.kr(0.05).range(0.9,1.4),1,0,0.1,0.5)};
```
