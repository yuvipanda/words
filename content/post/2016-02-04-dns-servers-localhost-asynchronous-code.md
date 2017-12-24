---
title: DNS servers, localhost and asynchronous code
author: yuvipanda
type: post
date: 2016-02-04T02:38:03+00:00
url: /dns-servers-localhost-asynchronous-code/
dsq_thread_id:
  - 4549800420
categories:
  - code

---
`localhost` is always `127.0.0.1`, right? Nope, can also be `::1` if your system only has IPV6 (apparently).

Asking a DNS server for an A record for `localhost` should give you back `127.0.0.1` right? Nope &#8211; it varies wildly! `8.8.8.8` gives me an `NXDOMAIN` which means it tells you straight up THIS DOMAIN DOES NOT EXIST! Which is true, since localhost isn&#8217;t a domain. But if you ask the same thing of any dnsmasq server, it&#8217;ll tell you localhost is 127.0.0.1. Other servers vary wildly &#8211; I found one that returned an `NXDOMAIN` for AAAA but 127.0.0.1 for A (which is pretty wild, since `NXDOMAIN` makes most software treat the domain as not existing and not attempt other lookups). So localhost and DNS servers don&#8217;t mix very well.

But why is this a problem, in general? Most DNS resolution happens via `gethostbyname` libc call, which reads `/etc/hosts` properly, right? Problem there is that there is popular software that&#8217;s completely asynchronous (_cough_nginx_cough_) that does _not_ use `gethostbyname` (since that&#8217;s synchronous) and directly queries DNS servers (asynchronously). This works perfectly well until you try to hit `localhost` and it tells you &#8216;no such thing!&#8217;.

I should probably file a bug with nginx to have them read `/etc/hosts` as well, and in the mean-time work around by sending `127.0.0.1` to nginx rather than localhost.

How did _your_ thursday go?