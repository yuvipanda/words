---
title: Cheese GSoC Report – Week 7
author: yuvipanda
type: post
date: 2010-07-12T18:26:54+00:00
url: /cheese-gsoc-report-week-7/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 2104208384
categories:
  - code

---
This week on Cheese&#8230;.

  1. Performance enhancements. Sacrificed some startup time for **much** improved usage time. Viewing live effects are now a snap. So is selecting an effect. We went in some cases from ~15s to <1s. Thanks to Tester (and other folks) at #gstreamer for helping out :)
  2. Paging of effects. Effects are now in pages of 9 each, instead of a huge scroller area.
  3. Applying effects without stopping the pipeline. Makes things much faster.
  4. Implementing the popup menu for thumbnails.

We&#8217;ll be making a release anytime now :) 

All of last week&#8217;s goals were met, except the code cleanup. It will probably have to wait after release.

As I type this, there are 6 blockers before we can make a release. Will make a post when we do a release, hopefully with a screencast too!

Next week is kinda unpredictable &#8211; I&#8217;ll douse fires as they arise in the code (reported by people who hopefully test the release), and also work on reducing the length of items in the TODO.