---
title: Why I got rid of my fork of Waffle
author: yuvipanda
type: post
date: 2009-10-21T00:27:55+00:00
url: /why-i-got-rid-of-my-fork-of-waffle/
aktt_notify_twitter:
  - no
categories:
  - code

---
For those of you who didn&#8217;t know, [Waffle][1] is a [schemaless storage layer][2] that sits on top of SQLAlchemy. Something that I was initially very interested in.

Not anymore.

Why?

Because I found [MongoDB][3].

And fell in love.

Yes, I do know they both are different, but MongoDB has the things that attracted me to Waffle (very flexible schema, great querying, indexes) and is just as easy to set up (maybe not as easy as Waffle over SQLite, but only slightly less easier).

I <3 MongoDB. Let&#8217;s see how long this lasts!

 [1]: http://github.com/bickfordb/waffle
 [2]: http://bret.appspot.com/entry/how-friendfeed-uses-mysql
 [3]: http://www.mongodb.org/display/DOCS/Home