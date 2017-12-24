---
title: 'Paper notes: ‘The impact of syntax colouring on program comprehension’'
author: yuvipanda
type: post
date: 2016-03-09T08:03:07+00:00
url: /the-impact-syntax-colouring-program-comprehension-paper-notes/
dsq_thread_id:
  - 4646803582
categories:
  - papers

---
I&#8217;ve recently started reading more academic papers, and thought it&#8217;d be useful to write notes about them and publish them as I go along! This one is for [The impact of syntax colouring on program comprehension][1]

  * I was amazed at the amount of prior research it is citing. Why have I not been reading these for the last 10 years of my life?
  * Apparently it is ok to report findings with a sample size of 10 people. I do not know how I feel about this.
  * The fact that there&#8217;s a large amount of thought put into the design of the experiment is quite nice, and surprisingly different from environments I&#8217;ve worked in the past where product managers designed &#8216;experiments&#8217;
  * `To avoid datatype-related confusion, a uniform variable naming scheme was adopted in the tasks. For example, integers were named x, y, etc. and lists were named list1, list2, etc.`. As someone pretty used to Python, I would have found this annoying &#8211; but I&#8217;m curious what the effect of identifier names is in program comprehension. It also reminded me I haven&#8217;t written any code in a stronger typed language in a while (I don&#8217;t think Java counts)
  * They used Solarized Color Scheme, which has a lot of fans although I&#8217;ve never been one.
  * Lots of self-reporting for &#8216;programming proficiency&#8217;. This is the &#8216;we give up!&#8217; answer to measuring programming proficiency, I guess :)
  * `We gathered data from 10 graduate computer science students at the University of Cambridge.` This too seems fairly common, but I&#8217;ve no idea if such an un-diverse group of student group being studied affects the results at all?
  * They also discarded data from 3 of the students because they wore glasses and their eye-tracking hardware could not really deal with that. So this entire paper is from data from 7 students doing one particular course from one particular university. 
  * `We use the Shapiro-Wilk test to establish normality. We use the Wilcoxon signed rank test (WSRT) for paired nonparametric comparisons`. I know some of these words!
  * `As the data was not normally distributed, a 2-way ANNOVA could not be used to investigate the interaction of experience with highlighting on task times` I know _most_ of the words, but still can not make sense of this sentence.
  * Currently feeling very illiterate, but am sure this is just a feeling that will pass.
  * `. The median difference in task completion time was 8.4s in favour of highlighting.` To my untrained brain, that does not seem that much to me.
  * `The presence of syntax highlighting significantly reduces task completion time, but the magnitude of this effect decreases as programming experience increase` &#8211; this is their primary conclusion, which I can totally believe. But would I have believed it if they had come to a different conclusion? Would they have published it if it had? Would they have if there was more data? I don&#8217;t fully understand / know Academia enough to know.
  * I wonder if there has been research into richer forms of syntax highlighting &#8211; not just keyword based ones, but more contextual. Perhaps based on types (autodetected?), or scope, or usage frequency, or source, or whatever.

Overall, I enjoyed reading it &#8211; good paper! Thought provoking in some forms, but could&#8217;ve aimed higher, I suppose. I hope they continue doing good work!

 [1]: http://www.ppig.org/sites/default/files/2015-PPIG-26th-Sarkar.pdf