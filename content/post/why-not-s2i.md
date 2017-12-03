+++
date = "2017-12-03T01:23:54-08:00"
title = "Why repo2docker? Why not s2i?"
tags = ["binder", "code"]

+++

![https://xkcd.com/927/](https://imgs.xkcd.com/comics/standards.png)

The wonderful [Graham Dumpleton](https://twitter.com/GrahamDumpleton) asked [on twitter](https://twitter.com/GrahamDumpleton/status/936740552304836608) why we built an entirely new tool ([repo2docker](https://github.com/jupyter/repo2docker)) instead of using OpenShift's cool [source2image](https://github.com/openshift/source-to-image) tool.

This is a very good question, and not a decision we made lightly. This post lays out some history, and explains the reasons we decided to stop using s2i. s2i is still a great tool for most production use cases, and you should use it if you're building anything like a PaaS! 

## Terminology 

Before discussing, I want to clarify & define the various projects we are talking about.

1. [s2i](https://github.com/openshift/source-to-image) is a nice tool from the [OpenShift](http://openshift.org/) project that is used to build images out of git repositories. You can use heroku-like buildpacks to specify how the image should be built. It's used in OpenShift, but can also be easily used standalone.
2. [BinderHub](https://github.com/jupyterhub/binderhub) is the UI + scheduling component of Binder. This is what you see when you go to https://mybinder.org
3. [repo2docker](https://github.com/jupyter/repo2docker) is a standalone python application that takes a git repository & converts it into a docker image containing the environment that is specified in the repository. This heavily overlaps with functionality in s2i.

## When repo2docker just wrapped s2i...

When we started building [BinderHub](https://github.com/jupyterhub/binderhub), I looked around for a good heroku-like 'repository to container image' builder project. I first looked at Deis' [slugbuilder](https://github.com/deis/slugbuilder) and [dockerbuilder](https://github.com/deis/dockerbuilder) - they didn't quite match our needs, and seemed a bit tied into Deis. I then found OpenShift's [source2image](https://github.com/openshift/source-to-image), and was very happy! It worked pretty well standalone, and `#openshift` on IRC was very responsive. 

So until July 1, we actually used s2i under the hood! `repo2docker` was a wrapper that performed the following functions:

1. Detect which s2i buildpack to use for a given repository
2. Support building arbitrary Dockerfiles (s2i couldn't do this)
3. Support the Legacy Dockerfiles that were required under the old version of mybinder.org. The older version of mybinder.org munged these Dockerfiles, and so we needed to replicate that for compatibility.

@minrk did some wonderful work in allowing us to package the s2i binary into our python package, so users didn't even need to download s2i separately. It worked great, and we were happy with it!

## Moving off s2i

Sometime in July, we started adding support for Julia to binder/repo2docker. This brought up an interesting & vital issue - composability. 

If a user had a `requirements.txt` in their repo *and* a `REQUIRE` file, then we'd have to provide both a Python3 and Julia environment. To support this in s2i, we'd have needed to make a `python3-julia` buildpack. 

If it had a `requirements.txt`, a `runtime.txt` with contents `python-2.7` and a `REQUIRE` file, we'd have to provide a Python3 environment, a Python2 environment, and a Julia environment. To support this in s2i, we'd have needed to make a `python3-python2-julia` buildpack. 

If it had an `environment.yml` file and a `REQUIRE` file, we'd have to provide a conda environment and a Julia environment. To do this, we'd have to make a `conda-julia` buildpack.

As we add support for other languages (such as R), we'd need to keep expanding the set of buildpacks we had. It'd become a combinatorial explosion of buildpacks. This isn't a requirement or a big deal for PaaS offerings - usually a container image should only contain one 'application', and those are usually built using only one language. If you use multiple languages, you just make them each into their own container & communicate over the network. However, Binder was building images that contained *environments* that people could explore and do things in, rather than specific applications. Since a lot of scientific computing uses multiple languages (looking at you, the people who do everything in R but scrape using Python), this was a core feature / requirement for Binder. So we couldn't restrict people to single-language buildpacks.

So I decided that we can *generate* these combinatorial buildpacks in repo2docker. We can have a script that generates the buildpacks at build time, and then we can just check in the generated code. This would let us keep using s2i for doing image builds and pushes, and allow others using s2i to use our buildpacks. Win-win!

This had the following problems:

1. I was generating bash from python. This was quite error prone, since the bash also needed to carefully support the various complex environment specifications we wanted to support.
2. We needed to *sometimes* run assemble scripts as root (such as when there is an 'apt.txt' requiring package installs). This would require careful usage of `sudo` in the generated bash for security reasons.
3. This was very 'clever' code, and after running into a few bugs here I was convinced this 'generate bash with python' idea was too clever for us to use reliably.

At this point I considered making the `assemble` script into Python, but then I'd be either generating Python from Python, or basically writing a full library that will be invoked from inside each buildpack. We'd still need to keep repo2docker around (for Dockerfile + Legacy Dockerfile support), and the s2i buildpacks will be quite complex. This would also affect Docker image layer caching, since all activities of `assemble` are cached as one layer. Since a lot of repositories have similar environments (or are just building successive versions of same repo), this gives up a good amount of caching.

So instead I decided that the right thing to do here is to dynamically generate a Dockerfile in python code, and build / push the image ourselves. S2I was great for generating a best-practices production container that runs one thing and does it well, but for binder we wanted to generate container images that captured complex environments without regard to what can run in them. Forcing s2i to do what we wanted seemed like trying to get a square peg into a round hole.

So in [this heavily squashed commit](https://github.com/jupyter/repo2docker/commit/38755650c28fe6c71adec5a5bf9adfdde2d9772e) I removed s2i, and repo2docker became stand alone. It was sad, since I really would have liked to not write extra code & keep leveraging s2i. But the code is cleaner, easier for people to understand and maintain, and the composing works pretty well in understandable ways after we removed it. So IMO it was the right thing to do!

I personally would be happy to go back to using s2i if we can find a clean way to support composability + caching there, but IMO that would make s2i too complex for its primary purpose of building images for a PaaS. I don't see repo2docker and s2i as competitors, as much as tools of similar types in different domains. Lots of <3 to the s2i / openshift folks!

I hope this was a useful read!

## TLDR

S2I was great for generating a best-practices production container that runs one thing and does it well, but for binder we wanted to generate container images that captured complex environments without regard to what can run in them. Forcing s2i to do what we wanted seemed like trying to get a square peg into a round hole.
