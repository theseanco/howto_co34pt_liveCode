# ProxySpace - My Foundation for Live Coding in SuperCollider
============================

## Why ProxySpace?

If you haven't heard of or used it before, [ProxySpace](http://doc.sccode.org/Classes/ProxySpace.html) and it's associated [JITLib](http://doc.sccode.org/Overviews/JITLib.html) are _well_ worth knowing about, and are without exception what I use to live code in SuperCollider.

According to the docs (see link above):
>Generally a proxy is a placeholder for something. A node proxy is a placeholder for something playing on a server that writes to a limited number of busses (e.g. a synth or an event stream). NodeProxy objects can be replaced and recombined while they play. Also they can be used to build a larger structure which is used and modified later on.

In other words, ProxySpace opens up SuperCollider's language into a powerful performance tool by allowing individual functions/patterns/etc to become flexible and modifiable, as well as to make these patterns interact. When using ProxySpace, the traditional

```
{SinOsc.ar(440,0,0.2)!2}.play
```
is turned into an 'instrument' when given an arbitrary name and edited on the fly. It can also be used within other 'instruments', for example:

```
(
~sine1 = {SinOsc.ar(440,0,0.2)!2};
~modulation = {Saw.ar(10,0,1)!2};
~sine2 = {~sine1 * ~modulation};
~sine2.play;
)
```

ProxySpace can also be used for synchronising together [patterns](http://danielnouri.org/docs/SuperColliderHelp/Streams-Patterns-Events/Pbind.html) (including percussion, melodies, basses etc) in a quick and easy way, while allowing them to be edited and combined on-the-fly. Most of my live sets revolve around the creation (and destruction) of patterns, and ProxySpace makes this really quite easy. With ProxySpace I can build a performance using multiple self-managing 'instruments' and play them as I build them. By doing this I can think reasonably laterally about the performance, building up and packing down individual 'instruments' as I need them, while all of the existing 'instruments' continue playing. It also has some functionality such as automatic crossfading which is very useful for creating smooth performances.

I've written two extended examples of how I use ProxySpace which are in this folder. They are musical examples that I would use in live performances I deliver. Open them up in your SuperCollider IDE and follow along.

ProxySpace (and JITLib in general) also have *great* documentation, which i'd recommend:
- [ProxySpace Examples](http://doc.sccode.org/Tutorials/JITLib/proxyspace_examples.html)
- The [JITLib Basic Concepts](http://doc.sccode.org/Tutorials/JITLib/jitlib_basic_concepts_01.html) series
- [JITLib Overview](http://doc.sccode.org/Overviews/JITLib.html)

