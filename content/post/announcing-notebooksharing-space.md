---
title: "The fastest way to share your notebooks - announcing NotebookSharing.space"
date: 2021-11-16T20:43:11+05:30
lastmod: 2021-11-16T20:43:11+05:30
tags: ["announcement", "code"]

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: true
toc: true
---

![NotebookSharing.space logo](/images/nbss-logo.svg)

**Sharing notebooks is harder than it should be**.

You are working on a notebook (in Jupyter, RStudio, Visual Studio Code, whatever), and want
to share it quickly with someone. Maybe you want some feedback, or you're demonstrating
a technique, or there is a cool result you want to quickly show someone. A million reasons
to want to quickly share a notebook, but unfortunately there isn't a quick enough and
easy enough solution right now. That's why I built [notebooksharing.space](https://notebooksharing.space),
focused specifically on solving the problem of - "I have a notebook, I want to quickly
share it with someone else".

Ryan Abernathey captures the current frustration, and lays out a possible glorious
future for what a 'share a notebook I am working on' workflow might look like. NotebookSharing.space
is a start in tackling part of this. I highly recommend reading this thread.

{{< tweet user="rabernat" id="1446495829397839875" >}}

## Just upload, no signup necessary

As the goal is to have the fastest way to upload your notebook and share it with
someone, there is *no signup or user accounts necessary*. Just upload your notebook,
get the link, and share it however you want. Notebook links are permalinks - once uploaded,
a notebook can not be changed. You can only upload a new notebook and get a new link.

The upload is a bit slow in the video demos here because I'm sitting on a hammock in a remote beach,
but should be much faster for you.

You can upload your notebook easily via the web interface at [notebooksharing.space](https://notebooksharing.space):

<video controls src="/screencasts/nbss-launch/web-upload.mp4" width="100%" autoplay></video>

Once uploaded, the web interface will just redirect you to the beautifully rendered notebook,
and you can copy the link to the page and share it!

Or you can directly use the `nbss-upload` commandline tool:

<video controls src="/screencasts/nbss-launch/commandline.mp4" width="100%" autoplay></video>

On Macs, you can pipe the output of `nbss-upload` to `pbcopy` to automatically put the
link in your clipboard. Here is the [example notebook](https://notebooksharing.space/view/db27d9df0768fc62611dbdfa5f5a08525f1b1d637706cc1ad1d6973cb7d4a90e#displayOptions=) that I
uploaded, so you can check out how it looks.

A [jupyterlab extension](https://github.com/notebook-sharing-space/jupyterlab-nbsss) to
streamline this process is currently being worked on, and I'd appreciate any help. I'd
also love to have extensions for classic Jupyter Notebook, RStudio (via an [addin](https://rstudio.github.io/rstudioaddins/)),
Visual Studio Code, and other platforms.

## Provide feedback with collaborative annotations

When uploading, you can opt-in to have collaborative annotations enabled
on your notebook via the open source, web standards based [hypothes.is](https://hypothes.is/)
service. You can thus directly annotate the notebook, instead of having to email
back and forth about 'that cell where you are importing matplotlib' or 'that graph
with the blue border'. **This is one of the coolest features of notebooksharing.space**.

<video controls src="/screencasts/nbss-launch/annotations.mp4" autoplay width="100%"></video>

You can annotate the notebook demoed in the video [here](https://notebooksharing.space/view/2ccc2fefe2a07b081a499993b739d6e444fcee5120ba0e076745303d5bb6d4d8). Note that you
need a free [hypothes.is](https://web.hypothes.is/) account to annotate, but not to read.

Annotations are opt-in to limit unintended abuse. Enabling an unrestricted comments
section on every notebook you upload is probably a terrible idea.

## Private by default

By default, search engines do not index your notebooks - you have to opt-in to making
them discoverable while you are uploading the notebook. This way, only those you
share the link to the notebook with can view it. But be careful about putting notebooks
with secret keys or sensitive data up here, as anyone with a link can still view it -
just won't be able to *discover* it with search engines.

## RMarkdown and other formats are supported

It has always been important to me that the R community is treated as a first class
citizen in all the tools I build. Naturally, NotebookSharing.space supports
class support for R Notebooks as well as R Markdown files experimentally. R Notebooks produced by
RStudio are HTML files, and will be rendered appropriately, including outputs (see
[example](https://notebooksharing.space/view/c0c16296ad33ccbccc717b45c889194d09415744e8df10a27d0382715a07672c#displayOptions=)). RMarkdown
(`.rmd`) files only contain code and markdown, and will be rendered appropriately
(see [example](https://notebooksharing.space/view/468d71e31b3d685154c070b34f3ca88ab1eebf2ff96677ec2dbbc01b1f830897#displayOptions=))
). If you enable annotations, they will work here too! I would *love* for more
feedback from the R community on how to make this work better for you. In
particular, an [RStudio Addin](https://rstudio.github.io/rstudioaddins/) that
lets you share with a single shortcut key from RStudio would be an amazing
project to build.

If you work primarily in the R community, I'd love to work with you to improve
support here. I know there are bugs and rough edges, and would love for them to get better.

Internally, the wonderful [jupytext](https://github.com/mwouts/jupytext) project is
used to read various notebook formats, so anything it supports is supported on
NotebookSharing.space. This means `.py` files and `.md` files produced by Jupytext
or Visual Studio code will also be rendered correctly, albeit without outputs as those
are not stored in these files.

## Next steps?

I want extensions that let you publish straight from wherever you are working -
[JupyterLab](https://github.com/notebook-sharing-space/jupyterlab-nbsss),
classic Jupyter Notebook, RStudio and VS Code. That should speed up how fast you
can share considerably. Any help here is *most* welcome!

I also want users to interactively run the notebooks they find here easily.
This involves some integration with mybinder.org most likely, where you (or the
notebook author) can specify which *environment* to launch the notebook into.
Wouldn't it be wonderful to have a 'Make interactive' button or similar that
can immediately put the notebook back into an interactive mode?

Tweets from here on in Ryan's twitter thread sell this vision well.

{{< tweet user="rabernat" id="1446495833290051586" >}}

## Feedback

I *love* feedback! That's why I spend my time building these. [Open an issue](https://github.com/notebook-sharing-space/nbss/issues)
or [tweet at me](https://twitter.com/yuvipanda). As with all my projects, this is community built
and run - so please come join me :)

## Inspiration

Growing up on IRC, [pastebin](https://en.wikipedia.org/wiki/Pastebin) services
are part of life. In 2018, [GitHub stopped supporting anonymous
gists](https://github.blog/2018-02-18-deprecation-notice-removing-anonymous-gist-creation/)
- so sharing a notebook with someone became a lot more work.
NotebookSharing.space hopefully plugs that gap. The excellent
[rpubs.com](https://rpubs.com/) is also an inspiration!