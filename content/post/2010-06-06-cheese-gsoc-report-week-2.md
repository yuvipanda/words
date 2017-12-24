---
title: Cheese GSoC Report – Week 2
author: yuvipanda
type: post
date: 2010-06-06T04:20:42+00:00
url: /cheese-gsoc-report-week-2/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 597426945
categories:
  - code

---
Second week of the (rather hot and sweaty) Summer of Code is over! And during this week&#8230;.

  1. Replicated most of the UI of Cheese
  2. Learnt how to make C and Vala code co-exist (Thanks folks at #vala!)
  3. Made the thumbnail widget work, in both modes/orientations
  4. Implemented fullscreen mode, with autohiding of the action buttons
  5. Started modifying parts of libcheese to support clutter for video output

In [last week&#8217;s report][1], I mentioned that I didn&#8217;t quite like my pace of work. I _still_ don&#8217;t like it &#8211; [Hamster][2] reports I&#8217;ve spent 15.2 hours since Monday on Cheese, which is just about 3 hours a day! Totally unacceptable, and I&#8217;d like to increase that number considerably. 

Last week&#8217;s predictions were for libcheese integration, UI replication and Thumbnail view implementation. I&#8217;ve finished the last two, and have made a start on the first. Needs improvement.

By next week, I hope to have accomplished&#8230;

  1. Working video preview showing up!
  2. Photo taking works
  3. Video taking works
  4. Burst mode works

Basically, it would be usable. In a basic way.

And what did I learn this week?

  1. Don&#8217;t try to be too clever. Clear Code > Lesser LoC.
  2. Ask first. Verify assumptions.
  3. Just because something can be rewritten, does not mean it should be :)

On an unrelated note, my sleep cycle is totally messed up &#8211; I&#8217;ve been sleeping at 6 AM and waking up at 2 PM. Sunlight feels weird to me. I haven&#8217;t been able to do my biweekly bicycle rides :( I should also try to fix that before the end of next week.

 [1]: http://yuvi.in/blog/cheese-gsoc-report-week-1.html
 [2]: http://projecthamster.wordpress.com/