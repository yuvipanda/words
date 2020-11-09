---
title: "The many ways to access your JupyterHub environment"
date: 2020-11-09T02:15:15+05:30
lastmod: 2020-11-09T02:15:15+05:30
description: "Your tool of choice (ssh, local IDE, notebooks) should be able to access your JupyterHub environment"
categories: ["code"]
---

JupyterHub was designed to provide multi-user access to Classic Jupyter notebook and JupyterLab, running on machines far away with access to data & compute your local machines don't have. However, there are a *lot* of users this leaves out - R users on RStudio, folks who prefer `ssh` based interfaces, people on local IDEs like vscode or pycharm, etc. We trust that these users know better than 'us' developers & admins what user interface works best for them, and make sure that our JupyterHub setups work for them.

I propose that we try provide the following in all JupyterHub setups, but particularly on cloud-based deployments focused on research.

1. Arbitrary web applications on the browser, not just classic notebook & JupyterLab. This could be RStudio / Shiny for R folks, [Pluto.jl](https://github.com/fonsp/Pluto.jl) for Julia folks, [Theia IDE](https://theia-ide.org/) or [vscode](https://github.com/cdr/code-server) for arbitrary languages, etc. These need to be first class citizens with amazing support. [jupyter-server-proxy](https://github.com/jupyterhub/jupyter-server-proxy/) does a lot of this already - but still needs to be 'set up' in your deployment. DO IT!

2. `ssh` support, so you can `ssh yuvipanda@myhub.org`, and have it work as you would expect. It should have the same environment & home directories as your browser based sessions. Along with something like [kbatch](https://words.yuvi.in/post/kbatch/), this could let folks who like their current HPC style workflows keep it. SFTP for file transfer, SSH Tunneling, scripting via command execution, etc should also come along with this, allowing re-use with a vast array of existing tools & workflows.

3. Connecting from local IDEs, for notebook execution. The Jupyter protocol is designed to work with a variety of frontends, and many IDEs support connecting directly to a Jupyter kernel - [Visual Studio Code](https://code.visualstudio.com/docs/python/jupyter-support), [PyCharm](https://www.jetbrains.com/help/pycharm/jupyter-notebook-support.html), [spyder](https://medium.com/@halmubarak/connecting-spyder-ide-to-a-remote-ipython-kernel-25a322f2b2be), [emacs](https://github.com/nnicandro/emacs-jupyter), etc. There is already decent-ish support for this, but would be nice to explicitly document, bugfix and promote this to users.

4. Connecting from local IDEs for a full remote development environment. Connecting to a remote Jupyter kernel often doesn't give you all that you want from your IDE - no access to remote filesystem, limited access from other IDE features (version control, global find, etc). Many IDEs offer a 'remote development' experience that gives you all this, and usually requiring just a few SSH features to work. VSCode's [remote development](https://code.visualstudio.com/docs/remote/remote-overview) feature is very well done, popular and **not open source**, but we should support it. [PyCharm](https://blog.jetbrains.com/pycharm/2018/04/running-flask-with-an-ssh-remote-python-interpreter/) supports this, and Emacs' [TRAMP](https://www.emacswiki.org/emacs/TrampMode) is highly rated as well.

You might not need some of these in your deployment - for example, you might have no R users, rendering RStudio not very useful. However, I think the world is getting more and more polyglot, and we need to move with it. Consider deploying these, even if your users don't explicitly ask for it - I suspect many will use it once it is there. <3

## Work to be done

There's a lot of work to be done here to make this all a great experience.

1. Documentation and publicity for [jupyter-server-proxy](https://github.com/jupyterhub/jupyter-server-proxy/). For example, this [README](https://github.com/jupyterhub/jupyter-rsession-proxy/) is all the docs that exist on how to set up RStudio to work in your JupyterHub. This is low hanging fruit with huge impact. Same for running remote [desktop applications](https://github.com/yuvipanda/jupyter-desktop-server/), [Pluto.jl](https://github.com/IllumiDesk/jupyter-pluto-proxy), and many many others.
2. Work on [jupyterhub-ssh](https://github.com/yuvipanda/jupyterhub-ssh). Aims to provide full SSH support - terminal emulation, command execution, tunneling and SFTP. This would go a long way in supporting (2) and (4) above. It sortof-kinda works now, but effort poured into it will be well spent. I long for a day when setting this up would be as simple as setting up z2jh or TLJH, and it actually isn't that far away if effort is put into it.
3. More outreach to non-Jupyter communities about levaraging JupyterHub for their workflows. The name 'Jupyter' in 'JupyterHub' is no longer fully accurate, given all the other things that can be run with it. We should reach out to other communities and 'bring them into the fold', so to speak - so their workflows, desires and bugs can drive development.
4. A unified setup guide for 'research hubs', that guides first-time admins through setting these up - including great documentation. A `z2jh for research hubs on the cloud` would be extremely well received I believe.

## Will you help?

I've been talking to [Chris Holdgraf](https://predictablynoisy.com/) a lot on how to go about getting folks into doing stuff like this. I see two primary options:

1. Get funding from various entities (foundations, universities, corporations, etc) for folks to do this. Hopefully [2i2c](https://2i2c.org/) can be a vehicle for this.
2. Pour a lot more effort into getting more new developers into JupyterHub development than we are now. This would mean things like participating in Google Summer of Code, Outreachy, development sprints in various conferences, etc. 

Would love to hear thoughts from you, dear reader :) Email `yuvipanda@gmail.com`.
