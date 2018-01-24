+++
title = "Kubectl verbose logging tricks"
date = 2018-01-11T15:15:58-08:00
description = "kubectl for exploring the Kubernetes API"
categories = ["kubernetes", "code"]
+++

Recently I had to write some code that had to call the kubernetes API directly, 
without any language wrappers. While there is pretty good [reference docs](https://kubernetes.io/docs/reference/),
I didn't want to go and construct all the JSON manually in my programming language.

I discovered that `kubectl`'s `-v` parameter is very useful for this! With this,
I can do the following:

1. Perform the actions I need to perform with just `kubectl` commands
2. Pass `-v=8` to kubectl when doing this, and this will print all the HTTP traffic
   (requests and responses!) in an easy to read way
3. Copy paste the JSON requests and template them as needed!

This was very useful! The fact you can see the response bodies is also nice,
since it gives you a good intuition of how to handle this in your own code.

If you're shelling out to `kubectl` directly in your code (for some reason!),
you can also use this to figure out all the RBAC rules your code would need. For
example, if I'm going to run the following in my script:

```bash
kubectl get node
```

and need to figure out which RBAC rules are needed for this, I can run:

```bash
kubectl -v=8 get node 2>&1 | grep -P 'GET|POST|DELETE|PATCH|PUT'
```

This should list all the API requests the code is making, making it easier
to figure out what rules are needed.

Note that you might have to `rm -rf ~/.kube/cache` to 'really' get the
full API requests list, since `kubectl` caches a bunch of API autodiscovery.
The minimum RBAC for kubectl is:

```yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: kubectl-minimum
rules:
- nonResourceURLs: ["/api", "/apis/*"]
  verbs: ["get"]
```

You will need to add additional rules for the specific commands you
want to execute.


**More Kubectl Tips**

0. [Slides from the 'Stupid Kubectl Tricks' KubeCon talk](https://schd.ws/hosted_files/kccncna17/de/Stupid%20Kubectl%20Tricks.pdf)
1. [On the CoreOS blog](https://coreos.com/blog/kubectl-tips-and-tricks)
2. [Terse but useful official documentation](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
