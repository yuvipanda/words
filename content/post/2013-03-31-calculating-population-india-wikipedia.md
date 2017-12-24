---
title: Calculating the population of India on Wikipedia
author: yuvipanda
type: post
date: 2013-03-31T01:47:40+00:00
url: /calculating-population-india-wikipedia/
content_columns:
  - 1
dsq_thread_id:
  - 1176224902
categories:
  - links
  - wiki

---
Exploring the English Wikipedia randomly, I encountered [this template][1] used to approximate the current live population of India. It uses the following simple formula:

> <pre>(1176242 + 42.197260273969 * days_since(2010,1,26)) * 000</pre>

It&#8217;s based on population at a specific data + projected growth. The &#8216;update&#8217; is done by (best guess) some bot hitting [action=purge][2] every night to re-do the calculation. 

And where is this used? After looking at the template&#8217;s [info page][3], the only article this seems to be used in is the India article, and that too only for population density statistics, rather than actual population statistics. Weird, since if Density can be calculated based on projection, I guess population could be too.

The machinations that people invent on Wikipedia are very fascinating! I hope to discover more over time. If you&#8217;ve suggestions on places for me to look (please, no [WPBannerMeta][4] / associated templates!), leave comments!

 [1]: https://en.wikipedia.org/wiki/Template:Indian_population_clock
 [2]: https://www.mediawiki.org/wiki/Manual:Purge
 [3]: https://en.wikipedia.org/wiki/Template:Indian_population_clock?action=info
 [4]: https://en.wikipedia.org/wiki/Template:WPBannerMeta