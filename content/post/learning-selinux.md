+++
date = "2017-04-18T00:01:26-07:00"
title = "learning selinux and apparmor"
tags = ["learning","linux"]

+++

I am trying to understand SELinux and AppArmor, and collecting resources here as I learn. k

## SELinux for mere mortals (2014)

<iframe width="560" height="315" src="https://www.youtube.com/embed/MxjenQ31b70" frameborder="0" allowfullscreen></iframe>

This was the first video I watched, and it helped me understanding what SELinux does at a fundamental basic level. It's probably useless in a container-filled world (where I doubt Fedora shipes pre-configured SELinux rules for my containers), but it helped me think I understood types / labels, so that seems like a positive step?

The fact the presenter keeps saying things like 'you being a good sysadmin, ssh into the server and edit the apache config file' is freakin me out. If I'm constantly editing config files on servers manually that seems like a massive failure to me :D How times change!

## Docker and SELinux (2014)

<iframe width="560" height="315" src="https://www.youtube.com/embed/zWGFqMuEHdw" frameborder="0" allowfullscreen></iframe>

This one made a lot more sense to me as an answer to the following questions:

1. Aren't containers secure enough? (Partial answer)
2. What does SELinux do for container security?

It's convinced me that container -> host isolation and container <-> container isolation provided by SELinux is pretty simple and super useful, and should be turned on.

This talk also showed me this most wonderful [coloring book](https://people.redhat.com/duffy/selinux/selinux-coloring-book_A4-Stapled.pdf) that tries to explain SELinux. If this is all that is to SELinux, it seems pretty simple and useful (for the container use case).

Also, it looks like there are more recent versions of both these two talks - I should look 'em up!

## Securing Linux Applications with AppArmor (2007?)

<iframe width="560" height="315" src="https://www.youtube.com/embed/0l21FN81je0" frameborder="0" allowfullscreen></iframe>

This is me trying to understand AppArmor, which seems to have lower base of support (just Ubuntu? Maybe SUSE, but idk anyone who uses SUSE) but theoretically simpler (mostly file path based). The video seems to be shot with a potato, so the slides aren't super clear - but the content is good enough to give me a super general overview.

The biggest thing against SELinux it talks about seems to be 'SELinux is complex', and not much else. I don't know how much I buy that - but then again, I haven't actually *used* SELinux anywhere :D

Unlike SELinux, I can actually see AppArmor rules on my local machine (since it is running Ubuntu). Seems fairly readable!
