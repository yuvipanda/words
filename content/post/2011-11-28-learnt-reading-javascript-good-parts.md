---
title: What I learnt from reading “Javascript – The Good Parts”
author: yuvipanda
type: post
date: 2011-11-28T10:40:50+00:00
url: /learnt-reading-javascript-good-parts/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 486173721
categories:
  - code
tags:
  - book
  - js
  - php

---
Just finished reading &#8216;Javascript &#8211; The Good Parts&#8217;. Here is what I learnt:

  * I knew jack shit about JavaScript. I was able to get along so far simply because I knew jQuery and understood how closures work.
  * Holy shit that&#8217;s one fucked up language. Quite schizophrenic, saved by almost limitless extensibility/monkey-patchability/watcha-gonna-do-write-a-java-applet-hahaha .
  * If you&#8217;re going to write Javascript, you&#8217;ll have to subset. Subsetting/augmenting has its own share of problems &#8211; primarily that `map` in your code might not be the same as `map` in someone else&#8217;s code, even if they seem to be working on the same &#8216;type&#8217;
  * jQuery is incredible. I guess it is sort of like a &#8216;Standard Library&#8217; of sorts, atleast on the client side. I&#8217;m sure there exists something similar on the server side as well (underscore.js, perhaps?)
  * I haven&#8217;t written any sufficiently large Javascript program yet. Need to fix that.

### Defensive Programming

When you&#8217;re writing PHP, you program _defensively_. The language is out to get you. Make one wrong step and it&#8217;ll fuck you over. Never assume anything, make sure you always check the documentation. You can&#8217;t trust the language. It&#8217;s not stupid, it&#8217;s schizophrenic.

I think I should start treating JavaScript also that way.