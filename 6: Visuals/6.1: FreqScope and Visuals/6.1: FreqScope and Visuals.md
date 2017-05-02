# FreqScope and Visuals

-------

Note: This guide is in general terms because it is platform-specific. I'd recommend some research on how this can be realised on your particular platform

I really like having visuals as part of my sets, I think it adds a lot of energy to sets, regardless of how 'audio-responsive' they are. In addition to adding a bunch of colour to my projection, it gives some relief from just looking at code, and can serve as a low-budget light show in absence of actual lighting.

I have written my own programs to make visuals for sets before in [openFrameworks](http://openframeworks.cc/), which was a lot of effort. While this in itself was not an issue, I find it _extremely_ difficult to live code visuals and sound at the same time, as it involves a lot of parallel thinking, which disturbs my flow when live coding music. What I've found is that SuperCollider's [FreqScope](http://doc.sccode.org/Classes/FreqScope.html) is a great way of instantly adding visuals to sets with very little actual effort.

Inside ProxySpace, a `FreqScope` can be started to monitor all sound by evaluating `s.scope` (which is contained within this repo's `Setup.scd`. This will give an oscilloscope-type visualisation of the sound currently taking place, and can be shown as independent channels, an overlay, or an x/y chart of the sound on a stereo spectrum. My technique is to fullscreen the `FreqScope` window, and drop it behind my SuperCollider IDE window, and make the IDE window semi transparent with a black background (the black background is especially important as it will not tint the scope), showing the scope behind the code I am writing ([as can be seen here](https://www.youtube.com/watch?v=AdKeJXLoGOA)). This is an effort-free way to get some responsive visuals which work alongside my code which do not need attention themselves. I won't post any guides here on how to make your IDE transparent, as this depends entirely on your platform. I found it quite hard to do on Mac OSX, and quite easy on Linux (but a little harder in Ubuntu Unity than my current KDE). I usually do this in `Tracks` mode, although `Overlay` works too.

`X/Y` is where things get more interesting. This mode plots stereo sound on a two-dimensional plane by frequency and amplitude to form a geometric shape rather than a wave. The best example of how this works can be seen in [this Techmoan video](https://www.youtube.com/watch?v=ZaTuFB5QXHo) (or anything that can be found by googling Oscilloscope Music). `X/Y` mode can be a great way to create music that directly results in interesting visual forms by using complimentary frequencies across the stereo field. The specifics of this revolve around the harmonic series and different types of intonation [which is explained in this video](https://www.youtube.com/watch?v=6NlI4No3s0M). The shapes made can be changed by the type of waves used, as well as the volume and frequency, and performing according to this is an interesting way of shaking up one's performance strategies, as normal performance techniques will not yield interesting shapes, [here is X/Y used as visuals on a project entirely sounding entirely sine waves](https://www.youtube.com/watch?v=2L4pwUDjFCg) and here are a couple of more clear code examples:

```
//Example 1 - Static Frequencies
(
//two low sine waves at the same frequency showing a diagonal line
~sin1 = {SinOsc.ar([80,80],0,0.3)};
~sin1.play;
)
//two low sine waves at slightly different frequencies turning the line into a slowly turning disc
~sin1 = {SinOsc.ar([80,80.1],0,0.3)};
(
//two sine waves at double the frequency - notice the change in shape - turning the line a number of times on itself
~sin2 = {SinOsc.ar([80*2,80.01*2],0,0.3)};
~sin2.play;
)
(
//two sine waves at 10x the frequency - notice the change in shape - turning the line a whole bunch more times on itself
~sin3 = {SinOsc.ar([80*10,80.01*10],0,0.3)};
~sin3.play;
)
//stop everything
~sin1.stop;~sin2.stop;~sin3.stop;
(
//changing the frequency difference in the lower sine waves, changing how the original circle moves
~sin1 = {SinOsc.ar([80,80+LFNoise1.kr(0.1,4)],0,0.3)};
~sin1.play;
)
//replay the other sine waves and see how the entire shape moves faster
~sin2.play;~sin3.play;
//stop the highest sines
~sin3.stop;
(
//re-align the two low sine waves
~sin1 = {SinOsc.ar([80,80.01],0,0.3)};
~sin1.play;
)
(
//play a sine that doesn't align with the harmonic series, notice that the shape gets much less clear
~sin4 = {SinOsc.ar([94.234,99.1315],0,0.3)};
~sin4.play;
)
//stop the non-aligning sines
~sin4.stop;
//stop the second sine
~sin2.stop;
//play some quiet width-modulated pulse waves at 2x the frequency of the low sine waves
//notice that the shape changes according to the width of the pulse and that the 'notches' interact with each other across the stereo field
(
~pulse1 = {Pulse.ar([80*4,80.1*4],SinOsc.kr(0.05).abs,0.08)};
~pulse1.play;
)
//change the pulse to a saw wave at the same frequency
(
~pulse1.stop;
~saw1 = {Saw.ar([80*4,80.1*4],0.08)};
~saw1.play;
)
//note that the higher the volume, the greater the effect a sound has on the overall shape
~saw1 = {Saw.ar([80*4,80.1*4],0.08)};
//also the higher the frequency, the lesser the effect on the 'overall' shape and the greater the effect on the 'detail' of the shape
~saw1 = {Saw.ar([80*100,80.1*100],0.1)};
//stop everything
~sin1.stop;~saw1.stop;

//Example 2 - Moving frequencies and non-standard waveforms
//make a (really) low sine wave/spinning disc again
(
~sin1 = {SinOsc.ar([50,50.01],0,0.4)};
~sin1.play;
)
//make a stereo sine wave that sweeps the harmonic series
(
~sin2 = {SinOsc.ar(Saw.kr(0.1).range(10,1000).round(50),0,0.4)!2};
~sin2.play;
)
//make those two sine waves sweep the harmonic series at phasing (sightly different) rates
(
~sin2 = {SinOsc.ar(Saw.kr([0.1,0.11]).range(10,1000).round(50),0,0.4)};
~sin2.play;
)
//turn off the original sine wave
~sin1.stop
//speed the sweeping and make it a sine wave
~sin2 = {SinOsc.ar(SinOsc.kr([0.5,0.56]).range(10,1000).round(50),0,0.4)};
//make two meandering SinOscFB Ugens around the lower end of the harmonic series and see how they interact
(
~sinfb1 = {SinOscFB.ar([LFNoise1.kr(0.1).range(50,100).round(25),LFNoise1.kr(0.1).range(50,100).round(25)],SinOsc.kr(0.1).range(0.01,1),0.8)};
~sinfb1.play;
)
//stop the second sine waves
~sin2.stop
//make a big sub kick drum - notice the effect on the shape
(
~k = Pbind(\instrument,\bplay,\buf,d["sk"][0],\dur,4,\amp,1);
~k.play
)
//make a panned hi-hat
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,0.25,\amp,Pexprand(0.05,1),\pan,Pwhite(-1,1.0));
~h.play;
)
//make the feedback in the sinfb much more pronounced
~sinfb1 = {SinOscFB.ar([LFNoise1.kr(0.1).range(50,100).round(25),LFNoise1.kr(0.1).range(50,100).round(25)],SinOsc.kr(0.1).range(0.01,3),0.8)};
```
