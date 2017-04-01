+++
date = "2017-03-31T23:23:52-07:00"
title = "systemd simple containment for GUI applications & shells"
tags = ["systemd", "learning", "code"]

+++

I earlier had [a vaguely working setup](http://words.yuvi.in/post/systemd-gui-applications/) for making sure browsers, shells and other applications don't eat all RAM / CPU on my machine with systemd + sudo + shell scripts. 

It was a hacky solution, and also had complications when used to launch shells. It wasn't passing in all the environment varialbes it should, causing interesting-to-debug issues. `sudo` rules were complex, and hard to do securely. 

I had also been looking for an excuse to learn more Golang, so I ended up writing [`systemd-simple-containment`](https://github.com/yuvipanda/systemd-simple-containment) or `ssc`.

It's a simple golang application that produces a binary that can be [`setuid`](https://en.wikipedia.org/wiki/Setuid) to `root`, and thus get around all our `sudo` complexity, at the price of having to be very, very careful about the code. Fortunately, it's short enough (~100 lines) and `systemd-run` helps it keep the following invariants:

1. It will never spawn any executable as any user other than the 'real' uid / gid of the user calling the binary.
2. It doesn't allow arbitrary systemd `properties` to be set, ensuring a more limited attack surface.

However, this is the first time I'm playing with setuid and with Go, so I probably fucked something up. I feel ok enough about my understanding of real and effective uids for now to use it myself, but not to recommend it to other people. Hopefully I'll be confident enough say that soon :)

By using a real programming language, I also easily get commandline flags for sharing tty or not (so I can use the same program for launching GUI & interactive terminal applications), pass all environment variables through (which can't be just standard child inheritence, since `systemd-run` doesn't work that way) & the ability to setuid (you can't do that easily to a script).

I was sure I'd hate writing go because of the constant `if err != nil` checks, but it hasn't bothered me that much. I would like to write more Go, to get a better feel for it. This code is too short to like a language, but I definitely hate it less :)

Anyway, now I can launch GUI applications with `ssc -tty=false -isolation=strict firefox` and it does the right thing. I currently have available `-isolation=strict` and `-isolation=relaxed`, the former performing stronger sandboxing (NoNewPrivileges, PrivateTmp) than the latter (just MemoryMax). i'll slowly add more protections here, but just keep two modes (ideally).

My Gnome Terminal shell command is now `ssc -isolation=relaxed /bin/bash -i` and it works great :) 

I am pretty happy with `ssc` as it exists now. Only thing I now want to do is to be able to use it from the GNOME launcher (I am using GNOME3 with gnome-shell). Apparently *shortcuts* are no longer cool and hence pretty hard to create in modern desktop environments :| I shall keep digging!
