---
title: "Rethinking Jupyterhub Singleuser"
date: 2025-08-22T11:03:54-07:00
lastmod: 2025-08-22T11:03:54-07:00
draft: false
tags: []
categories: ["open source"]

---
## What is this?

During the JupyterHub leadership meeting (North America) of June 2025, the breakout group comprising of Yuvi, Martha Cryan and Ryan Lovett came up with the following diagram to explain the aspirational mission of JupyterHub:

![image](/images/what-is-jupyterhub.png)

This document is Yuvi's interpretation of one of the technosocial changes required to achieve this aspiration. It's also heavily influenced by prior conversations with MinRK, Carol Willing, Ryan Lovett, Carl Boettiger, Rick Wagner, Sanjay Bhangar and Tarashish Mishra.

## Essential Complexities

Currently, JupyterHub requires that there's a `jupyterhub-singleuser` executable (or equivalent) *inside* each user's environment it has to spawn. Without this, spawning would fail.

This executable has the following responsibilities:

1. **Endpoint Security**: Perform OAuth with JupyterHub, so only authorized users can access the user's server
2. **Activity Reporting**: Continually report back to JupyterHub if the user has performed any 'activity', primarily for helping with culling inactive servers
3. **Supervise and Proxy**: (With `jupyter-server-proxy`) Start and proxy *arbitrary web services* (while often ignoring *their* endpoint security) to support alternate UIs (such as RStudio or VSCode)

## Existing Implementations

There are two real implementations of this:
1. [`jupyterhub-singleuser`](https://github.com/jupyterhub/jupyterhub/tree/main/jupyterhub/singleuser) the canonical implementation, relying on Tornado and Python. [`jupyter-server-proxy`](https://github.com/jupyterhub/jupyter-server-proxy/) needs to be separately installed for (3). This is the most commonly used implementation by multiple orders of magnitude
2. [`jhsingle_native_proxy`](https://github.com/ideonate/jhsingle-native-proxy) which relies on `jupyterhub-singleuser` but also combines with it `jupyter-server-proxy` and [nbgitpuller](github.com/jupyterhub/nbgitpuller/)

## Accidental Complexities

### Multiple levels of Python Environments

Wether separate or not, you end up with at least 3 kinds of Python environments:

1. The **JupyterHub** control plane environment, which runs just the JupyterHub server.
2. The `jupyterhub-singleuser` environment, which needs to have *both* `jupyterhub-singleuser` but **also** requires a compatible [`jupyter_server`](https://github.com/jupyter-server/jupyter_server) implementation, regardless of wether a Jupyter Server based application (primarily JupyterLab or Notebook) is being used at all
3. Individual Python environments for any kernels that may be used by the user. This can be many different ones, if say [nb_conda_kernels](https://github.com/anaconda/nb_conda_kernels) is used.

Singe `jupyterhub-singleuser` *requires* a `jupyter_server`, those two are conflated. This unfortunately means that the environment that is the *requirement* for JupyterHub to work correctly also ends up being the environment where you need:
1. A Jupyter Server (often [`jupyterlab-server`](https://github.com/jupyterlab/jupyterlab_server)) and [*all* its dependencies](https://libraries.io/pypi/jupyterlab-server/2.27.3/tree)  (50 unique ones at time of writing)
2. A valid *Python version* that is supported by `jupyter-server` (Python 3.9 at time of writing).
3. The same environment must be used for all other `jupyter-server` extensions you may want to install, as well as extensions to those extensions. This includes JupyterLab extensions, as well as `jupyter-server-proxy` extensions

And often, (2) and (3) are conflated together as well (repo2docker often does this by default, and so do many popular Docker images and conda installation tutorials). This means the version of Python the user wants has a complex relationship with the version of Python that jupyterhub-singleuser needs.

This is all *purely* accidental complexity, since none of this is *essential* to the three duties that `jupyterhub-singleuser` practically fulfills. The primary *cause* of this accidental complexity is accidental conflation caused by using the same language (Python) for both **infrastructure** pieces (`jupyterhub-singleuser`), **UI** pieces (`jupyterlab`, `jupyter-server-proxy`) as well as **user code** pieces (`numpy`, `pandas` etc). While theoretically you could have different python environments doing all these different things, most commonly they are not. At best observed environments may have one for the infrastructure and UI pieces and one for the user code pieces, but that still is conflation.

However we design the next version of `jupyterhub-singleuser` it should make the default happy path to have *lesser* conflation of these environments.

### Social perception of "First Class Citizenship"

It has been possible to robustly run RStudio and many other applications on JupyterHub for many years now (Ryan Lovett and I created `jupyter-server-proxy` in 2016, 9 years ago). However, it is still perceived that JupyterHub is *primarily* for running "Jupyter" as broadly defined, which to most people implies JupyterLab for better or worse. While this is *technically* not true to some extent, it is *socially* true. There is an additional implication that JupyterHub is primarily for *Python* workloads, due to the strong association of Jupyter with Python. All the R users I know use RStudio.

There is a *technical* reason for this too - `jupyterhub-singleuser` *requires* a `jupyter-server`, and most often this means you are installing JupyterLab. Which by default brings in [ipykernel](https://github.com/ipython/ipykernel). So even a purely R and RStudio focused environment like Rocker has [to bring in JupyterLab](https://github.com/rocker-org/rocker-versioned2/blob/4858a33c9ac73dde58ea865d6546b72378b4227b/scripts/install_jupyter.sh#L33) and with it a Python kernel.

So the default path to running non-JupyterLab applications on a JupyterHub involves installing both JupyterLab, and a Python environment. This has the social and technical consequence of making it clear that JupyterLab is the *first class* citizen, and everything else is something along for the ride. This causes practical issues too - the folks running Rocker recognize that RStudio support in JupyterHub is second class, and that does make them less inclined to continue supporting it if drastic changes are required.

This is also an accidental complexity - nothing about the inherent essential complexities of what `jupyterhub-singleuser` needs requires any of this to happen.

### Building user environments requires understanding the Jupyter ecosystem

To build environments (either docker images or something else) that work well with JupyterHub requires the person building it to have a detailed understanding of:

1. The environment builder itself (Docker, `conda`, VM provisioning, etc)
2. The specific tool that is used to provision the **user code** support environment (`conda`, various R install mechanisms, `venv` etc)
3. JupyterHub specific knowledge (Which environment needs `jupyterhub-singleuser`, how to install Jupyter Server extensions, Kernel discovery, etc)

(1) and (2) are *very* broad skillsets that are widely applicable, and widely supported. (3) however, is niche and something only we, the JupyterHub community, can provide. We don't provide it very well - [this snippet](https://repo2docker.readthedocs.io/en/latest/howto/jupyterhub_images.html) in the repo2docker docs is what I could find, and I know it's not complete nor enough. This is particularly a barrier for people who aren't planning on using JupyterLab or Python.

## Desired Outcomes

Before proposing any specific solution, I want to list the desired outcomes I have for what such a rethink would do.

1. Non JupyterLab, non Python communities are treated as **first class citizens**. This is a social outcome, and the most important one for improving the breadth of the JupyterHub community, to serve all our users where they are, and perhaps, the longevity of the JupyterHub project. Wether we meet this or not should be gauged by the presence of such people in our community of contributors and maintainers.
2. JupyterHub is recognized as 'not just for Jupyter(Lab)'. This is already (mostly) not technically true, but is perceived to be true for accidental complexity reasons. Let's make it technically fully not true, and socially not true as well.
3. Building environments that work with JupyterHub become trivially tacklable without having a deeper understanding of the Jupyter ecosystem.
4. Easy transition for existing JupyterHub deployments. It should be more like the R 3.x to R 4.x transition, rather than the Python 2.x to 3.x transition. This includes, but is not limited to, compatibility with existing pre-built environments as well as not requiring duplicate maintenance of code on an ongoing basis.

Any proposed solution should be evaluated along how it will help us as a community achieve these three outcomes. This removal of accidental complexity will also make general maintenance easier, as well as expand the group of people who feel they 'belong' to the JupyterHub community and can hence help with maintenance.

## Implementation requirements

1. `IdentityProvider` integration
2. Activity Tracking integration
3. A well understood API for passing authorization information on a per-request basis
4. Deployment considerations
5. Community and ongoing maintenance considerations

## Needs more investigation

1. A deeper understanding of the `IdentityProvider` integration that JupyterHub currently does with Jupyter Server needs to be included in the outcomes.
2. We do a bunch of XSRF munging. Need to understand how much of that the proxy needs to be able to do, or if it even can

## Potential Inspiration

This section lists some open source applications we can take potential inspiration from.

1. JupyterHub itself! I think our use of OAuth for endpoint security is quite nice, and I think we can learn a lot from what we do.
2. [12 Factor App Philosophy](https://12factor.net/) which inspired a lot of how `jupyter-server-proxy` does things.
3. [Open OnDemand](https://github.com/OSC/ondemand) which is more focused on HPC applications and [slightly different architecture](https://osc.github.io/ood-documentation/latest/architecture.html). It does use modified [nginx](https://github.com/OSC/ondemand/tree/master/nginx_stage) in place of `jupyterhub-singleuser`.
4. https://github.com/OpenIDC/mod_auth_openidc is a classic Apache2 implementation of a proxy that authenticates with OAuth2 and then also potentially spawns & supervises processes. We should *not* use httpd, but helpful to not reinvent concepts

## Calls to action

Do you want to fund this work? Or take this work on in a sustained fashion? Post on the [Jupyter Zulip](https://jupyter.zulipchat.com) and tag me (`@yuvipanda`)!

## Endorsements

Here's some endorsements from some people :)

MinRK: "i think that's 100% worth doing if/when someone has the time, and appropriate to publicly describe as a goal. we would need to define a new spec for authenticating requests _from_ the proxy."

RyanLovett: "Just a reminder about https://github.com/jupyterhub/jupyter-server-proxy/issues/1, which seems relevant."

Rick Wagner: "This absolutely worth scoping and determining if there is capacity to begin work."