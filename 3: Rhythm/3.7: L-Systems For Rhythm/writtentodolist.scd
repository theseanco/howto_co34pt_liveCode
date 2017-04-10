// 3: Rhythm/3.7: L-Systems For Rhythm/3.7: L-Systems For Rhythm.md:TODO: Write a good example
3: Rhythm/3.7: L-Systems For Rhythm/3.7: L-Systems For Rhythm.md:TODO: do this for pitch/melody too
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:The [Pwhite](TODO) class is a great way to incorporate randomness into patterns, and one of the first things I tried to do when adding complexity to rhythms was to simply randomise them, however the results were often quite disappointing, especially with multiple random rhythms played at once for sounds that are played regularly (i.e. snares, hats):
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: Shit examples of random rhythms
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:With rhythms that use random floating point numbers, the durations that are used have no relationship to any central pulse, and will end up cutting across the beat a lot of the time in a way that I feel does not make sense in dance music. Instead, randomness can be incorporated within various techniques (for a great example see the way that Pwhite is used in the section on Euclidean Rhythms), or constrained to fit within a more regular pattern by using methods (which can be found in the [Pattern Documentation](TODO)).
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: constrained randomness
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: whole note randomness
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:Some great advice I received from a lecturer was 'if one of them is good, lots of them will be great' (paraphrased), when talking about the work of [an artist](TODO: Who is this again?). This works really well when applied to rhythmic percussion, particularly if each layer of similar percussion serves to re-contextualise the last.
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: the polyrhythmic clap works very well against a (3,8)
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: layering at different pitches
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: Layering at slightly different rhythms, lengths
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: layering rhythms
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: StageLimiter throttling of rhythmic parts
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: is there any more of these?
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:A technique that I started using after being inspired by Trap instrumentals (such as Ace Hood's [Bugatti](https://www.youtube.com/watch?v=-2KF2JbrQ94)) was hi-hats that snapped between 1/4, 1/8, 1/6 and 1/16th note patterns. The best way I found to do this was to use [Pwrand](TODO: this). Pwrand takes an array of items, and will select those items randomly within a weighted distribution, allowing control over the frequency of occurrence of particular elements.
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: Trap hi-hats
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: a straight kick that occasionally varies
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: basic example of cut-off samples
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: Sputtery longer percussion
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:[Pkey](TODO: this) is a pattern class used to embed the same value multiple times in the same pattern - for example if the release value of a SynthDef needed to be the same as the duration of the note:
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:One way to use this in rhythm is to create sample playback that flips back and forth. Due to how the [`bplay`](TODO: This) Ugen works, if a buffer is to be played backwards it will need to be started just before the end of the sample as the Synth will release once the sample is finished (for more information see [Ugen done-actions](TODO: this)). Using the `.linlin` linear scaling method this value can then be scaled into the rate of playback to create a back-and-forth pattern in percussion, shown here on a snare:
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: back-and-forth snare
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: Normalizesum and (1..10) method. Also show how this can be multiplied
3: Rhythm/3.3: Techniques For Modifying Rhythm/3.3: Techniques For Modifying Rhythm.md:TODO: this
3: Rhythm/3.4: Modifying Basic Rhythms/3.3: Modifying Basic Rhythms.md:The [Pwhite](TODO) class is a great way to incorporate randomness into patterns, and one of the first things I tried to do when adding complexity to rhythms was to simply randomise them, however the results were often quite disappointing, especially with multiple random rhythms played at once.
3: Rhythm/3.2: Basic Rhythms/3.2: Basic Rhythms.md:TODO: more basic rhythms to be added
Binary file 3: Rhythm/3.5: Euclidean Rhythms/.3.x: Euclidean Rhythms.md.swp matches
4: Melody and Pitch/4.x: Good SynthDef Writing for co34pt_LiveCode/4.x: Good SynthDef Writing for co34pt_LiveCode:TODO: Before you do this, annotate your sythdefs
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: example of pitch/noise/dichotomy/unification - Holden perhaps? Put this in the preamble
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: Demonstrate SinOscFB, going through the end of the modulation curve and back out of the end of it
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: a synth riff with a sine wave modulation that gets more and more extreme. Poll it in the post window.
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: extreme modulation
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: extreme pitch values
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: HenonN - A case study
4: Melody and Pitch/4.x: Between Pitch And Noise/4.x: Between Pitch And Noise.md:TODO: Sonic result of different interpolation techniques
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: finish this.
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: up-down riff, various examples, random riff.
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: Pwrand-based riff shifting
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: Phasing example
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: Write an example of sample stabs and reverse-engineer a description out of the way that these things work
4: Melody and Pitch/4.3: Riffs/4.x: Riffs.md:TODO: Write an example of Place and compound riffs and reverse-engineer a description out of the way that Place works
4: Melody and Pitch/4.x: Pitch and Static Synths/4.x: Pitch and Static Synths.md:TODO: do we need this
4: Melody and Pitch/4.1: Pitch And Patterns/4.1: Pitch And Patterns.md:TODO: proofread
4: Melody and Pitch/4.1: Pitch And Patterns/4.1: Pitch And Patterns.md:TODO: add examples
4: Melody and Pitch/4.1: Pitch And Patterns/4.1: Pitch And Patterns.md:TODO: Specifying raw pitch with detune
4: Melody and Pitch/4.1: Pitch And Patterns/4.1: Pitch And Patterns.md:TODO: scale/oct/degree pitch
4: Melody and Pitch/4.1: Pitch And Patterns/4.1: Pitch And Patterns.md:TODO: chords
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: Finish This
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: Chords I, IV, V, (ii)
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: Explain why these envelopes are long.
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: slow chords over random melody
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: jazz chords
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: using microtonal scales
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: list the 53-tone pitch smear here
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: do tuning example, and also check whether or not all tunings can be done with all scales because i legit can't remember
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: Detailed example of fundamental frequency/modulation etc.
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: A harmonic series that runs from 1-30 evenly
4: Melody and Pitch/4.2: Types of Pitch Arrangement/4.2: Types of Pitch Arrangement.md:TODO: Changing the granularity of multiple frequencies
5: Non-pattern Techniques/5.x: SuperCollider as a Modular Synth/5.x: SuperCollider as a Modular Synth.md:TODO: Finish this
5: Non-pattern Techniques/5.x: SuperCollider as a Modular Synth/5.x: SuperCollider as a Modular Synth.md:TODO: static synths, chaining static synths, moving them around, effects, feedback, all of these things in an extended example
