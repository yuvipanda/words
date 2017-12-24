---
title: Cheese GSoC Report – Week 5
author: yuvipanda
type: post
date: 2010-07-01T02:35:58+00:00
url: /cheese-gsoc-report-week-5/
dsq_thread_id:
  - 328161486
aktt_notify_twitter:
  - no
categories:
  - code

---
Late report. But I did get quite a bit done!

Last week&#8230;

  1. Video Effects file format reader
  2. Live Preview of Effects! (YAY!)
  3. Effect files added

Live Preview took most of my time. We bought down CPU usage from ~90% to a more manageable ~50%. Cleaned up code a bit (still needs more cleanup). It is rather very &#8216;demoable&#8217;, provided you gloss over the slowdowns. 

Coming up next week would be&#8230;

  1. Even less CPU Usage! We&#8217;re now even with current Cheese (which does not give you live previews). I want to bring this down even more.
  2. Reduced latency for switching operations. Moving between effects/screens now has more than a second of latency. I should reduce this to much lesser than a second.
  3. Code cleanup. Some of the C code is a mess &#8211; needs to be cleaned up much. 
  4. Error fixing. You can now crash it by looking at it at a 58 degree angle, during new moon days. Bugs like these will be fixed.

Cya in a week, with a very-usable Cheese! I&#8217;ll post a screencast as soon as I&#8217;ve made Cheese a bit more sexy :)