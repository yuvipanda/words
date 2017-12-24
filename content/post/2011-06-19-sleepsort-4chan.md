---
title: SleepSort from 4Chan
author: yuvipanda
type: post
date: 2011-06-19T01:40:36+00:00
url: /sleepsort-4chan/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 336164468
categories:
  - code
tags:
  - algorithm
  - code

---
4Chan isn&#8217;t exactly what you&#8217;d associate with &#8216;shit, that&#8217;s a cool piece of code!&#8217;, but look [what I found][1]!

([via HN][2])



Nice hack. And it **is** `O(N)` in bitsize of largest number (Ignoring all the overhead of forking new processes, the problem with the race conditions(Sort 0 and 0.1? How about 0.01 and 0.011?), processor contention, etc,.) They basically delegated the sorting to the process scheduler, treating it as a sort of priority queue.

Sometimes you just see a hack so out of the box that it makes you say &#8216;woah!&#8217; and let your mouth hang open there for a while. One such time this :)

 [1]: http://dis.4chan.org/read/prog/1295544154
 [2]: http://news.ycombinator.com/item?id=2657277