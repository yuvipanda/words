---
title: Vala, GTKBuilder and Autoconnecting Signal Handlers
author: yuvipanda
type: post
date: 2010-05-30T02:22:41+00:00
url: /vala-gtkbuilder-and-autoconnecting-signal-handlers/
aktt_notify_twitter:
  - no
dsq_thread_id:
  - 526554945
categories:
  - code

---
**Note**: I&#8217;m not an expert on Vala, GTK+, or anything else for that matter. If I am off base someplace, comment.

I spent quite a some time today trying to get GTKBuilder to automagically connect all my signals to their handlers. I tripped up at a few places, and so recording them here for posterity.

  1. If you are using instance methods (like most of us are), you&#8217;ve to decorate your handler function with the attribute `[CCode (instance_pos=-1)]`. This makes sure that the function is passed the `this` pointer as last argument, rather than first. You&#8217;ve to do this because `Builder.connect_signals` passes the instance as last parameter (`user_data`), and by aligning your `this` pointer with `user_data`, you make sure the correct instance is called.

  2. Make sure your handler function signature matches what is expected. Ignore the `user_data` parameter of most signals &#8211; it is used internally by `Builder.connect_signals` (see above point).

  3. Make sure you pass `--pkg gmodule-2.0` to your `valac`. If you&#8217;re using Autotools, this means you pass it to `VALAFLAGS`.

  4. sure your C compiler is called with `-dynamic-export`. I&#8217;m told this enabled support for `dlopen` in the binary produced.

  5. Mangle your names properly. `Cheese.MainWindow.on_quit()` becomes `cheese_main_window_on_quit` on C, and that is what GTKBuilder expects. If you are not sure how your function name is mangled by `valac`, checkout the generated `.c` file.

If you do all these 5 things right and you&#8217;re still having trouble, turn up on #vala at irc.gimp.net and ask the helpful folks there :)