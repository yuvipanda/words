---
title: "Disabling JupyterLab extensions on your z2jh JupyterHub installations"
date: 2021-12-15T12:16:47+05:30
lastmod: 2021-12-15T12:16:47+05:30
draft: false
tags: [code, jupyter]

# You can also close(false) or open(true) something for this content.
# P.S. comment can only be closed
comment: true
toc: true
---

Sometimes you want to temporarily disable a JupyterLab extension on a JupyterHub
by default, without having to rebuild your docker image. This can be very
easily done with z2jh's [singleuser.extraFiles](https://zero-to-jupyterhub.readthedocs.io/en/latest/resources/reference.html#singleuser-extrafiles),
and JupyterLab's [page_config.json](https://jupyterlab.readthedocs.io/en/stable/user/directories.html#labconfig-directories)

JupyterLab's `page_config.json` lets you set page configuration by dropping JSON files
under a `labconfig` directory inside any of the directories listed when you run `jupyter --paths`.
We just use `singleuser.extraFiles` to provide this file!

```yaml
singleuser:
  extraFiles:
  lab-config:
    mountPath: /etc/jupyter/labconfig/page_config.json
    data:
      disabledExtensions:
        jupyterlab-link-share: true
```

This will disable the [link-share](https://github.com/jupyterlab-contrib/jupyterlab-link-share)
labextension, both in JupyterLab and RetroLab. You can find the name of the
extension, as well as its current status, with `jupyter labextension list`.

```
jovyan@jupyter-yuvipanda:~$ jupyter labextension list
JupyterLab v3.2.4
/opt/conda/share/jupyter/labextensions
        jupyterlab-plotly v5.4.0 enabled OK
        jupyter-matplotlib v0.9.0 enabled OK
        jupyterlab-link-share v0.2.4 disabled OK (python, jupyterlab-link-share)
        @jupyter-widgets/jupyterlab-manager v3.0.1 enabled OK (python, jupyterlab_widgets)
        @jupyter-server/resource-usage v0.6.0 enabled OK (python, jupyter-resource-usage)
        @retrolab/lab-extension v0.3.13 enabled OK
```

This is extremely helpful if the same image is being shared across hubs, and
you want some of the hubs to have some of the extensions.

`singleuser.extraFiles` can be used like this for *any* jupyter config, or generally
any config file anywhere. For example, here's some config that culls idle running
kernels, and shuts down notebooks after 60m of inactivity:

```yaml
singleuser:
  extraFiles:
    culling-config:
      mountPath: /etc/jupyter/jupyter_notebook_config.json
      data:
        NotebookApp:
          # shutdown the server after no 30 mins of no activity
          shutdown_no_activity_timeout: 1800

        # if a user leaves a notebook with a running kernel,
        # the effective idle timeout will typically be CULL_TIMEOUT + CULL_KERNEL_TIMEOUT
        # as culling the kernel will register activity,
        # resetting the no_activity timer for the server as a whole
        MappingKernelManager:
          # shutdown kernels after 30 mins of no activity
          cull_idle_timeout: 1800
          # check for idle kernels this often
          cull_interval: 60
          # a kernel with open connections but no activity still counts as idle
          # this is what allows us to shutdown servers
          # when people leave a notebook open and wander off
          cull_connected: true
```