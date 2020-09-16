---
title: Setting up a "Production Ready" TLJH
date: 2020-09-16T17:09:42+05:30
tags: ["jupyter", "opensource"]
---

[The Littlest JupyterHub](http://tljh.jupyter.org/) is an extremely
capable hub distribution that I'd recommend for situations where you
expect, on average, under 100 active users. 


## Why not Kubernetes?

The primary reason to use Zero to JupyterHub on k8s over TLJH in cases with smaller
number of users would be to reduce costs - Kubernetes can spin down nodes when
not in use. However, you'll always have at least one node running - for the hub
/ proxy pods. The extra complexity that comes with it is not worth it - particulary
around needing to build your own docker images - is not worth it. TLJH works perfectly
well for these cases!

## What is 'production'?

A JupyterHub that you can run itself securely without lots of intervention
from the person who created it is what I'll call a *production-ready* JupyterHub.
It's a pretty arbitrary standard. In this blog post, I'll lay out what **I** want
in the TLJH hubs I run before I let users on them.

## Authentication

Uses a *real* [Authenticator](https://tljh.jupyter.org/en/latest/howto/index.html#authentication),
not the default `FirstUseAuthenticator`. The default authenticator is pretty insecure,
and should really not be used. If you don't know what to use, I'll suggest the Google or
GitHub authenticators.
   
## HTTPS

Enable [HTTPS](https://tljh.jupyter.org/en/latest/howto/admin/https.html). An absolute
requirement, TLJH makes it quite easy. You *do* need to get a domain for this to work,
which can be a source of friction. Totally worth it, and many authenticators require
this too.
   
## Resource Limits

In many systems, a single user can often write code that accidentally crashes the whole system.
By default, TLJH protects against this by enforcing [memory limits](https://tljh.jupyter.org/en/latest/topic/tljh-config.html#user-server-limits).
I think the default is a 1G limit, but you should tune it to fit your own users. TLJH
has more documentation on [how to estimate your VM size]()
based on your expected usage patterns.

## Sizing your VM correctly

If you choose a VM that's too big, you'll end up spending a lot of cash for unused
resources. If it's too small, your users will not have the resources they need to
do their work. TLJH provides [some helpful docs](https://tljh.jupyter.org/en/latest/howto/admin/resource-estimation.html) 
estimating your VM size, and you can always [resize](https://tljh.jupyter.org/en/latest/howto/admin/resize.html)
your VM afterwards if you get it wrong.

## Disk backups

TLJH contains everything on the VM's disk - your user environment, users' home directories,
current hub configuration, etc. It is very important you back this up, to recover in case
of disasters. Automated disk snapshots from your cloud provider are an easy way to do this.
Most major cloud providers offer a way to do this - [Google Cloud](https://cloud.google.com/compute/docs/disks/create-snapshots),
[Digital Ocean](https://www.digitalocean.com/docs/images/snapshots/), [AWS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EBSSnapshots.html),
etc. Some let you automate it as well - Google & AWS certainly do, I'm not sure about other
clodu providers. This isn't the *best* way to do backup - there's approximately
1 billion ways to do so. However, this is an absolute minimum, and it might just be enough.

If you want to be more fancy, I'd suggest using a separate disk / volume for your user home
directories, possibly on [ZFS](https://wiki.ubuntu.com/ZFS), and snapshot much more
aggressively. Talk to your nearest google search bar for your options.

## Pin your public IP

Some cloud providers often your VM's public IP address if you start / stop them. This
can be pretty bad - you'll have to change your domain's DNS entry, and re-aquire HTTPS.
A hassle! You can tell your cloud provider to hang on to your IP even if your VM
goes down / changes. And you should! DigitalOcean doesn't require this,
but [google does](https://cloud.google.com/compute/docs/ip-addresses/reserve-static-external-ip-address).
I think AWS does too, but I'm not sure how you can reserve the public IP for it -
since it's usually a domain name itself.

## Base environment setup + snapshot

TLJH has a shared conda environment that is used by *all* users. Everyone can read
from it, but only users who are `admin` can write to it (via `sudo`). This is one of
TLJH's core design tradeoffs - admins can install packages the way they are used to,
without requiring a separate image-build step. But it also means the admin can mess
it up - conda environments can be sometimes fickle! So it's not a bad idea to
spend some time in the beginning setting everything up - python packages,
JupyterLab extensions, etc. Then make a disk snapshot, so you can revert to it
if things go bad (this is where having a separate disk for your user home
directories comes in handy). 

## SSH admin access

The TLJH documentation strives hard to make sure SSH isn't *required* for setup and
most common usage. However, if your TLJH breaks in certain ways, you can no longer
access the machine - since all access is via TLJH! For this, I recommend making sure
someone who is admin has SSH access to the VM. Most cloud providers offer a way to
set the root ssh key on creation. If not, you can follow the many guides on the internet
to making it happen.

You can also just put your ssh keys in `$HOME/.ssh/authorized_keys`, and ssh in as
`jupyter-<username>@<hub-ip>`. This works for any / all users!

## Others?

I'm sure this isn't the end - probably need something about firewalls, monitoring and automated
system package upgrades. But hey, great start!
