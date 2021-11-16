---
title: Announcing the nbgitpuller Link Generator browser extensions
date: 2021-11-16T18:58:28+05:30
lastmod: 2021-11-16T18:58:28+05:30
tags: ["code", "launch"]

comment: true
toc: false
---

[nbgitpuller](https://jupyterhub.github.io/nbgitpuller) is my most favorite way to distribute
content (notebooks, data files, etc) to students on a JupyterHub. The student mental model is
'I click a link, and can start working on my notebook', which is as close to ideal as we have today.
That is possible since *all* the information required for this workflow is embedded in the link
itself - so it can be distributed easily via your pre-existing communication channel (like
email, [course website](http://data8.org/sp21/), etc), rather than requiring your students to use
yet another tool.

However, *creating* these links often been a bit clunky and error prone. The current
[link generator](https://jupyterhub.github.io/nbgitpuller/link) is pretty awesome, but requires
a lot of manual copy pasting, and is prone to errors. Particularly problematic was the GitHub
switching of the default branch from `master` to `main`, which really caused problems for many
instructors.

To make life easier, I've now written a browser extension that lets you create these links
straight from the GitHub interface!

On the GitHub page for files, folders and repositories, it adds an
'nbgitpuller' button.

![nbgitpuller button](/images/nbgitpuller-link-screenshots/screenshot-button.png)

On clicking this, you can enter a JupyterHub URL and the application
you want to use to open this file, folder or repository. Then you
can just copy the nbgitpuller URL, and share it with your students!

![nbgitpuller popover](/images/nbgitpuller-link-screenshots/screenshot-popover.png)

The JupyterHub URL and application you choose are remembered, so
you do not need to enter it over and over again.

## How to install?

### On Mozilla Firefox

I ❤️ Mozilla Firefox, and you can install the extension there easily from
the official [addons store](https://addons.mozilla.org/en-US/firefox/addon/nbgitpuller-link-generator/).
You'll also get automatic updates with new features and bug fixes this way.

### On Google Chrome

On Google Chrome / Chromium, I have submitted the extension to the Chrome Web Store -
but apparently there is a manual review process, and it can take *weeks*. In the meantime,
you can install it with the following steps

1. Download the `.zip` version of the latest [release](https://github.com/yuvipanda/nbgitpuller-link-generator/releases)
   of the extension. You want the file named `nbgitpuller_link_generator-<version>.zip`.
2. Extract the `.zip` file you downloaded.
3. In your Google Chrome / Chromium, go to [chrome://extensions](chrome://extensions/).
4. Enable the *Developer Mode* toggle in the top right. This should make a few options visible
   in a new toolbar.
5. Select *Load Unpacked*, and select the directory into which the downloaded `.zip` file
   was extracted to. This directory should contain at least a `manifest.json` file that
   was part of the `.zip` file.

### Other browsers

The extension is written as a [WebExtension](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions),
so should work easily in other browsers - Safari, Edge, etc. However, since I do not
use them myself, I don't have instructions on how to add them there. However, if you do
use those browsers, I'd [love contributions](https://github.com/yuvipanda/nbgitpuller-link-generator-webextension)
on how to install the extension there!