---
title: Cheese GSoC Report – Week 1
author: yuvipanda
type: post
date: 2010-05-30T02:22:41+00:00
url: /cheese-gsoc-report-week-1/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 590080902
categories:
  - code

---
First week of official coding is over. What do I have to show for it?

  1. Moved code from Github to GNOME Git (Thanks fargiolas!)
  2. Learnt how to use GTKBuilder, and how to autoconnect signals to vala callback functions.
  3. Learnt _some_ of the intricacies of Gtk+ Layouts (They still have a lot to teach me!)
  4. Got a very basic version of the basic Cheese window up and running.
  5. Learnt how to embed Clutter into the Gtk+ base of Cheese.

So far so good. I don&#8217;t quite like the pace of my work &#8211; I should be going faster. Hopefully I won&#8217;t be feeling like this at the end of next week :)

By next week, I hope to have accomplished&#8230;

  1. Pixel perfect UI, replicating exactly what is in cheese right now (except for the viewport, ofcourse)
  2. Vala bindings (`.vapi` files, basically) for `libcheese`
  3. Thumbnail View finished (either wrap and use current code, steal some some other project or write my own)
  4. Basic work on modifying libcheese to support video output to a ClutterTexture

GSoC is primarily about learning, so what have I learnt so far?

  1. `git` is a powerful tool, provided you do not fight it (thanks fargiolas!)
  2. Just because code works, doesn&#8217;t mean it is good enough! (thanks _ke!)
  3. When you are stuck, STOP AND ASK FOR DIRECTIONS! (thanks fargiolas!)