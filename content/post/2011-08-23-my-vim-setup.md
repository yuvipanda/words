---
title: My Vim setup
author: yuvipanda
type: post
date: 2011-08-23T22:55:03+00:00
url: /my-vim-setup/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 394241004
categories:
  - code
tags:
  - code

---
I [moved][1] from emacs to vim a while ago, and have been steadily accumulating a series of plugins in my `.vim`. They&#8217;re all up in my rather messy [dotfiles repo][2]. Here&#8217;s a slightly more neatly organized list of the plugins I currently use:

  1. [command-t][3] &#8211; File opener and buffer switcher. In-fuckin-credibly useful.
  2. [vimpress][4] &#8211; What I use to blog since [moving to wordpress][5].
  3. [matchit][6] &#8211; Lets `%` work with html tags
  4. <s>[commentary][7] &#8211; Generic commenting and uncommenting script</s> [NERDCommenter][8] has replaced commentary due to being more flexible and having more options.
  5. [fugitive][9] &#8211; Incredibly awesome git wrapper for vim. I rarely go to the commandline for git these days
  6. [tagbar][10] &#8211; Useful code-exploratory plugin when I&#8217;m looking around a codebase trying to familiarize myself.
  7. [supertab][11] &#8211; Buffer completion in insert mode only when I need it.
  8. [gist][12] &#8211; Put stuff up in gist to pass it around
  9. [BufClose][13] &#8211; So I can close a buffer without messing up my splits
 10. [extradite][14] &#8211; `:Glog` replacement that builds on top of fugitive. I don&#8217;t understand why this isn&#8217;t bundled with fugitive
 11. [TwitVim][15] &#8211; Yes, so I don&#8217;t have to go to the browser (and be consumed by chat/reddit/hn) just to post a tweet.
 12. [ack.vim][16] &#8211; Ack integration for vim. Do yourself a favor and use [ack][17] instead of grep.
 13. [Syntastic][18] &#8211; Automatic syntax checking so that I don&#8217;t miss a semicolon and not know about it
 14. [php-doc][19] &#8211; Insert boilerplate PHP doc compatible strings in my PHP files whenever I want to. Very PHP specific, need to find something that works across languages. (Note: This plugin has quite some identity crisis. It&#8217;s named PDV but it&#8217;s filename is php-doc. Since php-doc is more descriptive, I&#8217;m using that)
 15. [delimitMate][20] &#8211; Automatically closes quotes, parens, braces, etc for you. I initially thought this would be super annoying, but in fact it is rather very pleasant.

<s>I&#8217;m also on the default `desert` color theme &#8211; haven&#8217;t found anything better. Suggestions welcome &#8211; both for the color scheme and for new/replacement plugins.</s> After trying out [wombat][21] and [jellybeans][22] color schemes, I have settled on wombat for now. 

Suggestions for more plugins still welcome :)

<s>This is the list as of 24 Aug 2011.</s> <s>Updated as of September 2 2011 (added 10, 11, 12 since last update).</s> <s>Updated as of September 5 2011 (changed 4, added colorscheme change).</s> Updated as of September 12 2011 (added 13, 14, 15). I am moving quite fast, am I not? Will keep this post updated as and when things change.

<!-- #VIMPRESS_TAG# http://yuvi.in/blog/wp-content/uploads/2011/09/wpid190-vimpress_4e542fc3_mkd.txt wpid190-vimpress_4e542fc3_mkd.txt -->

 [1]: http://yuvi.in/blog/moving-to-vim-from-emacs.html
 [2]: http://github.com/yuvipanda/dotfiles
 [3]: http://www.vim.org/scripts/script.php?script_id=3025
 [4]: http://www.vim.org/scripts/script.php?script_id=1953
 [5]: http://yuvi.in/blog/moving-back-to-wordpress/
 [6]: http://www.vim.org/scripts/script.php?script_id=39
 [7]: http://www.vim.org/scripts/script.php?script_id=3695
 [8]: http://www.vim.org/scripts/script.php?script_id=1218
 [9]: http://www.vim.org/scripts/script.php?script_id=2975
 [10]: http://www.vim.org/scripts/script.php?script_id=3465
 [11]: http://www.vim.org/scripts/script.php?script_id=1643
 [12]: http://www.vim.org/scripts/script.php?script_id=2423
 [13]: http://www.vim.org/scripts/script.php?script_id=559
 [14]: http://www.vim.org/scripts/script.php?script_id=3509
 [15]: http://www.vim.org/scripts/script.php?script_id=2204
 [16]: http://www.vim.org/scripts/script.php?script_id=2572
 [17]: http://betterthangrep.com
 [18]: http://www.vim.org/scripts/script.php?script_id=2736
 [19]: http://www.vim.org/scripts/script.php?script_id=1355
 [20]: http://www.vim.org/scripts/script.php?script_id=2754
 [21]: http://www.vim.org/scripts/script.php?script_id=1778
 [22]: http://www.vim.org/scripts/script.php?script_id=2555