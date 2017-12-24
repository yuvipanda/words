---
title: Devlog for Tuesday, September 24, 2013
author: yuvipanda
type: post
date: 2013-09-24T11:29:47+00:00
url: /devlog-tuesday-september-24-2013/
dsq_thread_id:
  - 1792273494
categories:
  - devlog
  - wiki

---
I&#8217;ve given up on trying to make DevLogs really comprehensive and complete, and just try to make them &#8211; even if they are incomplete. Perhaps this will help me actually write more devlogs, and thus make it more comprehensive&#8230;

I started on the [Functional Programming in Scala][1] course today. I wanted to do it the last time, but did not find the time. This time will be different &#8211; I&#8217;m in a different spot mentally, and a big drain on my emotional / time resources (&#8220;college&#8221;) is no longer a factor. I&#8217;ve already gone through the first week&#8217;s lectures (most seem straight ports from [SICP][2]), and am 2/3 of my way through the assignments for the first week. Though I&#8217;m normally not fond of the typical types of exercises (&#8220;How many ways can you make change for this scenario?&#8221;), doing them functionally seems to be enough of a twist to keep me interested. The regular languages I seem to work with these days (Java, PHP, Puppet, Python and a bit of JS) aren&#8217;t exactly well tuned to the functional style of programming (except JS, but I don&#8217;t really do that much JS these days) &#8211; so going through this course and hopefully building something in Scala can exercise my &#8216;OMG HOLY SHIT THIS NEW THING IS AWESOME!!1&#8217; muscles.

The course recommends using Scala IDE. Which is Eclipse based. Despite my deep distaste for Eclipse, I&#8217;ve given it a shot and it seems fairly stable and much less shitty than the Eclipse I&#8217;m used to! Let&#8217;s see how that goes.

The way I learn the best seems to be to find a project I want to build, and then build it in a new language. I&#8217;m looking around for fun projects that I could build with Scala, and I&#8217;m pretty sure I&#8217;ll find one at some point. I should also try to diversify the communities I contribute to, so perhaps I should look for a non-Wikimedia project where I can contribute to in Scala. Should be fun :D

Other than that &#8211; I&#8217;ve been [investigating performance problems][3] with the Campaigns API &#8211; turns out Mediawiki&#8217;s Parser is really, really slow. Who would&#8217;ve thought, eh? ;). The &#8216;solution&#8217;, of course &#8211; is to just add more caching. Which is a sortof biggish, hairy-ish problem because of the number of changes that can cause cache invalidation. The way Mediawiki handles caching is&#8230; rather complex &#8211; but that is more due to how much functionality exists rather than anything else. Needs a proper &#8216;clean&#8217; solution that is not just &#8220;Let&#8217;s cache everything for 5 minutes!!!1&#8221;. Should be fun to write up and fix!

I&#8217;ve also been spending time integrating [Mediawiki-Vagrant][4] with [Wikimedia Labs][5]. This will make it easy for anyone to setup a base mediawiki installation on Labs, and save time dicking around various mundane deployment-of-test-instance issues (did I turn on caching? How do I get this extension on? etc). This is interesting because it merges two different puppet repos &#8211; operations/puppet.git and mediawiki/vagrant.git on one machine and provides different ways of managing them. Since this is also using puppet as a sort of &#8216;deployment&#8217; tool (rather than just a configuration-of-systems tool), that is an interesting / fun aspect too. Should be able to get the [patch][6] merged in a few weeks.

I visited San Francisco for the last 2 weeks. I don&#8217;t really feel insecure anymore :)

 [1]: https://www.coursera.org/course/progfun
 [2]: https://mitpress.mit.edu/sicp/
 [3]: https://bugzilla.wikimedia.org/show_bug.cgi?id=54465
 [4]: https://www.mediawiki.org/wiki/MediaWiki-Vagrant
 [5]: https://wikitech.wikimedia.org
 [6]: https://gerrit.wikimedia.org/r/#/c/85814/