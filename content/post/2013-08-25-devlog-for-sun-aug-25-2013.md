---
title: DevLog for Sun, Aug 25, 2013
author: yuvipanda
type: post
date: 2013-08-25T23:44:25+00:00
excerpt: "DevLogs have been something I've not been writing much of of late. Time to fix that!"
url: /devlog-for-sun-aug-25-2013/
dsq_thread_id:
  - 1661788937
categories:
  - code
  - devlog
  - wiki

---
DevLogs have been something I've not been writing much of of late. Time to fix that!

## WLM Android App

Spent some time [reviving the WLM Android App][1]. Wasn't too hard, and am surprised at how well it still runs :) Some work still needed to update the [templates][2] and other metadata to refer to WLM2013 rather than WLM2012 &#8211; but that should not be too hard. The fact that it is an issue at all is simply because I ripped out all the Campaign related APIs a few weeks ago with my UploadCampaign rewrite. 

[multichill][3] was awesome in moving the [Monuments API][4] to [Tool Labs][5] &#8211; hence making it much faster! Initially we thought that the Toollabs DB was too slow for writes &#8211; but this turned out to be a mistake, since apparently the Replica Databases had slow writes, but `tools-db` itself was fine. There's [a bug][6] tracking this now. Toollabs version of the API still seems much faster to me than Toolserver's :)

## UploadCampaigns API

Mediawiki sucks. Eeeew! Specifically, writing API modules &#8211; why can't we just be happy and have everything be JSON? Sigh!

I'm adding [a patch][7] that allows [UploadCampaigns][8] to be queried selectively, rather than just via the normal page APIs. Right now, this only lets us filter by `enabled` status &#8211; but in the future, this should be able to also filter on a vast array of other properties. Properties about Geographic location come to mind as the most useful. That patch still has a good way to go before it can be merged (continue support being the foremost one), but it is getting there :)

The ickiest part of the patch is perhaps that it sends out raw JSON data as a&#8230; string. So no matter which format you are using on your client, you _need_ to use a JSON parser to deal with the Campaigns data. This sortof makes sense, since that is how the data is stored anyway. Doesn't make it any less icky, though!

Not bad for a lazy Sunday, eh?

**Update**: After not being able to sleep, I also submitted [a patch][9] to make phpcs pass for UploadWizard, and also fought with the UploadCampaigns API patch to have it (brokenly?) support continuing. Yay?

 [1]: http://lists.wikimedia.org/pipermail/wikilovesmonuments/2013-August/006249.html
 [2]: https://github.com/wikimedia/WLMMobile/commit/113d9abf7b675b147ece3f2be005ef1b6ba0e4cf#assets/www/js/campaigns-data.js
 [3]: https://commons.wikimedia.org/wiki/User:Multichill
 [4]: https://tools.wmflabs.org/heritage/api/api.php
 [5]: https://tools.wmflabs.org
 [6]: https://bugzilla.wikimedia.org/show_bug.cgi?id=48851
 [7]: https://gerrit.wikimedia.org/r/#/c/80782/
 [8]: https://www.mediawiki.org/wiki/Extension:UploadWizard/Campaigns
 [9]: https://gerrit.wikimedia.org/r/#/c/80946/