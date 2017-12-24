---
title: Non-ASCII Characters in HTTP Headers
author: yuvipanda
type: post
date: 2011-08-13T00:56:10+00:00
url: /non-ascii-characters-http-headers/
aktt_notify_twitter:
  - no
aktt_tweeted:
  - 1
dsq_thread_id:
  - 384535188
categories:
  - code
tags:
  - code

---
I was debugging an issue [at work][1] today where a (generated) file refused to download in Chrome, but the same URL worked just fine with wget. I remember reading in the [HTTP Spec][2] that HTTP headers can only be lower ASCII, so when wget mangled the output file&#8217;s name, the problem was obvious &#8211; the file name contained a character that wasn&#8217;t in lower ASCII (an accented A). Chrome had borked on encountering it, while wget soldiered on. Using `iconv` to strip non-ASCII characters in the file name on the server side fixed the issue.

Moral of the story? Read the RFCs! The [HTTP one][3], in particular, is remarkably readable and you _should_ read it if you&#8217;re doing non-trivial Web Development.

P.S: If I had had time, I&#8217;d have went around testing this behavior in several user agents and documenting their behavior (and possibly submitting bug reports) &#8211; but <insert-excuse-here>.

&nbsp;

 [1]: http://interviewstreet.com
 [2]: http://www.w3.org/Protocols/rfc2616/rfc2616-sec2.html#sec2.2
 [3]: http://www.w3.org/Protocols/rfc2616/rfc2616.html