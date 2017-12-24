---
title: Cheese 2.31.1 Released
author: yuvipanda
type: post
date: 2010-07-22T19:57:53+00:00
url: /cheese-2-31-1-released/
aktt_notify_twitter:
  - no
enclosure:
  - |
    |
        http://dl.dropbox.com/u/8768784/cheese-midterm.ogv
        19245237
        video/ogg
        
dsq_thread_id:
  - 706191239
categories:
  - code

---
If you had read my [Cheese GSoC proposal][1], it would&#8217;ve stressed on one major point &#8211; make Cheese sexy.

Two days ago, one of my classmates spent 5 minutes on the bus using Cheese and trying out different effects (and poses!). Today, my brother spent 20 minutes trying to get the perfect combination of style and vagueness for his Facebook profile picture &#8211; using Cheese. He then asked me to create an account for him in Ubuntu (he was an exclusively Win7 user till then) before leaving.

I&#8217;m still not where I want to be (the girls haven&#8217;t gone gaga over it&#8230;yet!), but I know very well that I am on the right path.

And a major milestone in that path is the release of Cheese 2.31.1. The &#8216;release&#8217; means that the code is now stable enough to be actually shown off. The major features (rewrite in Vala, use Clutter, user defined Effects and most importantly, Live Previews) are in working condition. We are no longer walking through a minefield of segfaults. You can build it and show it off. When something breaks and [you tell us][2], we&#8217;ll most probably not reply with &#8216;yeah, we know that. We&#8217;ll fix it when we get to it&#8217;. The road to Cheese 3.0 has begun.

So, what&#8217;s all in this release?

  1. Rewrite of the UI code. We removed the entire old src/ folder, and rewrote everything from scratch. Using [Vala][3]. Why? Because ~7000 lines of C code is now ~1500 lines of Vala code. And the Vala code has more features (Live preview, for one!). The Vala compiler is pretty mature &#8211; only one &#8216;real&#8217; bug so far (rest have been mostly binding bugs, fixed with single line of code changes). And #vala has been incredibly helpful too! And we are re-using most of the &#8216;backend&#8217; code (Camera detection, pipeline linking, etc) &#8211; it is still in C, and writing Vala bindings was incredibly simple.

  2. Move from Gtk to Clutter for display. Means I can do stuff like overlay semi-transparent text on top of the effects. Or have animated page transitions. Or (in the future), use OpenGL effects without having to do an extra to-fro copy from memory. Have drop shadows for everything. Make the effects tilt and rotate around when hovered over. Etc, etc, etc. Clutter is the major contributor to the &#8216;sexy&#8217; part.

  3. User created effects. Effects are no longer hardcoded. A simple 4 line text file and enthusiasm for reading documentation is all that is required to create your own effect. The effects are based on GStreamer, and are very flexible &#8211; you can create something as simple as monochrome + hue, or something as complex as face detection + extra limb addition to specific people :P

  4. Live Streaming &#8211; biggie. All effects are arranged in grids of 3&#215;3 in multiple pages that you can swipe through. Simply clicking one will activate it pretty much instantaneously. No more &#8216;select effect, apply, no-it-sucks, let&#8217;s go back and do it again&#8217; games :) 

[![][4]][5]

I made a [quick screencast][5] to show the new Live preview stuff to those of you too lazy to actually get the source and compile. And the subject is a pink+green teddy bear sitting on my white netbook. (And the weird stuff that turns up after I exit fullscreen is a bug in [RecordMyDesktop][6] &#8211; and is an incentive for you to actually [get the source][2] and check it out :P)

These are the four _major_ features that are new. All the other parts of previous Cheese UI have also been implemented (preferences, thumbnail viewer, fullscreen, wide mode, device detection, etc.)

As for the next release &#8211; keep looking out for it, it will land soon! It will primarily be a bug fix and code cleanup release &#8211; fixing crashes, UI inconsistencies and making sure everything works as intended.

A lot of late night hackery (mostly because my college takes up 10 hours of &#8216;regular&#8217; time) has gone into this release &#8211; so check it out [here][2] and tell us what you think. Especially about the parts that suck. Especially useful would be if you can get someone non-technical to sit in front of Cheese, observe where all they fail (and succeed) and then report your observations back to us.

 [1]: http://yuvi.in/blog/gsoc-2010-proposal.html
 [2]: http://ftp.gnome.org/pub/GNOME/sources/cheese/2.31/
 [3]: http://live.gnome.org/Vala
 [4]: http://dl.dropbox.com/u/8768784/cheese-midterm.png
 [5]: http://dl.dropbox.com/u/8768784/cheese-midterm.ogv
 [6]: http://recordmydesktop.sourceforge.net/about.php