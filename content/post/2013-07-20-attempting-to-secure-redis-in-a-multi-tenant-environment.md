---
title: Attempting to Secure Redis in a Multi Tenant environment
author: yuvipanda
type: post
date: 2013-07-20T23:48:43+00:00
excerpt: '[Redis][1] is a supercharged key value store that also '
url: /attempting-to-secure-redis-in-a-multi-tenant-environment/
dsq_thread_id:
  - 1670393412
categories:
  - code
  - devlog
  - wiki

---
When running [Redis][1] in a shared cluster/hosting environment (such as [Wikimedia Tool Labs][2], on which I've been having fun doing a lot of work on), you would want to try to provide at least _some_ guarantee of isolation for your keys from everyone else's keys. Since Redis doesn't do ACLs, this is problematic.

This can be solved in a couple of ways

## Run a Redis instance for each user

This is simple enough to do &#8211; each user runs their own Redis instance, and has full access to it. Security is handled by setting a secret password, and running `redis-server` as the user in question. Boom, secure!

This doesn't really scale with a large number of users, because they each have lesser memory to work with now. Also having users who just want to run their tools have to deal with making sure their Redis instance is up and running fine isn't really good. Having the sysadmins be responsible for users' Redis instance is&#8230; not going to work :) This would also require all the redis instances to run on one box and/or have a separate cluster just for them, which isn't good either.

## Add ACL support to Redis

Not happening, because I'm not good enough to do that yet :P But more realistically, it won't ever happen, since this will probably add a lot of overhead for what is arguably an edge case.

## Build a small server that sits in front of Redis

Such a server would simply authenticate incoming requests via some mechanism ([Keystone][3] perhaps), and then enforce ACLs. It will have to speak the exact same protocol as Redis, since users should be able to use any library that connects to Redis. This isn't too hard &#8211; just replace the `password` functionality of Redis protocol to take in both a username and password (or token, or some other method of auth). 

This also I discarded &#8211; it will still affect performance, which will now be limited by how fast _this_ server runs, and that is definitely not faster than Redis. And it will also be hard to maintain, since I'll have to completely mimic Redis' protocol and make sure it is kept up to date. Debugging protocol issues with random client libraries is not my idea of fun. Another **major** disadvantage is that **I** would now be writing auth code, and I don't think handrolling auth code is a good idea, ever.

## Security By Obscurity!

This is what we finally settled on :D It sounds horrible by the title, but I think it is Good Enough<sup>TM</sup>. 

Since Redis is a key value store at heart, you can do anything once you know the key. So, if an 'attacker' doesn't know the key, there isn't much they can do. So it can be considered SecureEnough for our purposes if we can make it so that other users can not find out or guess your keys.

We essentially did so with the following:

  1. Disable all Redis commands that let users list all / many keys. 
  2. Have users use a random and long key prefix for all their keys.

(1) prevents someone from just listing all keys to find something interesting. (2) prevents people from brute-forcing or guessing keys. Since all code run on Tool Labs must be open source, guessing keys is super easy. By having a 'secret' prefix, having the actual keys is useless. This also prevents accidental key overwrites from different tools using a common key name.

Disabling commands is easy to do by using Redis' `RENAME COMMAND` config feature. I added support for `RENAME COMMAND` to Wikimedia's [Redis puppet module][4], and then it was simple enough to [configure][5] a specific instance to disable 'list keys' type commands. That's the following commands: 

  1. `CONFIG` 
  2. `FLUSHALL` 
  3. `FLUSHDB` 
  4. `KEYS`
  5. `SHUTDOWN`
  6. `SLAVEOF`
  7. `CLIENT`
  8. `RANDOMKEY`
  9. `DEBUG`. 

After going through the list of Redis commands, I am guessing this is going to be GoodEnough to prevent key listing. (Note: if there's more that I'm missing, please, _please_ let me know).

We also tell people to use a secure prefix that's at least 64bytes long, saved in a file that is only user readable. Generating that is as simple as:

openssl rand -base64 64

That should be long enough to be hard to brute force, even with Redis being as fast as it is.

### Problems

The major problem with this is, of course &#8211; the fact that humans are involved :) I've heard "I do not care about my keys, do not need security" a fair amount of times already. The fact that the prefix generation is optional means that there will be people who do not use prefixes, and it will work for them for a (probably) long time &#8211; until it doesn't, and they have no idea why. This is personally acceptable to me, since they have been made aware of the risks beforehand. 

## Fun

This has now been deployed on toollabs for a month or so, and I've a couple of fun tools already written using it (and other people too). We had a patched memcached server we had that we'll kill in a few weeks, so people who used memcached before are also migrating to redis. And I was able to do all this without even having root! This is mostly thanks to the fact that we try to keep all our configuration in puppet ([Wikimedia's Puppet repository][6]) &#8211; for both our production cluster and for everything else. So I could re-use our production redis module, make changes to it, and build the new solution &#8211; all while being vetted by 'proper' ops people (whom I dearly love and respect). Building infrastructure in such a collaborative manner is a lot of fun, and I think I'm hooked. It's fun!

 [1]: http://redis.io/
 [2]: https://wikitech.wikimedia.org/wiki/Nova_Resource:Tools/Help
 [3]: http://keystone.openstack.org/
 [4]: https://github.com/wikimedia/operations-puppet/tree/production/modules/redis
 [5]: https://github.com/wikimedia/operations-puppet/blob/production/modules/toollabs/manifests/redis.pp
 [6]: https://github.com/wikimedia/operations-puppet