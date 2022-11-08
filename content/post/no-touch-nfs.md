---
title: "JupyterHub tip: Don't touch NFS unless you must"
date: 2022-11-07T15:55:47-08:00
lastmod: 2022-11-07T15:55:47-08:00
categories: [z2jh, jupyterhub, nfs]
---

If you are running a [JupyterHub on Kubernetes](https://z2jh.jupyter.org) and
use NFS for home directory storage (a common occurance), I highly recommend the
following settings:

```yaml
singleuser:
  extraEnv:
    # notebook server writes secure files that don't need to survive a
    # restart here. Writing 'secure' files on some file systems (like
    # Azure Files with SMB or NFS) seems buggy, so we just put runtime dir on
    # /tmp. This is ok in our case, since no two users are on the same
    # container.
    JUPYTER_RUNTIME_DIR: /tmp/.jupyter-runtime
  extraFiles:
    ipython_kernel_config.json:
      mountPath: /usr/local/etc/ipython/ipython_kernel_config.json
      data:
        # This keeps a history of all executed code under $HOME, which is almost always on
        # NFS. This file is kept as a sqlite file, and sqlite and NFS do not go together very
        # well! Disable this to save ourselves from debugging random NFS oddities that are caused
        # by this unholy sqlite + NFS mixture.
        HistoryManager:
          enabled: false
```

These aren't specific to kubernetes, but to NFS (or AzureFile, or any other shared
filesystem). sqlite and NFS *do not mix*, and you'll run into weird errors you will not
be able to really debug. Save yourself the pain :) Let your users know too, and tell them to
not put sqlite databases on NFS.

