---
title: 'Side Project: UA Emoji Firefox Extension'
author: yuvipanda
type: post
date: 2016-03-28T05:29:05+00:00
url: /side-project-ua-emoji-firefox-extension/
dsq_thread_id:
  - 4698837348
categories:
  - code

---
_Note: I&#8217;m trying to spend time explicitly writing random side projects that are not related to what I&#8217;m actively working on as my main project in some form._

A random thread started by [Ironholds][1] on a random mailing list I was wearily catching up on contained a joke from [bearloga][2] about malformed User Agents. This prompted me to write [UAuliver][3] ([source][4]), a Firefox extension that randomizes your user agent to be a random string of emoji. This breaks a surprisingly large number of software, I&#8217;m told! (GMail & Gerrit being the ones I explicitly remember)

Things I learnt from writing this:

  1. Writing Addons for Firefox is far easier to get started with than they were the last time I looked. Despite the confusing naming (Jetpack API == SDK != WordPress&#8217; Jetpack API != Addons != Plugins != WebExtension), the documentation and tooling were nice enough that I could finish all of this in a few hours!
  2. I can still write syntactically correct Javascript! \o/
  3. Generating a &#8216;string of emoji&#8217; is easier/harder than you would think, depending on how you would like to define &#8217;emoji&#8217;. The fact that Unicode deals in blocks that at least in this case aren&#8217;t too split up made this quite easy (I used the [list][5] on Wikipedia to generate them). JS&#8217;s [String.fromCodePoint][6] can also be used to detect if the codepoint you just generated randomly is actually allocated. 
  4. I don&#8217;t actually know how HTTP headers deal with encoding and unicode. This is something I need to actually look up. Perhaps a re-read of the HTTP RfC is in order!

It was a fun exercise, and I might write more Firefox extensions in the future!

 [1]: https://twitter.com/quominus
 [2]: https://twitter.com/bearloga
 [3]: https://addons.mozilla.org/en-US/firefox/addon/uauliver/?src=search
 [4]: https://github.com/yuvipanda/uauliver-firefox-extension
 [5]: https://en.wikipedia.org/wiki/Emoji#Unicode_blocks
 [6]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/fromCodePoint