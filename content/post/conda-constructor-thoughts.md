+++
title = "Conda Constructor Thoughts"
date = 2018-06-28T22:43:56-07:00
categories = ["code"]
+++

Inspired by conversations with [Nick Bollweg](https://github.com/bollwyvl) and
[Matt Rocklin](http://matthewrocklin.com/), I experimented with using
[conda constructor](https://github.com/conda/constructor) as the installer for
[The Littlest JupyterHub](http://words.yuvi.in/post/the-littlest-jupyterhub/).
Theoretically, it fit the bill perfectly - I wanted a way to ship arbitrary
packages in multiple languages (python & node) in an easy to install self-contained way,
didn't want to make debian packages & wanted to use a tool that people in the Jupyter
ecosystem were familiar with. Constructor seemed to provide just that.

I sortof got it working, but in the end ran into enough structural problems that
I decided it isn't the right tool for this job. This blog post is a note to my
future self on *why*.

This isn't a 'takedown' of conda or conda constructor - just a particular
use case where it didn't work out and a demonstration of how little I know
about conda. It probably works great if you are doing more scientific computing
and less 'ship a software system'!

## Does not work with `conda-forge`

I <3 [conda-forge](https://conda-forge.org/) and the community around
it. I know there's a nice [jupyterhub](https://anaconda.org/conda-forge/jupyterhub)
package there, which takes care of installing JupyterHub, node, and required
node modules.

However, this doesn't actually work. conda constructor does not support
[noarch packages](https://www.anaconda.com/blog/developer-blog/condas-new-noarch-packages/),
and JupyterHub relies on several `noarch` packages. From my understanding,
more `conda-forge` packages are moving towards being `noarch` (for good reason!).

Looking at [this issue](https://github.com/conda/constructor/issues/86),
it doesn't look like this is a high priority item for them to fix anytime soon.
I understand that - they don't owe the world free work! It just makes conda
constructor a no-go for my use case...

## No support for pip

You can pip install packages in a conda environment, and they mostly just work.
There are a *lot* of python packages on PyPI that are installable via pip that
I'd like to use. constructor doesn't support bundling these, which is entirely
fair! [This PR](https://github.com/conda/constructor/pull/96) attempted something
here, but was rejected.

So if I want to keep using packages that don't exist in `conda-forge` yet but
do exist in pip, I would have to make sure these packages and all their dependencies
exist as conda packages too. This would be fine if constructor was giving
me enough value to justify it, but right now it is not. I've also tried going
down a similar road (*cough* debian *cough*) and did not want to do that again :)

## Awkward `post-install.bash`

I wanted to set up systemd units post install. Right off the bat this should
have made me realize conda constructor was not the right tool for the job :D
The only injected environment variable is `$PREFIX`, which is not super helpful
if you wanna do stuff like 'copy this systemd unit file somewhere'. I ended up
writing a small python module that does all these things, and calling it from
post-install. However, even then I couldn't pass any environment variables to it,
making testing / CI hard.

## Current solution

Currently, we have a [bootstrap script](https://github.com/yuvipanda/the-littlest-jupyterhub/blob/9cc05a9d627515a01b68e244a970079481be7d9e/installer/install.bash)
that downloads miniconda, & bootstraps from there to a full JupyterHub install.
Things like systemd units & sudo rules are managed by a [python module](https://github.com/yuvipanda/the-littlest-jupyterhub/tree/9cc05a9d627515a01b68e244a970079481be7d9e/tljh)
that is called from the bootstrap script.
