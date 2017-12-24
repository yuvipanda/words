---
title: How to increase Cheese’s Burst Mode Photo Count
author: yuvipanda
type: post
date: 2010-11-07T14:50:51+00:00
url: /how-to-increase-cheeses-burst-mode-photo-count/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 526342287
categories:
  - code

---
&#8220;Why does Cheese have a maximum photo count of 100 in burst mode?&#8221; questions have popped up quite a few times on the cheese list. It is just a teeny, tiny bug &#8211; fixed in master.

The work around is simple: 

**Till Cheese 2.32** 

Raise it to whatever value you want in `line 8` of `/usr/share/cheese/cheese-prefs.ui`. 

_(If you don&#8217;t know what version you are running, check `Help -> About`)_

(Fix is just raising the limit from 100 to something that most people will likely not hit. If they do hit it &#8211; well, `line 40 on /usr/share/cheese/cheese-prefs.ui` :D)