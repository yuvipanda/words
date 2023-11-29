---
title: "Precompiling Julia Packages in Docker Images"
date: 2023-11-29T14:27:25-08:00
lastmod: 2023-11-29T14:27:25-08:00
tags: ["julia", "docker"]

---
Julia [pre-compiles](https://julialang.org/blog/2021/01/precompile_tutorial/) packages on first load, allowing them to deeply optimize the generated code for the particular CPU architecture the user is running on for maximum performance. However, it *does* take some time, so there's a startup latency penalty here. If you make docker images with precompiled Julia packages, you can pay this pre-compilation penalty at *image build time*, rather than at *image startup time*. Much better for your users!

If you look at the [tutorial](https://julialang.org/blog/2021/01/precompile_tutorial/) for pre-compilation, it may sound like all you need to do is call [`Pkg.precompile`](https://pkgdocs.julialang.org/v1/api/#Pkg.precompile). And if you actually build and test your docker image, it will work fine - your precompiled libraries are loaded, and startup is fast. Yay!

But then you push your built image to a registry, and someone else pulls it and runs it - and the pre-compilation has no effect! Packages are pre-compiled again on first run, and sometimes this may take multiple minutes, causing weird to debug timeouts. But then *you* can't reproduce it, because it runs fine on your computer! What's going on?

What is going on is an [abstraction leak](https://www.joelonsoftware.com/2002/11/11/the-law-of-leaky-abstractions/). We think of computers as 'computers', and often it's easy to forget that there's just a wide wide variety of them. After a few decades of Intel's (or should I say [AMD's](https://en.wikipedia.org/wiki/X86-64#History_2)) amd64 architecture hegemony, M1 Macs (and Raspberry Pi) have at least forced us to consider that ARM64 exists as well. But those are still just broad *classes* of architectures, and each generation of CPUs within them also have differences, with specific instructions available in some that aren't in others.

So turns out Julia's pre-compilation is CPU dependent (or more specifically, [ISA](https://en.wikipedia.org/wiki/Instruction_set_architecture) dependent). So if I build my docker image on one type of CPU, the pre-compiled files will only be used when running on the same type of CPU!

The limits of 'works on my machine' :)

This manifested as a ['Pluto notebook is not starting when run on JupyterHub'](https://github.com/jupyter/docker-stacks/issues/2015) issue. It was fun [debugging this](https://github.com/jupyter/docker-stacks/issues/2015#issuecomment-1829232453), eventually leading me to discover this bit about Julia pre-compilation. We eventually [landed a fix](https://github.com/jupyter/docker-stacks/pull/2044) that cross compiles to a number of different ISAs, producing a 'fat binary pre-compilation' that starts fast on a number of different CPUs!

I'm also personally happy with the amount of time this took - I'm trying to learn to wean myself off high stress 'gotta fix it now' open source maintenance, and a slower paced *but* more consistent approach.

Anyway, if you're building Docker images with Julia in them, and want to pre-compile any packages you install in the image (as you should), I recommend the following bash snippet before you call `Pkg.precompile`

```bash
if [ "$(uname -m)" == "x86_64" ]; then
    # See https://github.com/JuliaCI/julia-buildkite/blob/70bde73f6cb17d4381b62236fc2d96b1c7acbba7/utilities/build_envs.sh#L24
    # for an explanation of these options
    export JULIA_CPU_TARGET="generic;sandybridge,-xsaveopt,clone_all;haswell,-rdrnd,base(1)"
elif [ "$(uname -m)" == "aarch64" ]; then
    # See https://github.com/JuliaCI/julia-buildkite/blob/70bde73f6cb17d4381b62236fc2d96b1c7acbba7/utilities/build_envs.sh#L54
    # for an explanation of these options
    export JULIA_CPU_TARGET="generic;cortex-a57;thunderx2t99;carmel"
fi
```

This is what the [official Julia binary](https://julialang.org/downloads/) is built with (and you should be using *that*, not your distro provided binary). It may need updating as new ISAs come out, but otherwise should help.

Thanks to [mathbunnyru](https://github.com/mathbunnyru) and [benz0li](https://github.com/benz0li) for helping with this.

P.S. Did you know that Python *also* does pre-compilation, and that can *also* have a massive effect on python startup time? I did a [similar debugging session](https://github.com/pangeo-data/pangeo-docker-images/pull/426) on that a while back.
