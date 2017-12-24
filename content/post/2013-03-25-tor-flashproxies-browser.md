---
title: Tor Flashproxies on your browser
author: yuvipanda
type: post
date: 2013-03-25T14:34:57+00:00
url: /tor-flashproxies-browser/
content_columns:
  - 1
dsq_thread_id:
  - 1163656339
categories:
  - code
  - links

---
Tor is one of those things that you don&#8217;t really need at all until you really really need it. I don&#8217;t need it right now, but I still try to help it as much as possible. One of the easiest way to do so is to run a [flashproxy][1] (has nothing to do with Adobe!) on your browser &#8211; super simple to setup, and effective for people looking for [bridges][2].

The easiest way to use it if you&#8217;re a Chrome user is to use the [CupCake][3] extension (the initial colorscheme is a bit&#8230; geocities-y, but I&#8217;ve sent in [a patch][4] to fix that). You can also add [this snippet][5] to your Mediawiki wiki either as a userscript or gadget. If you&#8217;re running a site, you can simply use [the snippet on the flashproxy site][6] to have it run for all your visitors.

 [1]: https://crypto.stanford.edu/flashproxy
 [2]: https://www.torproject.org/docs/bridges
 [3]: https://chrome.google.com/webstore/detail/cupcake/dajjbehmbnbppjkcnpdkaniapgdppdnc
 [4]: https://github.com/glamrock/cupcake/pull/1
 [5]: https://gitweb.torproject.org/flashproxy.git/blob/HEAD:/modules/mediawiki/custom.js
 [6]: https://crypto.stanford.edu/flashproxy/#badge-howto