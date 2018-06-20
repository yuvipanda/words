+++
title = "The Littlest Jupyterhub"
date = 2018-06-18T13:14:59-07:00
categories = ["jupyter", "project-ideas"]
+++

This idea comes from brainstorming along with [Lindsey
Heagy](https://lindseyjh.ca/), [Carol
Willing](https://www.willingconsulting.com/), [Tim
Head](https://github.com/betatim) & [Nick
Bollweg](https://github.com/bollwyvl) at the Jupyter Team Meeting 2018. Most
of the good ideas are theirs! The name is inspired by [one of favorite TV
series](https://en.wikipedia.org/wiki/The_Littlest_Hobo) of one of my
favorite people.

I really love the idea of [JupyterHub](https://github.com/jupyterhub/jupyterhub) distributions - opinionated combination
of components that target a specific use case. The [Zero to JupyterHub](https://z2jh.jupyter.org)
distribution is awesome & works for most people. However, it requires
[Kubernetes](https://kubernetes.io) - a distributed system with inherent complexities that is not
worth it below a certain threshold.

This blog post lays out ideas for implementing a simpler, smaller distribution called
*The Littlest JupyterHub*. The Littlest JupyterHub serves [the long tail](https://en.wikipedia.org/wiki/Long_tail) of potential JupyterHub users
who have the following needs only.

1. Support a very small number of students (around 20–30, maybe 50) 
2. Run on only one node, either [a cheap VPS](http://digitalocean.com/) or a
   VM on their [favorite cloud provider](https://cloud.google.com)
3. Provide the same environment for all students 
4. Allow the instructor / admin to easily modify the environment for students with no specialized knowledge 
5. Be extremely low maintenance once set up & easily fixable when it breaks 
6. Allow easy upgrades 
7. Enforce memory / CPU limits for students

The target audience is primarily educators teaching small classes with
Jupyter Notebooks. It should be an extremely focused distribution, with new
feature requests facing higher scrutiny than usual. It has a legitimate
chance of actually reaching 1.0 & being stable, requiring minimal ongoing
upgrades! 

## JupyterHub setup 
JupyterHub +
[ConfigurableHTTPProxy](https://github.com/jupyterhub/configurable-http-proxy)
run as standard [systemd services](https://www.freedesktop.org/software/systemd/man/systemd.service.html).
[Systemd spawner is used](https://github.com/jupyterhub/systemdspawner) - it is lightweight, allows JupyterHub
restarts without killing user servers & provides CPU / memory isolation.

Something like [First Use
Authenticator](https://github.com/yuvipanda/jupyterhub-firstuseauthenticator)
+ a user whitelist might be good enough for a large number of users. New
authenticators are added whenever users ask for them.

The JupyterHub system is in its own root owned conda environment or
virtualenv, to prevent accidental damage from users.

## User environment 

There is a single
conda environment shared by all the users. JupyterHub admins have
write access to this environment, and everyone else has read access. Admins
can install new libraries for all users with conda/pip. No extra steps
needed, and you can do this from inside JupyterHub without needing to ssh.

Each user gets their own home directory, and can install packages there if
they wish. systemdspawner puts each user server in a systemd service, and
provides [fine grained
control](https://www.freedesktop.org/software/systemd/man/systemd.resource-control.html)
over memory & cpu usage. Users also get their own system user, providing an
additional layer of security & standardized home directory locations.

## Configuration 

[YAML](http://yaml.org/) is used for config - it is the
least bad of all the currently available languages, IMO. Ideally, something
like the [`visudo`](https://www.sudo.ws/man/1.8.17/visudo.man.html) command
would exist for editing & applying this config. It'll
open the config file in an editor, allow users to edit it, and apply it only
if it is valid. Advanced users can sidestep this and edit files directly. The
YAML file is read and processed directly in `jupyterhub_config.py`. This
simplifies things & gives us fewer things to break. 

## Upgrading the distribution 

Backwards compatible upgrading will be supported across one
minor version only - so you can go from 0.7 to 0.8, but not 0.9. Upgrades
should not cause outages. 

## Installation mechanism 
Users run a command on a fresh server to install this distribution. This could use
conda constructor (thanks to Nick Bollweig & [Matt
Rocklin](http://matthewrocklin.com/) for convincing me!)
or debian packages (with fpm or dh-virtualenv). The user environments will be
[conda environments](https://conda.io/). 

A `curl <some-url> | sudo bash` command is available in a
nice looking website for the distribution that users can copy paste into
their fresh VM. This website also has instructions for creating a fresh VM in
popular cloud providers & VPS providers. 

## Debuggability 

All systems exist in a partially degraded state all the time. Good systems
self-heal & continue to run as well as they can. When they can't, they break
cleanly in known ways. They are observable enough to debug the issues that
cause 80% of the problems.

The Littlest JupyterHub should be a good system. Systemd captures
logs from JupyterHub, user servers & the proxy. Strong validation of the
config file catches fatal misconfigurations. Reboots actually fix most issues
and never make anything worse. Screwed up user environments are recoverable.

We'll discover how this breaks as users of varying skill levels use it, and
update our tooling accordingly. 

## But, No Docker? 

Docker has been explicitly excluded from this tech stack. Building custom
docker images & dealing with registries is too complex most educators. A good
distribution embraces its constraints & does well!

## Contribute

Are you a person who would use a distribution like this? We would love to
hear from you! Make an issue [on GitHub](https://github.com/yuvipanda/the-littlest-jupyterhub), 
[tweet at me](https://twitter.com/yuvipanda), or send me [an email](mailto:yuvipanda@gmail.com).