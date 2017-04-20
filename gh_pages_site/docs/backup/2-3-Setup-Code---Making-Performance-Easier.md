# Setup Code - Making Performance Easier

TODO: Proofread this

In the root directory of this repo, there is a [Setup](../Setup) folder, which contains some files, including [`Setup.scd`](../Setup/Setup.scd), [`SynthDefs.scd`](../Setup/SynthDefs.scd) and [`Snippets.scd`](../Setup/Snippets.scd). 

As I mentioned in 'Why SuperCollider', one of my big gripes with SuperCollider and performing with it is the amount of pre-building that needs to be done in order to incorporate any higher level structures, such as playing samples, triggering instruments, and suchlike. This setup folder addresses that problem, and contains my personal SuperCollider performance setup, and can be loaded entirely by either running the `Setup.scd` file, or calling it from somewhere else (for example in line 14 of the [second ProxySpace tutorial](2.2:\ ProxySpace\ -\ My\ Foundation\ For\ Live\ Coding\ In\ SuperCollider/Proxyspace\ ii.scd) by specifying the relative filepath to the setup file and using the `.loadRelative` method on it. I can (and have) performed without this setup file, but for the most part I run this setup file before any performance I do.

The `Setup.scd` file does the following things:
- Increase the number of buffers available for SuperCollider to load
- Increase the amount of memory size available to the Server, to allow for more CPU-heavy work
- Boot the server
 Display the server Oscilloscope (Which I regularly use as visuals in my set)
- Start ProxySpace, and make a 60BPM proxy tempo clock
- Lines 20-27:
    - Creates a `Dictionary`, `d`, to hold samples
    - Recursively loads all samples of the correct set in the [`samples`](../../samples) folder. These samples are organised into folders which contain the samples. The name of the folder will be added as an entry to the dictionary, and the samples will be added as sub-entries. 
        - For example, if you wanted to reference the second sample in the kick drum folder you would use `d["k"][1]` (`d` for the dictionary, `"k"` as kickdrums are held in directory `"k"`, and `1` as you are referencing the second sample)
- Loads the [`SynthDefs.scd`](../Setup/SynthDefs.scd) file, containing some custom SynthDefs which I use inside of patterns. Notably the necessary synthdef for playing samples `bplay`, and some instruments such as `sinfb` and `ring1`.
8. Loads the [`Snippets.scd`](../Setup/Snippets.scd) file, which contains some snippets to be loaded into the [ddwSnippets Quark](https://github.com/jamshark70/ddwSnippets), for easy access during performance, which include basic percussion patterns, some functions and some patterns that have a lot of default arguments I might not remember while performing
9. Starts `StageLimiter` from the BatLib quark, to protect everyone's ears
10. Posts a message to show all the above have been completed

Once this setup file has been run, everything is set up to perform, all in one evaluation. The `.loadRelative`s in the Setup file also means if any SynthDefs or Snippets are added and saved, they will be loaded next time the setup file is loaded.

If you're following any examples/etc from this repo, and it doesn't work and I haven't said anything about the setup file, assume that you need to run it for the code to work!
