# Introduction: Rhythmic Construction for Algorave Sets

----------------------

### Context

In this document I'm going to talk about how I construct some basic rhythms for Algorave sets, but as my perception of rhythm is heavily influenced by the music I listen to, it's probably useful to list some of my influences to give some backdrop to the kinds of reference points I have when making repetitive electronic music designed for use in a dancefloor environment. These may or may not have manifested themselves at any point in any music I have played ever.

- [Basic Channel](https://www.youtube.com/watch?v=CUD4RaRSSio) 
- [DJ Rashad](https://www.youtube.com/watch?v=SWTsLnYO68U)
- [Holly Herndon](https://www.youtube.com/watch?v=ybzSWlpgJOA)
- [some of Mark Fell's performances](https://www.youtube.com/watch?v=s15wdk2xQik) (although the 'disinterested' performance aesthetic _really_ doesn't do it for me)
- [mobilegirl's mixes](https://www.youtube.com/watch?v=LzjI-pmnIUA)
- ['Dark DnB'](https://www.youtube.com/watch?v=lujClSXOvEw)
- [Skepta & Grime](https://www.youtube.com/watch?v=MQOG5BkY2Bc)
- [Drill & Trap](https://www.youtube.com/watch?v=2L-nP1UDPAw) (for example a beat by Young Chop)

### Conceptualising rhythm in live coding with SuperCollider

A problem I had with rhythm when I first started live coding was how to manage rhythm was the lack of 'cycles' or 'loops'. In DAW environments this is handled by the entire environment being organised around the [time signature](https://en.wikipedia.org/wiki/Time_signature), and in TidalCycles it is handled by the whole musical language being structures around cycles.

Using Pbinds in SuperCollider, rhythms are specified on an individual basis using numerical representations of durations. I found this problematic as a 'natural' rhythmic progression was lacking, as well as any recognition of a 'time signature'.

As a result of this, I initially found creating rhythms faithful to dance music traditions quite difficult when live coding. Consider [this track](https://www.youtube.com/watch?v=dsiZO6oAekE) by minimal techno legend Floorplan, AKA Robert Hood. The rhythms used here are very 'locked-in' to particular parts of a 4/4 groove in order to create a set of sounds that are idiomatically in-tune with Floorplan's particular sound, situated within the tradition of dance music he is creating. I have seen a number of these performances delivered using devices such as a [Electribes](https://upload.wikimedia.org/wikipedia/commons/1/18/Korg_Electribe_SX_(ESX-1).jpg), which are designed to place particular notes within a grid designed around a 4/4 groove. This approach to rhythm makes sense when designing dance music rhythms as specific rhythmic onsets have to be placed with reasonable precision in order to deliver a groove that is recognisably 'dance music'.

With SuperCollider however, I had to work out a way to specify these rhythms on a per-note basis, which required a bit of thought. It's quite difficult to delivery idiomatic grooves as whole units because they depend on the alignment of a number of drum sounds in particular configurations, with some onsets often falling at parts of a bar that are difficult to specify using `dur` values within Pbinds.

While this is a setback in the instant production of very specific rhythmic units, it has allowed me to develop a more algorithmic approach to rhythm. In a live coding performance I draw upon a set of strategies that deliver rhythms reminiscent of particular aspects of dance music which I will detail in this section, and when appropriately applied these techniques yield grooves that are (to my ears and body) very dance-oriented in their construction -  take for example [this rehearsal excerpt](https://soundcloud.com/co-3-4-pt/endlesswindowrehearsal_201016). The advantage of using Pbinds for rhythm is that the aforementioned strategies can easily be modified to include extended algorithmic elements to extend or modify their functionality. If I want a kick drum that plays every beat 80% of the time, and plays a more complex rhythmic pattern 20% of the time, it is trivial to change:
```supercollider
\dur,1
```
to
```supercollider
\dur,Pwrand([1,Pbjorklund2(5,16,1)/4],[0.8,0.2],inf)
```
With these kinds of techniques I can create dance music rhythms that algorithmically manage their own repetition (or lack thereof) to create variation in individual parts, which form grooves exhibiting a compound complexity from many small variations.

I am still working on this, and I still find rhythmic complexity a difficult thing to establish in SuperCollider, especially when considering higher-level structures, or constructing rhythms in compound time signatures. This section will serve as a documentation of my continuing journey through making dance music with SuperCollider, with the intention that people will move their bodies to it in whatever way they see fit. 

### Drum Samples

Another fundamentally important part of my approach to rhythm live coding is the samples that I use. I (for the most part) use drum samples for percussion of any kind for the simple reason that _all of the hard work has already been done, and done well_. I could synthesise my own percussion, but I'm not the greatest as synthesis and my results would probably sound lacklustre at best. If I use samples that have already been recorded, normalised (and possibly mastered) then I can be reasonably sure that they will penetrate a mix - and in adjusting their parameters I can be reasonably sure of their operation. If I used synthesised percussion it might oddly break under certain circumstances, or not cut through a mix for instance. The other advantage of using samples is that their impact on CPU use is reasonably small.

Samples can also give a lot of context to the kinds of sounds that I'm attempting to emulate through performance. For instance, a set of 808 sounds will allow for the kind of 'rattling' hi-hat sounds common to trap and hip-hop, or distorted kicks will make it easy to draw on some gabber at some point.

In using samples I can also store a number of different 'types' of each sound, for instance sub kicks, harder kicks, softer kicks, distorted kicks and pitched kicks. I haven't quite figured out the best system both to store and categorise these samples for use in performance, but I'm getting there.
