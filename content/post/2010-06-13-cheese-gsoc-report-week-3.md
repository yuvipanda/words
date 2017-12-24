---
title: Cheese GSoC Report – Week 3
author: yuvipanda
type: post
date: 2010-06-13T04:24:14+00:00
url: /cheese-gsoc-report-week-3/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 580810021
categories:
  - code

---
Third week of the Summer of Code is over! And during this week&#8230;.

  1. Successfully wrapped up the core cheese functionality (`libcheese`) with a vala wrapper
  2. Made Photo Mode work
  3. Made Video Mode work
  4. Made Burst Mode work
  5. Made cheese single instance using `libunique`
  6. Started work on cleaning up GConf code.

In [last week&#8217;s report][1], I mentioned that I didn&#8217;t quite like my pace of work. It is still the same (approx. 3 hours a day on average, excluding overhead) &#8211; but I&#8217;ve come to accept that it is okay. No more bitching about it, as long as I&#8217;m meeting my goals.

Last week&#8217;s predictions were to complete libcheese wrapping, photo mode, video mode and burst mode. Set goals accomplished with ample time to spare &#8211; time that was spent trying to get countdown animations to work (still haven&#8217;t managed), and make cheese single instance. I under-estimated last week &#8211; should improve accuracy.

By next week, I hope to have accomplished&#8230;

  1. Fully functional preferences dialog box
  2. Countdown animations
  3. Full GConf integration (i.e. remember all your preferences)
  4. Full blown keybindings (Basically `<Esc>` to cancel, since the others are already implemented)
  5. Trash/Delete implementation

It would have everything Cheese 2.30.1 has, except for Effects.

And what did I learn this week?

  1. RTFM. Again. And again. THEN ask on IRC. 
  2. How to use gdb. I&#8217;ve only cursorily used it before &#8211; but digging into it deeper now (thank you, segfault!)

 [1]: http://yuvi.in/blog/cheese-gsoc-report-week-2.html