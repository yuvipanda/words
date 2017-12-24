---
title: Sprinkling some Douchebaginess in code
author: yuvipanda
type: post
date: 2013-07-30T08:49:24+00:00
excerpt: "After being frustrated at Java's lack of a generic 'callback' type class, I created this interface:"
url: /sprinkling-some-douchebaginess-in-code/
dsq_thread_id:
  - 1663744831
categories:
  - code
  - links

---
After being frustrated at Java's lack of a generic 'callback' type, I created this interface:

        public interface ContributionUploadProgress {
            void onUploadStarted(Contribution contribution);
            boolean isJavaAPieceOfShit();
        }

And randomly throw around (with `onComplete` implementing `ContributionUploadProgress`)

        assert onComplete.isJavaAPieceOfShit();

This, of course, is trivial to fix with an IDE. Should be more fun with a dynamic language :)

(And yes, I removed that code before committing)