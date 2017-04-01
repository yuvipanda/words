+++
date = "2017-03-29T20:47:10-07:00"
title = "systemd gui applications"
tags = ["systemd", "learning", "code"]

+++
**Update**: There's a [follow-up post](//words.yuvi.in/post/systemd-simple-containment/) with a simpler solution now.

Ever since I read [Jessie Frazelle](https://blog.jessfraz.com)'s amazing setup[1](https://blog.jessfraz.com/post/ultimate-linux-on-the-desktop/)[2](https://blog.jessfraz.com/post/docker-containers-on-the-desktop/)[3](https://blog.jessfraz.com/post/runc-containers-on-the-desktop/) for running GUI applications in docker containers, I've wanted to do something similar. However, I want to install things on my computer - not in docker images. So what I wanted was just isolation (no more Chrome / Firefox freezing my laptop), not images. I'm also not as awesome (or knowledgeable!) as Jess, so will have to naturally settle for less...

So I am doing it in systemd!

Before proceeding, I want to warn y'all that I don't entirely know what I am doing. Don't take any of this as security advice, since I don't entirely understand X's security model. Works fine for me though!

## GUI applications ##

I started out using a simple systemd [templated service](https://fedoramagazine.org/systemd-template-unit-files/) to launch GUI applications, but soon realized that [systemd-run](https://www.freedesktop.org/software/systemd/man/systemd-run.html) is probably the better way. So I've a simple script, `/usr/local/bin/safeapp`:

```bash
#!/bin/bash
exec sudo systemd-run  \
    -p CPUQuota=100% \
    -p MemoryMax=70% \
    -p WorkingDirectory=$(pwd) \
    -p PrivateTmp=yes \
    -p NoNewPrivileges=yes \
    --setenv DISPLAY=${DISPLAY} \
    --setenv DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS} \
    --uid ${USER} \
    --gid ${USER} \
    --quiet \
    "$1"
```

I can run `safeapp /opt/firefox/firefox` now and it'll start firefox inside a nice systemd unit with a 70% Memory usage cap and CPU usage of at most 1 CPU. There's also other minimal security stuff applied - `NoNewPrivileges` being the most important one. I want to get `ProtectSystem` + `ReadWriteDirectories` going too, but there seems to be a bug in `systemd-run` that doesn't let it parse `ProtectSystem` properly...

Also, there's [an annoying bug](https://github.com/systemd/systemd/issues/3851) in systemd v231 (which is what my current system has) - you can't set `CPUQuotas` over 100% (aka > 1 CPU core). This is annoying if you want to give each application 3 of your 4 cores (which is what I want). Next version of Ubuntu has v232, so my GUI applications will just have to do with an aggregate of 1 full core until then.

The two environment variables seem to be all that's necessary for X applications to work.

And yes, this might ask you for your password. I'll clean this up into a nice non-bash script hopefully soon, and make all of these better.

Anyway, *it works*! I can now open sketchy websites with scroll hijacking without fear it'll kill my machine! 

## CLI ##

I wanted each tab in my terminal to be its own systemd service, so they all get equitable amount of  CPU time & can't crash machine by themselves with OOM. 

So I've this script as `/usr/local/bin/safeshell`

```bash
`#!/bin/bash
exec sudo systemd-run \
    -p CPUQuota=100% \
    -p MemoryMax=70% \
    -p WorkingDirectory=$(pwd) \
    --uid yuvipanda \
    --gid yuvipanda \
    --quiet \
    --tty \
    /bin/bash -i
```

The `--tty` is magic here, and does the right things wrt passing the tty that GNOME terminal is passing in all the way to the shell. Now, my login command (set under profile preferences > command in gnome-terminal) is `sudo /usr/local/bin/safeshell`. In addition, I add the following line to `/etc/sudoers`:

```
%sudo ALL = (root) NOPASSWD:SETENV: /usr/local/bin/safeshell
```

This + just specifying the username directly in `safeshell` are both hacks that make me cringe a little. I need to either fully understand how sudo's `-E` works, or use this as an opportunity to learn more Go and make a setuid binary.

## To do ##

[ ] Generalize this to not need hacks (either with better sudo usage or a setuid binary)
[ ] Investigate adding more security related options.
[ ] Make these work with desktop / dock icons.

I'd normally have just never written this post, on account of 'oh no, it is imperfect' or something like that. However, that also seems to have come in the way of ability to find joy in learning simple things :D So I shall follow [b0rk](https://jvns.ca/)'s lead in spending time [learning](http://words.yuvi.in/post/things-to-learn/) for fun again :)
