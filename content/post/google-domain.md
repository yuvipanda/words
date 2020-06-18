---
title: "Check if an organization is using GSuite"
date: 2020-06-18T17:01:34+05:30
lastmod: 2020-06-18T17:01:34+05:30
keywords: []
description: "Can you use Google OAuth for an org's SSO?"
categories: ["code"]
---

I needed to find out if an organization was using [GSuite](https://gsuite.google.com/) for their emails, so I can allow their users to login to a [JupyterHub](https://github.com/berkeley-dsep-infra/datahub/tree/ab2bf49be680480cf9de07968561257e7810850f/deployments/buds-2020) I was setting up. I use Google Auth in other places, so I wanted to find out if this organization was using GSuite.

I could've just *asked* them, but where's the fun in that? Instead, you can use `dig` to find out!

For example, if I were to test `berkeley.edu`, I can run:

```bash
$ dig -t mx berkeley.edu
```

This gives me a bunch of output, the important bits of which are:

```
;; ANSWER SECTION:
berkeley.edu.		242	IN	MX	5 alt1.aspmx.l.google.com.
berkeley.edu.		242	IN	MX	10 alt3.aspmx.l.google.com.
berkeley.edu.		242	IN	MX	10 alt4.aspmx.l.google.com.
berkeley.edu.		242	IN	MX	1 aspmx.l.google.com.
berkeley.edu.		242	IN	MX	5 alt2.aspmx.l.google.com.
```

This means that mail to `anyone@berkeley.edu` is routed via Google, so I know this organization is using GSuite for their users!