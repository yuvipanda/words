+++
tags = ["learning"]
date = "2017-05-13T11:41:20-07:00"
title = "think os"
+++

Following a trail from a [wonderful Julia Evans post](http://jvns.ca/blog/2017/04/17/statistics-for-programmers/) led me to Allen Downey's nice [textbook manifesto](http://greenteapress.com/wp/textbook-manifesto/). Also led me to the nice [Think OS](http://greenteapress.com/thinkos/index.html) book, which seems like a super nice introduction to Operating System principles.

It is short enough (~100 pages) that I wanted to read through it. I've spent a good chunk of time absorbing how Operating Systems work by dint of diving into things and working through them, but it would be nice to get a refresher on the basics. There are clearly basic things I do not understand, and this seemed like a good way to explore.

This post is just a running series of notes from me reading it on a nice saturday morning.

## Stack vs Heap ##

This is something that has always bugged me. I've understood just enough of this by being burnt with pointers when writing C (and primitive types in the CLR, etc), but was lacking a deep understanding of wtf was going on. The fact that these are just process program segments (like text or data) was quite a revelation :D [This stackoverflow answer](http://stackoverflow.com/questions/79923/what-and-where-are-the-stack-and-heap) was also quite nice.

One interesting thing for me to investigate later from the book is how this program:


```C
#include <stdio.h>
#include <stdlib.h>

int global;

int main() {
  int local = 5;
  void *p = malloc(128);

  printf("Address of main is %p\n", main);
  printf("Address of local is %p\n", &local);
  printf("Address of global is %p\n", &global);
  printf("Address of p is %p\n", p);

}

```

produces the following output for the author:

```
Address of main   is 0x      40057c
Address of local  is 0x7fffd26139c4
Address of global is 0x      60104c
Address of p      is 0x     1c3b010
```

but for me,

```
Address of main   is 0x5598fc64c740
Address of local  is 0x7ffeacfaf75c
Address of global is 0x5598fc84d014
Address of p      is 0x5598fc85b010
```

The point of the program was to demonstrate that text (`main`), static (`global`) and heap (`p`) are near beginning of memory and stack (`local`) is towards the end. While on my laptop it does seem to be the case too, the 'start' seems to be much farther out than on the author's computer. Need to understand why this is the case. I've vaguely heard of address randomization & other security measures in OS kernels - maybe related? For another day!

## Bit twiddling ##

I continue to find it hard to care about bit twiddling. Most things do use it of course, but it seems to be abstracted away pretty well without leaking too much (except for things that have their own nuances, like floating point representations).

## malloc ##

Nice link to [a paper](http://gee.cs.oswego.edu/dl/html/malloc.html) about a common malloc implementation. I also know there are other malloc implementations that programs use (such as [jemalloc](http://jemalloc.net/)). Something for me to dive into when I've more time.

## tbc ##

I didn't have time to finish it all, unfortunately. But shall come back to it whenever I can!
