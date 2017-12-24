---
title: GSoC Milestones – Vala Build using AutoTools
author: yuvipanda
type: post
date: 2010-05-06T07:00:20+00:00
url: /gsoc-milestones-vala-build-using-autotools/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 510923812
categories:
  - code

---
_I&#8217;m using a [RTM List][1] to track my milestones for this [my GSoC][2] this year. I&#8217;ll be making a blog post for each item ticked off that list, to share what I&#8217;ve learnt in my journey from n00b to someone whose code is good enough to be included in GNOME. This is part 1 in the series, where I tell you about autotools_

My GSoC project involves, moving major parts (UI) of Cheese to a new language &#8211; [Vala][3]. Vala is more an extremely glorious C preprocessor than a language of its own &#8211; it just translates down to GObject based C code, rather than bytecode/objectcode. The syntax is very C#ish &#8211; I was using [csharp-mode][4] in emacs to code vala till I got bored enough to download [vala-mode][5]. It&#8217;s got closures &#8211; haven&#8217;t used them yet, here is to hoping they&#8217;re real closures. It has _tons_ of libraries &#8211; it takes a few (minutes|hours) to write a binding for any C library, so many bindings already exist. You don&#8217;t lose speed &#8211; Vala is compiled down to C code. It also has one of Java&#8217;s suckiest features &#8211; _Checked Exceptions_. The documentation is non existent &#8211; you&#8217;ve to pretty much read through the bindings, or the original C library&#8217;s documentation to get anything done. And not many people know such a language exists ([Kausik][6] for example &#8211; but he also didn&#8217;t know you could output pdf from latex, so I don&#8217;t think his opinion counts :D)

Cheese uses autotools for building. I had to tweak their script to make it build my Vala code as well. I&#8217;ve never worked with any of the autotools stuff before &#8211; I didn&#8217;t even know `.ac` stood for `autoconf` and `.am` stood for automake. No big deal &#8211; Google knows it all and will tell you for free. I JFGI and found a bunch of articles about using autotools to successfully build vala projects. After reading [this monstrous (180+ slides, but ~500 pages) Autotools presentation][7] (which is actually very, _very_ good, btw), I had a working build script. It built my single `cheese.vala` file that did nothing but run a loop and wait to be terminated. It had a place where I could add more `.vala` files and they should (should) be included in the build. It was hackish, but like most hacks, it worked. [On My Machine][8](tm). 

Nowhere else. Turned out my script wasn&#8217;t working at all &#8211; just faking it to me. I had initially tested out `valac` (the vala compiler), which had produced a `.c` file. Since `make` was supposed to produce the same file, and it wasn&#8217;t stale (I hadn&#8217;t touched my `cheese.vala`), it just proceeded to compiling the `.c` files with `gcc`. The Vala part of the build script wasn&#8217;t being executed at all. Removing the `.c` file told me that my hackish script hadn&#8217;t worked at all. 

After banging my head for a while to figure out _why_ it wasn&#8217;t working, I finally landed up on the official autotools docs. Autotools had added [native vala support][9]. The hack I found was not necessary. 

_facepalm_

**Moral of the Story**: RTFM comes first, not JFGI.

Anyway, I rewrote the build script to be much more cleaner in a couple of minutes. And it worked. 

Build systems are actually a lot of fun once you get the hang of it. A black screen with fast scrolling green text cryptic to everyone else but totally sensible to you is incredibly attractive, no? :)

 [1]: http://www.rememberthemilk.com/home/yuvipanda/13485943/
 [2]: http://yuvi.in/blog/gsoc-2010-the-beginning.html
 [3]: http://live.gnome.org/Vala
 [4]: http://www.emacswiki.org/emacs/CSharpMode
 [5]: http://live.gnome.org/Vala/Emacs
 [6]: http://kausikram.net/
 [7]: http://www.lrde.epita.fr/~adl/autotools.html
 [8]: http://www.codinghorror.com/blog/2007/03/the-works-on-my-machine-certification-program.html
 [9]: http://www.gnu.org/software/hello/manual/automake/Vala-Support.html