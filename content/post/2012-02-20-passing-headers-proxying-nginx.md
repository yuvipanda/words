---
title: Passing Headers along while Proxying with nginx
author: yuvipanda
type: post
date: 2012-02-20T20:23:35+00:00
url: /passing-headers-proxying-nginx/
aktt_notify_twitter:
  - yes
aktt_tweeted:
  - 1
dsq_thread_id:
  - 583363080
categories:
  - code

---
When you&#8217;re proxying requests via nginx, you might assume after reading [the documentation][1] that every header is forwarded, except for the Host and Connection headers.

You&#8217;d also be wrong.

nginx **drops** all headers with an underscore in them.

This is a configurable settings. You can turn it on with a simple

<pre>underscores_in_headers on</pre>

I&#8217;m still baffled as to \*why\* this is [a configuration parameter][2]. And why it is turned off by default. And why there is no mention of it in the proxy docs.

Thanks to `kolbyjack` on `#nginx` for helping me figure this out.

 [1]: http://wiki.nginx.org/HttpProxyModule\" data-mce-href=
 [2]: http://wiki.nginx.org/HttpCoreModule#underscores_in_headers