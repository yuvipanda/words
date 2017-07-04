+++
date = "2017-07-02T22:47:06-07:00"
title = "designing data intensive applications"
tags = ["learning"]

+++

I've been reading [Designing Data Intensive Applications](http://dataintensive.net/) book & am using this post to keep notes!

I've picked up ideas on scaling systems through the years, but never actually sat down to actually study them semi-formally. This seems like a great start to it!

It's a pretty big book, and it's gonna take me a while to go through it :) Will update these notes as I go! Trying to do a chapter a week!

## Chapter 1: Defining all the things

> The Internet was done so well that most people think of it as a natural resource like the Pacific Ocean, rather than something that was man-made. When was the last time a technology with a scale like that was so error-free?
> Alan Kay, in [interview with Dr Dobb’s Journal (2012)](www.drdobbs.com/architecture-and-design/interview-with-alan-kay/240003442)

I keep forgetting what an amazing marvel the internet is and how intensely (and mostly positively, thankfully) it has affected my life. This is a good reminder! However, perhaps to people who haven't had the privileges I've had the Internet doesn't feel like a natural resource? Unsure! Should ask them!

Lots of modern applications are data intensive, rather than CPU intensive. 
>  Raw CPU power is rarely a limiting factor for these applications—bigger problems are usually the amount of data, the complexity of data, and the speed at which it is changing.

This has borne out in the infrastructure I've been setting up to help teach people data science - RAM is often the bottleneck, not CPU (barring machine-learning type stuff, but they want GPUs anyway).

Common building blocks for data intensive applications are:

1. Store data so that they, or another application, can find it again later (databases)
2. Remember the result of an expensive operation, to speed up reads (caches)
3. Allow users to search data by keyword or filter it in various ways (search indexes)
4. Send a message to another process, to be handled asynchronously (stream processing)
5. Periodically crunch a large amount of accumulated data (batch processing)

These *do* seem to cover a large variety of bases! I feel fairly comfortable in operating, using and building on top of some of these (databases, caches) but not so much in most (never used a search index, batch processing, nor streams outside of redis). Partially I haven't felt an intense need for these, but perhaps if I understand them more I'll use them more? I've mostly strived to make everything stateless - but perhaps that's causing me to shy away from problems that can only be solved with state? /me ponders.

Boundaries around 'data systems' are blurring - Redis is a cache but can be a message queue, Apache Kafka is a message queue that can have durability guarantees, etc. Lots of applications also need more than can be done with just one tool (aka a 'pure LAMP' stack is no longer good enough). Applications often have the job of making sure different data sources are in sync. Everyone is a 'data designer', and everyone is kinda fucked.

Talk about 3 things that are most important to any software system.

### Reliability

Means 'continue to work correctly, even when things go wrong'. Things that go wrong are 'faults', and systems need to be 'fault-tolerent' or 'resilient'. Can't be tolerant of all faults, so gotta define what faults we're tolerant of.

Fault isn't failure - fault is when a component of the system 'deviates from its spec', *failure* is when the system as a whole stops providing user server they want. Can't reduce chances of fault to zero, but can work on reducing failures to zero. 

**Engineering is building reliable systems from unreliable parts.**

Chaos monkeys are good, increase faults to find ways to reduce failure.

Hardware reliability - physical components fail. Nothing you can do about it. Fix it in software.

Hardware faults *usually* not corelated - one macine failing doesn't cause another machine to fail. To truly fuck shit up you need software - can easily cause massive large scale failure! For example, a leap second bug! Or a runaway process that slowly kills every other process on the machine. One of the microservies that 50 of your microservices depend on is slow! Cascading failures! These bugs all lie dormant, until they suddenly aren't and wreak havok. The software makes some assumption about its environment, which is true until it isn't. No quick solution to systematic software faults.

Human error is worst error. The book offers some suggestions on how to prevent these.

1. Minimize opportunities for errors - make it easy to do the right thing. But if it's too restrictive, people will work around it - tricky balance.
2. Provide full featured sandboxes so people can fuck around without fucking shit up.
3. AUTOMATICALLY TEST EVERYTHING so when a human does fuck up, they know!
4. Set up undo functionality, so when human does fuck up, they can roll back!

Learn about telemetry from other disciplines that have been doing this shit for far longer than us. [Relevant XKCD](https://xkcd.com/1831/)

Reliability isn't just for nukes & aircraft & election systems (haha). Imagine someone loses a video of their kid's first ever step because you didn't care. Fucking up is human and we all do it - what is important is that we care.

Sometimes you gotta sacrifice reliability, but make sure that is an explicit & conscious decision. Actually throw away your prototypes! Put FIXMEs in your code. Take a shower. Make sure hacks look, feel and sound hacky!

### Scalability

System's ability to adapt to increased 'load' along some axes. 

Load is described with various *load parameters*, which depend on the system (req/s? active users? etc).

Carefully define what this means for your application, and explain your reasoning. You might have to scale in some aspects but not in other.

Once you have the load parameters for your app defined, figure out what happens when you increase load parameters but keep system resources unchanged. After that, try to figure out how much resources need to be increased.

Throughput - number of things that can be done per second. Latency is time it takes to serve a request. These are common things we care about when we move load parameters up and down. 

You shouldn't think of these as single numbers, since they vary a fair bit. Think of these as *probability distributions*. Learn some statistics! Use percentiles, rather than 'average' or 'mean'. 

High percentile latencies are especially important when you are a service that's called by many other services - it can cascade down. 

No *magic scaling sauce* - architecture that can scale is different for each application. But there are general purpose building blocks, so worry a little less!

### Maintainability

> Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.

Split into three major aspects.

**Operability**

Make it easy for people to operate your service! Help them monitor the health of the system, observe & debug problems, do capacity planning, keep the production environment stable, prevent single human points of failure (oh, only Chad knows about this system) and many other things!

**Simplicity**

Don't make your software a big ball of mud. Take into account that new engineers will have to start working on your software, and they need to understand it quickly.

Use standard tools & approaches they have a higher likelihood of knowing - look around for standard tools before inventing your own!

Watch out for accidental complexity, and keep it to a minimum as much as possible. Abstractions are good, but abstractions are also leaky.

**Evolvability**

If your software is simple & has good abstractions, you can change it over time without wanting to pull all your hair out.
