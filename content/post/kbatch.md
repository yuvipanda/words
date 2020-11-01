---
title: "kbatch: sbatch, but for kubernetes"
date: 2020-11-01T13:40:27+05:30
lastmod: 2020-11-01T13:40:27+05:30
description: "What if we had an sbatch, but for Kubernetes?"
categories: [code]
---

Submitting 'non-interactive' jobs that can run independent of a user's current
session on a JupyterHub is a pressing problem. There are many many solutions to
this, but I think there's a lot of value in having an *extremely* simple
solution that solves exactly one extremely well defined problem.

We will only consider JupyterHubs running on top of Kubernetes, since that has all the actual capabilities we need to solve this problem. We only need to have a UX wrapper around it.

## Problem to solve

> If my JupyterHub session is terminated, all the code running there dies -
> including any dask sessions I might have - even though they are handled
> externally by dask-gateway.

This is trivially accomplished in batch scheduling systems like `slurm`, but
JupyterHub doesn't have a *simple* paradigm for it. It would be very, very
useful for it to have one.

## Stealing from slurm

Slurm has the [sbatch](https://slurm.schedmd.com/sbatch.html) command for submitting jobs, and the [squeue](https://slurm.schedmd.com/squeue.html) command for viewing job information. They have a large number of options that can do extremely complicated things - but I *think* we can copy a tiny subset of their functionality to solve our specific problem. We will not be copying all its behaviors, nor try to be compatible with it - just be *inspired*.

### `kbatch`

`kbatch` would be an equivalent to `sbatch` - just submitting jobs. You can specify the resources your job would need (CPUs, memory, GPUs, etc), give it a script to execute, and it'll just submit it and return. Nothing more! At least to begin with, it wouldn't have a lot of the complex features `sbatch` has - no array tasks, no multi-step jobs, etc. It would just be a script (or a notebook) that can run *independent of the current notebook session*. If you want parallelism, you should use dask from this script.

Other names for this could be something like `ksubmit` or `kbackground` or similar - the core thing it does is to `submit jobs`.

Options this command would have:

1. Script (or notebook to run)
2. Resources it needs (CPU, memory, GPU, etc)
3. Where to send stdout / stderr (by default, mimic `sbatch` behavior and put it on your homedir)
4. Job name / comment for you to keep track of it

Users shouldn't have to specify environment or home directories - these should be automatically detected to match current JupyterHub notebook environment. We could probably allow `KBATCH` commands in the script, similar to `SBATCH` commands - but more conversation with people who actually use this is needed :)

### `kqueue`

`kqueue` would let you check in on the status of your jobs - wether they were running, stopped, failed, etc.

That's it. I think just with these two, we can provide users the ability to run background jobs, from the commandline, similar to how they do so with slurm. We can eventually write GUIs for this fairly easily, since the functionality provided by them is quite simple.

### Extra features?

We can easily add more features - tailing logs, getting a shell into your running job to poke around, array jobs, etc. But it would be very nice if we can keep it a simple tool that can be marked *complete* once it solves the very specific problem it set out to solve.

## Implementation

[Kubernetes Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/) provide literally everything we need. We will write a simple python application that uses the kubernetes API to do everything. All meta-information will be stored as labels in the Kubernetes Job object, and the python application will be responsible for providing the appropriate UX to our users.

## Caveats

This is *extremely* simple, and isn't meant for more complex DAG use cases. For those, look at something like Airflow or Prefect or any of the million other things that exist. This is a small UX improvement over `kubectl`, basically.

Now, let's go do it!

