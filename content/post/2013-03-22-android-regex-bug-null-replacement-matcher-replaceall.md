---
title: 'Android RegEx bug: ‘null’ replacement with Matcher.replaceAll'
author: yuvipanda
type: post
date: 2013-03-22T22:18:21+00:00
url: /android-regex-bug-null-replacement-matcher-replaceall/
aktt_notify_twitter:
  - no
mkd_text:
  - |
    Android's [Regular Expressions][1] engine is API compatible with the generic Java implementation, but under the hood uses [ICU's RegEx engine][2]. This usually causes no problems, until it does and then you're sortof fucked, but not really.
    
    On a recent project, a subtle bug in Android's `Matcher.replaceAll` behavior bit me. When replacing values of captured groups (`$1', `$2', etc), Android's implementation replaced a reference to an empty group with the literal string `'null'` instead of just skipping it (aka replacing with empty string `''`), which is what most other Java implemetations do. The string `'null'` is, I think, *never* the right behavior in this case. And the inconsistency causes unit tests to pass when run on the desktop JRE to fail when run in Android, which is a major pain.
    
    Fortunately Android is Open Source, and I was able to track down the [offending piece of code][3], and just write myself a simple replacement that has the bug fixed:
    
    https://gist.github.com/yuvipanda/5225151
    
    You're welcome. Yay Open Source!
    
    [1]: https://developer.android.com/reference/java/util/regex/Pattern.html
    [2]: http://userguide.icu-project.org/strings/regexp
    [3]: http://grepcode.com/file/repository.grepcode.com/java/root/jdk/openjdk/6-b14/java/util/regex/Matcher.java#Matcher.replaceAll%28java.lang.String%29
dsq_thread_id:
  - 1157836772
categories:
  - code

---
Android&#8217;s [Regular Expressions][1] engine is API compatible with the generic Java implementation, but under the hood uses [ICU&#8217;s RegEx engine][2]. This usually causes no problems, until it does and then you&#8217;re sortof fucked, but not really.

On a recent project, a subtle bug in Android&#8217;s `Matcher.replaceAll` behavior bit me. When replacing values of captured groups (`'$1'</code,<code>'$2'`, etc), Android&#8217;s implementation replaced a reference to an empty group with the literal string `'null'` instead of just skipping it (aka replacing with empty string `''`), which is what most other Java implemetations do. The string `'null'` is, I think, _never_ the right behavior. And the inconsistency causes unit tests to pass when run on the desktop JRE to fail when run in Android, which is a major pain.

Fortunately Android is Open Source, and I was able to track down the [offending piece of code][3], and just write myself [a simple replacement][4] that has the bug fixed:

<noscript>
  <p>
    View the code on <a href="https://gist.github.com/5225151">Gist</a>.
  </p>
</noscript>

You&#8217;re welcome. Yay Open Source!

 [1]: https://developer.android.com/reference/java/util/regex/Pattern.html
 [2]: http://userguide.icu-project.org/strings/regexp
 [3]: http://grepcode.com/file/repository.grepcode.com/java/root/jdk/openjdk/6-b14/java/util/regex/Matcher.java#Matcher.replaceAll%28java.lang.String%29
 [4]: https://gist.github.com/yuvipanda/5225151