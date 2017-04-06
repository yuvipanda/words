+++
date = "2017-04-05T23:18:19-07:00"
title = "python gil resources"
tags = ["python","learning"]

+++

I was in a conversation about the Python GIL with friends a few days ago, and realized that my understanding of the specifics of the GIL problem were super hand-wavy & unstructured. So I spent some time collecting resources to learn more, and now have a better understanding! 

#### Python's Infamous GIL (Larry Hastings)
This was a *great* introduction to the history of the GIL, why it was necessary & reasons why getting rid of it is complicated.

<iframe width="560" height="315" src="https://www.youtube.com/embed/4zeHStBowEk?ecver=1" frameborder="0" allowfullscreen></iframe>

#### Understanding the Python GIL (David Beazley)

This has wonderful visualizations that really helped me understand exactly *why* multi-threaded python behaves the way it does. Multithreading decreases performance, adding more cores decreases performance & disabling cores increases performance :) All of this made vague hand-wavy sense to me before, and make much more concrete sense now.

<iframe width="560" height="315" src="https://www.youtube.com/embed/Obt-vMVdM8s?ecver=1" frameborder="0" allowfullscreen></iframe>

#### It isn't easy to remove the GIL (Guido van Rossum)

A [blog post](http://www.artima.com/weblogs/viewpost.jsp?thread=214235) from the BDFL of python, after yet another request to 'just get rid of the GIL'. 

It set the (pretty high) bar for inclusion of a GIL removal patch (that he makes clear he will not write) in Python:

> I'd welcome a set of patches into Py3k only if the performance for a single-threaded program (and for a multi-threaded but I/O-bound program) does not decrease.

Not been met yet!

####  An Inside Look at the GIL Removal Patch of Lore (Dave Beazley)

There was an attempt in about 1999 to remove the GIL - the 'freethreading' patch. This is a [wonderful analysis](http://dabeaz.blogspot.com/2011/08/inside-look-at-gil-removal-patch-of.html) of that patch - what it tried to do, why it disappeared, what the performance costs of it were, etc. Something that really stood out to me and makes me feel not very hopeful about GIL removal in CPython was:

> Despite removing the GIL, I was unable to produce any performance experiment that showed a noticeable improvement on multiple cores. Really, the only benefit (ignoring the horrible performance) seen in pure Python code, was having preemptible instructions.

This seems to be still true, even in the Gilectomy branch.

#### Gilectomy (Larry Hastings)

This is the only talk about a recent (~2016) GIL removal attempt. 

<iframe width="560" height="315" src="https://www.youtube.com/embed/P3AyI_u66Bw?ecver=1" frameborder="0" allowfullscreen></iframe>

It is amazing work, but doesn't give me much hope. There's been no new commits to the [public git repo](https://github.com/larryhastings/gilectomy/tree/gilectomy) for about 5 months now, so am unsure what the state of it now is. 


There's probably many more - let me know if you know any, and I'll update this when I find out more!
