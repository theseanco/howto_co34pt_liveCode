# Why Live Code in SuperCollider?

-----------------------------

_'You're brave to use SuperCollider!'_ - Anonymous, after a performance of mine, also probably slightly misremembered

Looking at lvm's [awesome-livecoding](https://github.com/lvm/awesome-livecoding) list, there are currently a whole bunch of live coding languages and platforms built around a whole bunch of paradigms, suited to many different users with varying aims, mediums, skillsets and abilities.

SuperCollider sits on the back-end of a few live coding-specific languages, including [FoxDot](https://github.com/Qirky/FoxDot), [TidalCycles](https://tidalcycles.org/) (with [SuperDirt](https://github.com/musikinformatik/SuperDirt)), [Overtone](https://overtone.github.io/), [ixi lang](http://www.ixi-audio.net/ixilang/) and probably some I've forgotten, but within SuperCollider there is ample support for live coding in the form of various libraries and techniques (I use [JITLib](http://doc.sccode.org/Overviews/JITLib.html)), and I've been using it since 2014 for [performances](https://youtu.be/DarZp69PoHE?t=2h38m55s), [composition](https://jamesjoys.bandcamp.com/track/the-face-you-dont-recognise-co34pt-remix) and for building [other projects](https://www.youtube.com/watch?v=dY6oSwoRRho).

I've tried (and performed with) a bunch of other live coding platforms (mostly [TidalCycles](https://www.youtube.com/watch?v=-S_Nge1sJFI) and [FoxDot](https://www.youtube.com/watch?v=RxITa2M9ah0)), and have repeatedly settled on SuperCollider over and over for live coding. As someone mostly performing metre-driven beat-based dance music, this can seem like an odd choice. Tidalcycles, for example, is specifically built around rhythmic cycles, and is a fast, efficient way to create complex rhythmic units. 

SuperCollider on the other hand has no one central method to produce rhythmic patterns or loops - instead there are a number of different ways to leverage [pattern classes](http://doc.sccode.org/Tutorials/A-Practical-Guide/PG_01_Introduction.html), some of which are really quite unwieldy and not at all suited to live coding and rely on a lot of pretty complicated nesting. SuperCollider is also _really_ verbose - when creating patterns basic arguments need to be manually specified, which requires a lot of typing. In addition to this, SuperCollider has no real 'built-in' mechanisms for live performance - these often have to be built by the user and imported as libraries. This repo contains a number of [SynthDefs](http://doc.sccode.org/Classes/SynthDef.html), or 'instruments' that I have had to build myself or copy from elsewhere in order to perform basic functions within patterns - want to play a kickdrum sample? Better build a way to do that yourself! Want a square wave you can trigger as part of a pattern? Better go write that synth! 

It's also full of strange [undocumented methods and classes](https://github.com/supercollider/supercollider/wiki/Undocumented-classes-and-methods-list), which can hold keys to performance techniques that I'll never find because I don't know what they are - I had to catch someone using the method `.stutter` during a live set to figure out its potential uses for me. People who live code in SuperCollider also often do it very differently from each other, using different, sometimes not transferable sets of techniques - this is a result of SuperCollider being a comparatively enormous language, but as a result I had quite a bit of difficulty learning how to use it, especially for a musician who hadn't been coding very long (myself, when I first learned SuperCollider). *a mess*

SuperCollider can also be pretty unforgiving. With no built-in limiter, one incorrect argument can be absolutely devastating - The main perceptual difference between `SinOsc.ar(400,0,1)` and `SinOsc.ar(400,0,10)`, is pain. Especially when you're wearing headphones. It's also pretty easy to bring the whole server to a halt with a mis-typed `\dur` argument.

The results of this? 

From absolutely nothing,

```
d1 $ sound "bd sn"
```

in Tidalcycles produces a kick-snare pattern, which can very easily be extended to 

```
d1 $ sound "bd sn cp"
```

to produce a kick-snare-clap pattern. 

In SuperCollider however, producing a kick-snare pattern can take a number of forms, but this is how I would end up doing it from boot-up (without any of the setup code in this repo).

```
a = Buffer.read(s,"/path/to/kick/kick.wav");
b = Buffer.read(s,"/path/to/snare/snare.wav");
SynthDef(\bplay,
	{arg out = 0, buf = 0, rate = 1, amp = 0.5, pan = 0, pos = 0, rel=15;
	var sig,env ;
	sig = Pan2.ar(PlayBuf.ar(2,buf,BufRateScale.ir(buf) * rate,1,BufDur.kr(buf)*pos*44100,doneAction:2),pan);
	env = EnvGen.ar(Env.linen(0.0,rel,0),doneAction:2);
	sig = sig * env;
	sig = sig * amp;
	Out.ar(out,sig);
	}).add;
p = ProxySpace.push(s);
p.makeTempoClock;
~k = Pbind(\instrument,\bplay,\buf,a,\dur,0.5,\amp,1);
~s = Pbind(\instrument,\bplay,\buf,b,\dur,1,\amp,1);
~k.play;
~s.play;
```

And in order to do the kick-snare-clap pattern I would have to add

```
c = Buffer.read(s,"/path/to/clap/clap.wav");
~k = Pbind(\instrument,\bplay,\buf,a,\dur,1/3,\amp,1);
~s = Pbind(\instrument,\bplay,\buf,b,\dur,1/3,\amp,1);
~c = Pbind(\instrument,\bplay,\buf,c,\dur,1/3,\amp,1);
~c.play;
```

So **why** would I choose to use a system like this, when there are some that are much more efficient for the kinds of things I am doing? (I am being a _little_ obtuse in the code example above for the sake of argument)

The answer is primarily, of course, *because it works for me*, but here's why.

SuperCollider is a huge language, containing not only a really great set of pattern libraries and live coding functionality, but some of the best synthesis capabilities of any program I have ever used, and with extensions, the possible functionality I can draw upon is absolutely enormous. In this repo I'll be talking about how I use [Euclidean Rhythms](https://github.com/supercollider-quarks/Bjorklund), [Nonlinear Maps](http://doc.sccode.org/Classes/ChaosGen.html), [Common fundamental frequencies](https://github.com/cappelnord/BenoitLib/blob/efca4d59cd570deb2e2f3edd3b526ab33b45b411/patterns/Pkr.sc) [53 tone scales](http://doc.sccode.org/Classes/Scale.html), and many other techniques to make parts of music. SuperCollider's amazing array of native and extended functionality is not immediately usable for live coding from the time of installation, but with some reusable scaffolding in place  these features can be relatively easily leveraged. The issue of the verbosity of SuperCollider compared to Tidalcycles can be mitigated with setup code and extensions - it's taken me a while to build and work with structures to make using SuperCollider as a performer more effective, but once the framework is in place things get much easier, and can be tuned to suit any particular performance needs.

The lack of pre-built foundations is also liberating in some respects because if I want to get down to a 'lower level' during a performance it's trivial to do so. If I am hitting a wall during a performance of some heavy beats, the same library that allows me to change high-level pattern structures on the fly will also allow me to start multiplying bare sine waves and performing brutal additive synthesis live alongside these patterns. The code shown earlier of a kick, snare and clap all being run as separate 'instruments' is how I usually do my live coding, and while this seems very text-heavy and verbose, it allows me to create a number of small, relatively self-governing processes which will compute and play of their own accord, until I change them. Through this method, my performances usually involve building up musical textures and patterns through allowing each 'instrument' a small amount of its own variability - together each small amount of variability comes together to form a kind of emergent complexity, the sum of all of its (relatively) simple parts. Through the performance I'll then manage these units, building new ones as old ones become fatiguing, and injecting new life into stalwart units (such as kick/snare drums) by modifying their patterns/pitch/effects/etc. I like to think of this live coding performance setup as a kind of ecology of small units being constructed, managed, decommissioned, revamped and destroyed throughout a performance.

This kind of 'ecological' approach means that once the basis of a 'sound' during a performance are established (eg. hi-hat pattern, kick and two melody lines) I can spend some time building the next set of sounds, while the other sounds manage themselves and stay sonically interesting through some well(/poorly)-placed algorithmic transformations. The verbosity of the pattern language also helps in some respects too, having to type the names of individual parameters means I am forced to consider the nature of the sound I'm about to throw into the mix while I'm typing it. This is one of the reasons why I don't think I got on with Tidalcycles when I tried to perform solo with it - it's powerful enough to change the entire dynamic of a performance using a few characters, and I'm not responsible enough to wield that power.

My biggest gripe with SuperCollider is the pretty verbose Pattern syntax, as patterns are a huge part of my live performances. I think the pattern classes in SuperCollider are very powerful, but a lot of typing _does_ need to be done. Fortunately the [ddwSnippets](https://github.com/jamshark70/ddwSnippets) quark has finally arrived, delivering some snippets to the SuperCollider IDE! Before that, I would keep a bunch of 'default' patterns on hand in another document during performance to copy-paste and change. I've also heard that [scvim](https://github.com/sbl/scvim) is currently in active development, and as a vim user I'd love to integrate it as my SuperCollider editor.

All things considered, while not the most intuitive live coding platform, it's the one that works for me, and will probably continue to be so.
