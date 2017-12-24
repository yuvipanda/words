---
title: Simple python packaging for Debian / Ubuntu
author: yuvipanda
type: post
date: 2014-08-19T13:08:28+00:00
url: /simple-python-packaging-debian-ubuntu/
dsq_thread_id:
  - 2940405112
categories:
  - code

---
(As requested by [Jean-Fred][1])

One of the &#8216;pain points&#8217; with working on deploying python stuff at Wikimedia is that `pip` and `virtualenvs` are banned on production, for some (what I now understand as) good reasons (the solid Signing / Security issues with PYPI, and the slightly less solid but nonetheless valid &#8216;If we use pip for python and gem for ruby and npm for node, EXPLOSION OF PACKAGE MANAGERS and makes things harder to manage&#8217;). I was whining about how hard debian packaging was for quite a while without checking how easy/hard it was to package python specifically, and when I finally did, it turned out to be quite not that hard.

Use [python-stdeb][2].

Really, that is it. Ignore most other things (until you run into issues that require them :P). It can translate most python packages that are packaged for PyPI into .debs that mostly pass [lintian][3] checks. Simplest way to package, that I&#8217;ve been following for a while is:

  1. Install `python-stdeb` (from pip or apt). Usually requires the packages `python-all`, `fakeroot` and `build-essential`, although for some reason these aren&#8217;t required by the debian package for `stdeb`. Make sure you&#8217;re on the same distro you are building the package for.
  2. `git clone` the package from its source
  3. Run `python setup.py --command-packages=stdeb.command bdist_deb` (or `python3` if you want to make Python 3 package)
  4. Run `lintian` on it. If it spots errors, go back and fix them, usually by editing the `setup.py` file (or sometimes a `stdeb.cfg` file). This is usually rather obvious and easy enough to fix. 
  5. Run `dpkg -i <package>` to try to install the package. This will error out if it can&#8217;t find the packages that your package depends on. This means that they haven&#8217;t been packaged for debian yet. You can mostly fix this by finding that package, and making a deb for it, and installing it as well (recursively making debs for packages as you need them). While this sounds onerous, the fact is that most python packages already exist as deb packages and you `stdeb` will just work for them. You might have to do this more if you&#8217;re packaging for an older distro (_cough_ _cough_ `precise` _cough_ _cough_), but is much easier on newer distros.
  6. Put your package in a repository! If you want to use this on Wikimedia Labs, you should use [Labsdebrepo][4]. Other environments will have similar ways to make the package available via `apt-get`. Avoid the temptation to just `dpkg -i` it on machines manually :)

That&#8217;s pretty much it! Much simpler than I originally expected, and not much confusing / conflicting docs. The docs for `stdeb` are pretty nice and complete, so do read these!

Will update the post as I learn more.

 [1]: https://twitter.com/JeanFred
 [2]: https://pypi.python.org/pypi/stdeb
 [3]: https://lintian.debian.org/
 [4]: https://wikitech.wikimedia.org/wiki/Help:Using_debs_in_labs