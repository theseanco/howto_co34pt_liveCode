# L-systems for Rhythm

---------

As of early April 2017 I haven't been doing this for too long, so this section will be brief.

[L-systems](https://en.wikipedia.org/wiki/L-system) are, according to Wikipedia:

> a parallel rewriting system and a type of formal grammar. An L-system consists of an alphabet of symbols that can be used to make strings, a collection of production rules that expand each symbol into some larger string of symbols, an initial "axiom" string from which to begin construction, and a mechanism for translating the generated strings into geometric structures.

For a good example to visualise what this means, [this](https://en.wikipedia.org/wiki/L-system#Example_1:_Algae) was one I found very helpful.

I was inspired to start using L-systems for rhythm after hearing one of [Renick Bell's](http://www.renickbell.net) [Fractal Beats](https://soundcloud.com/renick/fractal-beats-151212-edit) tracks on SoundCloud, and in turn reading his paper about [rhythmic density in live coding](http://lac.linuxaudio.org/2014/papers/38.pdf) for the Linux Audio Conference. The approach to rhythm in this Fractal Beats track is unlike any I have heard - the rhythms are complex and don't appear to lock into common divisions of a regular beat, but do not seem to fall into the trappings of being 'random'. This stochastic approach to rhythm appears to yield something that, to me, resembles 'free techno'†. 

While I have no idea how to use [Conductive](https://hackage.haskell.org/package/conductive-base), there are some useful implementations of L-systems in SuperCollider. [Prewrite](http://doc.sccode.org/Classes/Prewrite.html) is SuperCollider's class for implementing L-systems within patterns. Prewrite takes a rule set and an initial axiom, and will expand the axiom within a Pbind.

For example:

```supercollider
//use L-system as a duration value for a kickdrum
(
l = Prewrite(1, // start with 1
        (    1: [0.25,2],
            0.25: [3,3,2]/4,
		3/4: [0.25,1,0.125,0.125],
        ), 4);
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,l,\amp,1);
~k.play;
)
/*

With that grammar:

1 -> 0.25,2 -> 3/4,3/4,2/4 -> 0.25,1,0.125,0.125,0.25,1,0.125,0.125 -> etc.

*/
//much like with the euclidean rhythm convergence/divergence pattern, you can use variable l for different patterns too
(
~sn = Pbind(\instrument,\bplay,\buf,d["s"][0],\dur,l,\amp,1,\rate,Pseq((1..4)/2,inf));
~sn.play;
)
//and transform it
(
~h = Pbind(\instrument,\bplay,\buf,d["ch"][0],\dur,l,\stretch,Pwhite(0.5,2).round(0.5),\amp,Pwhite(0.2,1));
~h.play;
)
//an off-beat open hat for reference
(
~oh = Pbind(\instrument,\bplay,\buf,d["oh"][1],\dur,Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
)
```

† With the 'free' in 'free techno' I am referring specifically to [free improvisation](https://en.wikipedia.org/wiki/Free_improvisation), a music style involving one or more instrumentalists improvising with no (or little) preordained structure. Some examples from a few styles of Free Improvisation are [The Ornette Coleman and Eric Dolphy Octet](https://www.youtube.com/watch?v=xbZIiom9rDA), [Yeah You](https://vimeo.com/82761150), [Okkyung Lee](https://www.youtube.com/watch?v=RH_rbZW9HMo), [黒電話666](https://www.youtube.com/watch?v=pH2TQjeZQx4) and [Usurper](https://www.youtube.com/watch?v=g_BHjCJNahY). While the stochastic approach obviously has preordained structure, it is much less idiomatic than the kinds of regular rhythms common in dance music. The rhythms in the linked Fractal Beats track appear to 'wander' in a way that I can only describe as being reminiscent of Free Improvisation, while still appearing to co-ordinate around the central rhythm of the track. The divergence in the rhythms present is profound, but at no point does any of it seem to be 'out of control' or 'random'. This isn't the most articulate explanation of my thoughts, but it's the closest I've come to describing Renick's music.
