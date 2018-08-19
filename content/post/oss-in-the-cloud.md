+++
title = "Freedoms for Open Source Software users in the Cloud"
date = 2018-08-15T22:41:17-06:00
categories = ["code"]
+++

*This post is from conversations with [Matt
Rocklin](http://matthewrocklin.com/) and others at the
[PANGEO](http://pangeo.io/) developer meeting at
[NCAR](https://ncar.ucar.edu/)*

Today, almost all of 'the cloud' is run by
ruthlessly competitive hypercapitalist large scale
organizations. This is great & terrible.

When writing open source applications that primarily
run on the cloud, I try to make sure my users (primarily
people deploying my software for *their* users) have
the following freedoms:

1. **They can run the software on any cloud provider they
   choose to**
2. **They can run the software on a bunch of computers they
   physically own, with the help of other open source software
   only**

Ensuring these freedoms for my users requires the following
restrictions on me:

1. Depend on Open Source Software with hosted cloud versions,
   not proprietary cloud-vendor-only software.

   I'll use PostgreSQL over Google Cloud Datastore. Kubernetes with
   autoscaling over talking to the EC2 api directly.

2. Use abstractions that allow swappable implementations anytime
   you have to talk to a cloud provider API directly.

   Don't talk to the S3 API directly, but have an abstract
   interface that defines exactly what your application needs,
   and then write an S3 implementation for it. Ideally, also
   write a minio / ceph / file-system implementation for it,
   to make sure your abstraction actually works.

These are easy to follow once you are aware of them, and provide
good design tradeoffs for Open Source projects. Remember these are
necessary but not sufficient to ensure some of your users' fundamental
freedoms.
