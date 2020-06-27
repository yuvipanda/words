---
title: "Access dask-kubernetes clusters running on a cloud from your local machine"
date: 2020-06-27T13:27:49+05:30
lastmod: 2020-06-27T13:27:49+05:30
description: "'Burst' from your local machine when you need some extra compute with dask-kubernetes"
categories: ["code", "dask"]
---

You can run your Jupyter Notebook locally, and connect easily to a remote `dask-kubernetes` cluster
on a cloud-based Kubernetes Cluster with the help of [kubefwd](https://kubefwd.com/). This notebook
will show you an example of how to do so. While this example is a Jupyter Notebook, the code will work
any local python medium - REPL, IDE (vscode), or just plain ol' `.py` files

Latest executable version of this notebook can be found in [this repository](https://github.com/yuvipanda/cloud-local-dask-kubernetes)

## Credit

This work was sponsored by [Quansight](https://www.quansight.com/) ❤️

## Create & setup a Kubernetes cluster

You need to have a working kubernetes cluster that is configured correctly. If you can get
`kubectl get ns` to work properly, it means your cluster is working fine & connected for
this to go.

## Install & run kubefwd

`kubefwd` lets you access services in your cloud Kubernetes cluster as if they were
localy, with a clever combination of ol' school `/etc/hosts` hacks & fancy kubernetes
port-forwarding. It requires root on Mac OS & Linux, and should theoretically work on
Windows too (haven't tested).

Once you have installed it, run it in a separate terminal.

```bash
sudo kubefwd svc -n default -n kube-system
```

If you've created your own namespace for your cluster, use that instead of `default`.
The `kube-system` is required until [this issue](https://github.com/txn2/kubefwd/issues/132)
is fixed.

If the `kubefwd` command runs successfully, we're good to go!

## Install libraries we'll need

In addition to `dask-kubernetes`, we'll also need `numpy` to test our cluster with dask arrays.


```python
%pip install numpy dask distributed dask-kubernetes
```

## Setup dask-kubernetes configuration

Normally, the pod template would come from an external configuration file.
We keep this in the notebook to make it more self contained.


```python
POD_SPEC = {
    'kind': 'Pod',
    'metadata': {},
    'spec': {
        'restartPolicy': 'Never',
        'containers': [
            {
                'image': 'daskdev/dask:latest',
                'args': [
                    'dask-worker',
                    '--death-timeout', '60'
                ],
                'name': 'dask',
            }
        ]
    }
}
```

## Create a remote cluster & connect to it

We create a `KubeCluster` object, with `deploymode='remote'`. This creates
the scheduler as a pod on the cluster, so worker <-> scheduler communication
is easy & efficient. `kubefwd` helps us communicate to this remote scheduler,
so we can pretend we are actually on the remote cluster.

If you are using `kubectl` to watch the objects created in your namespace,
you'll see a `service` and a `pod` created for this. `kubefwd` should
also list a log line about forwarding the service port locally.


```python
from dask_kubernetes import KubeCluster

cluster = KubeCluster.from_dict(POD_SPEC, deploy_mode='remote')
```

## Create some workers

We have a scheduler in the cloud, now time to create some workers in the
cloud! We create 2, and can watch the worker pods come up with glee in
`kubectl`

All scaling methods (adaptive scaling, using the widget, etc) should work
here.


```python
cluster.scale(2)
```

## Run some computation!

We test our cluster by doing some trivial calculations with dask arrays.
You can use any dask code as you normally would here, and it would
run on the cloud Kubernetes cluster. This is especially helpful if you
have large amounts of data in the cloud, since the workers would be
really close to where the data is.

You might get warnings about version mismatches. This is ok for the demo,
in production you'd probably build your own docker image that will
have fixed versions.


```python
from dask.distributed import Client
import dask.array as da

# Connect Dask to the cluster
client = Client(cluster)

# Create a large array and calculate the mean
array = da.ones((1000, 1000, 1000))
print(array.mean().compute())  # Should print 1.0
```

## Cleanup dask cluster

When you're done with your cluster, remember to clean it up to release
the resources!

This doesn't affect your kubernetes cluster itself - you'll need to
clean that up manually


```python
cluster.close()
```

## Next steps?

Lots more we can do from here.

### Ephemeral Kubernetes Clusters

We can wrap kubernetes cluster creation in some nice python functions, letting users create kubernetes clusters just-in-time for running a dask-kubernetes cluster, and tearing it down when they're done. Users can thus 'bring their own compute' - since the clusters will be in their cloud accounts - without having the complication of understanding how the cloud works. This is where this would be different from the wonderful [dask-gateway](https://gateway.dask.org) project I think.

### Remove kubefwd

`kubefwd` isn't strictly necessary, and should ideally be replaced by a `kubectl port-forward` call that doesn't require root. This should be possible with some changes to the `dask-kubernetes` code, so the client can connect to the scheduler via a different address (say, `localhost:8974`, since that's what `kubectl port-forward` gives us) vs the workers (which need something like `dask-cluster-scheduler-c12.namespace:8786`, since that is in-cluster address).

Longer term, it would be great if we can get rid of spawning other processes altogether, if/when the python kubernetes client gains the [ability to port-forward](https://github.com/kubernetes-client/python/issues/166).

### Integration with TLJH

I love [The Littlest JupyterHub (TLJH)](https://tljh.jupyter.org). A common use case is that a group of
users need a JupyterHub, mostly doing work that's well seved by TLJH. However, sometimes they
need to scale up to a big dask cluster to do some work, but not for long. In these cases, I believe
a combination of TLJH + Ephemeral Kubernetes Clusters is far simpler & easier to manage than running
a full Kubernetes based JupyterHub. In addition, we can share the conda environment from TLJH with
the dask workers, **removing the need for users to think about docker images or environment
mismatches completely**. This is a massive win, and merits further exploration.

### ???

I am not actually an end user of dask, so I'm sure actual dask users will have much more ideas.
Or they won't, and this will just end up being a clever hack that gives me some joy :D Who
knows!