# How to use this repo

-----------------

This repo is designed to be an interactive and explorable set of guides, as well as being browsable online and outside of SuperCollider. It's also designed to be as platform-agnostic as possible, and easily accessible with GitHub's basic tools.

If you are reading this online, and want to use any examples contained in these documents, or see any code I've written 'in the flesh', there's a few things you'll need to do.

1. Install [SuperCollider](https://supercollider.github.io/download)
2. Install [SC3-Plugins](https://github.com/supercollider/sc3-plugins/releases) (optional but recommended, reasons for this are documented in 2.1)
    1. NOTE: steps 1 and 2 on \*buntu (and probably other types of Linux too) can be performed with the `install_supercollider_linux.sh` script in the `scripts` folder. This installs both SuperCollider 3.8 and sc3-plugins as well as all relevant dependencies for \*buntu 
3. Install the recommended Quarks by evaluating the following code in SuperCollider (optional but recommended, reasons for this are documented in 2.1)
```supercollider
(
Quarks.install("Bjorklund");
Quarks.install("BatLib");
Quarks.install("ddwSnippets");
)
```
4. Clone this repo, which can be done from [the repo page](https://github.com/theseanco/howto_co34pt_liveCode), using the 'Clone or Download' page

The articles in this repo are grouped into category folders, which are then contained in subfolders with the name of the article. Each subfolder will have in it a `.md` file, which contains the text of the article containing examples, and usually a separate `.scd` file, which will be the examples from the `.md` file extracted and packaged for direct use within SuperCollider. The `.scd` files are designed to be loaded and run directly, and will usually contain a `.loadRelative` which will Setup that you will need to get started. You should then be able to run all examples.

If you want to read online while playing with examples in SuperCollider, run the `Setup.scd` file within this repository and then copy-paste the examples on the site into a file in SuperCollider and it *should* work. I need people to test these examples, so if it doesn't work, please raise an issue on GitHub with exactly what you've done and I'll look into it when I can, or get in touch with me.
