---
title: "Note Taking II - Retaining consumed content"
date: 2020-05-24T11:13:57+05:30
lastmod: 2020-05-24T11:13:57+05:30
description: "Criteria for a sytem to help me retain consumed content"
tags: ['productivity']
---

In conversation with [Nirbheek](https://nirbheek.in/) about [my blog post on note taking](http://words.yuvi.in/post/note-taking-part-i/), he said something like 'my system of knowledge has holes, and I lose track of stuff I learnt because of that'. This was slightly complementary to my earlier quest - the outliner helped me in structuring how I thought and produced content. However, a bookmarking system will help me consume and __retain__ knowledge. Both need to be integrated, but I currently had only one half of the puzzle.

We ended up talking about 'bookmarks' and how he has a lot of them. I've felt the need for saving stuff I read in useful ways, but never used bookmarks because I never look at them again. It would be awesome to have a system of that sort - especially if it was integrated into my notetaking and todo list solutions.

We talked about some current solutions - [Pratul](https://twitter.com/prxtl)'s meticulously tagged [pinboard](https://pinboard.in/) account, [Ankur](https://ankursethi.in/)'s blog's [links category](https://ankursethi.in/category/links/). All this was too much work for me, but I couldn't quite articulate why. I've tried both these options before and couldn't keep them up. Longevity was my goal here, so I kept looking.

## Memex

This lead us to [Memex](https://github.com/WorldBrain/Memex), and open source system (with a paid hosted version) that seemed to do everything we wanted. They made a particular point of [not taking VC money](https://github.com/WorldBrain/Memex#no-vc-money-no-exit-your-data--attention-stays-yours), which is a big draw for me.

Nirbheek tried it out, and found it buggy / wanting. Particularly, it only worked on half his bookmarks - the rest had rotten, or the import itself was buggy. This could be fixed with [Internet Archive](https://archive.org/) integration, but there were a few more bugs about data loss in their [issue tracker](https://github.com/WorldBrain/Memex/issues?q=is%3Aissue+is%3Aopen+sort%3Aupdated-desc) that didn't give me too much confidence. It does still look amazing, and I will try it out at some point soon - unlike Nirbheek, I don't have a few thousand bookmarks to import.

However, it gave met he name **Memex**, with a history behind it - an article by Vannevar Bush (Claude Shannon was his student) from 1945 called **[As we may think](https://en.wikipedia.org/wiki/Memex)**. This was an extremely fascinating read - I read it in the [original layout](http://worrydream.com/refs/Bush%20-%20As%20We%20May%20Think%20(Life%20Magazine%209-10-1945).pdf), with fascinating ads by the side (Men's garters, for example).

Here is my [annotated version](/papers/as-we-may-think.pdf), with the origins of the rest of this blog post at the bottom. It's fairly short, so I suggest you read the original. I'm not going to rehash it, but just talk about what I think I need in my 'bookmarking' solution.

## What is a bookmark?

Bookmark is a terrible word for what I want, but I can't think of a better one right now. Bush defines the 'memex' as:

> A memex is a device in which an individual stores all his books, records and communications, and which is mechanized so that it may be consulted with **exceeding speed and flexibility**. It is an **enlarged intimate supplement to his memory**.

(Gendered pronouns in the source left in for for faithful reproduction. I'd like to think that if this was written today, it would use gender neutral pronouns)

So a 'bookmark' is an individual thing that I come across that I might possibly ever want to remember again. I can't remember it all, so I want to toss it into a 'bookmarking system' that can be searched with 'exceeding speed and flexibility'.

Based on this, I figured out my current criteria for looking at & trying out such systems to find one that meets my needs.

## Search first

I want my interface to be a simple text box into which I can type things, and it'll search the entire contents of everything I've 'bookmarked'. This should be articles I've read, books, tweets, videos I've watched, podcasts I've listened to, my notes, etc. I don't want to do any tagging or categorizing myself.

Tagging and categorizing remind me of [dmoz](https://en.wikipedia.org/wiki/DMOZ) and [Yahoo Directories](https://en.wikipedia.org/wiki/Yahoo!_Directory). Way too much work for me, and I'll never look at them again.

Bush calls __selection__ (we would call that 'search' today) as the primary problem , and rails against __indexing__ (IMO we would call this tagging / categorizing) as insufficient.

This search needs to be **extremely fast**, and very relevant.

## Never forgets

I should have access to these 'bookmarks' all the time. This means cross-device sync (Android, iPad, Mac OS for me).

It also needs to actually archive all the content I throw at it. Save web pages fully. Download (and transcribe) videos / podcats. Find some way to keep books in there. No link rot, no 'shit this content is now behind a paywall', no 'damn, I wish I had my laptop with me'.

## Hyperlinking

I should be able to connect bookmarks together. I guess this could be done with tagss, but I want something else that's better. Bush talks about being able to link 'bookmarks' to each other with a blurb about the link - this is what we would call a 'hyperlink' now.

My note taker has hyperlinks with other notes, but I should be able to hyperlink to content I have saved. I should also be able to link together content I've saved that doesn't have links themselves.

Strong integration between this and my note taker is probably the way to go. **Each piece of content should have highlights, and notes attached to them**. These could contain hyperlinks easily. The highlights and notes should also be searchable.


## Publishable

Bush talks about 'trailblazers' - people who find new content, link it together in useful ways, and publish it for others.

This was how I used [Google Reader's Shared](https://en.wikipedia.org/wiki/Google_Reader#Sharing) functionality. You could publish a link with all the content you have consumed that you marked as 'shared', with a note as well. I would subscribe to other people's shared feeds, and find useful content (and blogs) to follow.

RIP Google Reader. It continues to make me wary of relying on any of Google's services.

Having a note taker has already drastically changed how I think and  produce content. I feel integrating this into my life will have similar effects on how I consume content. Now that I have a better idea of what I **want**, I'll spend some more time looking.

## Credits

Thanks to [Nirbheek](https://nirbheek.in/), [Ankur Sethi](https://ankursethi.in/) and [Prateek](https://prtksxna.com/) for conversations and thoughts on this topic :)