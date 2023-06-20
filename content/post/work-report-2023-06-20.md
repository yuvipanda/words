---
title: "Devlog 2023-06-20"
date: 2023-06-20T10:25:11-07:00
lastmod: 2023-06-20T10:25:11-07:00
categories: [workreport]
author: ""

---

Trying to start these back up, as a list of the kind of 'work' I have done
the last few weeks. Let's see if this works!

### Last 2 weeks

1. Spent a good chunk of time investigating and fixing issues with [AzureAD auth](https://github.com/2i2c-org/infrastructure/issues/2628) for the UToronto hub. "Fixing" it meant moving off AzureAD, so we only have CILogon & GitHub in the 2i2c infrastructure as authentication providers! This is now [explicitly mentioned](https://github.com/2i2c-org/docs/pull/187) in our docs. An incident report still needs to be written.
2. Upgraded Azure AKS for UToronto, leading to a pretty gnarly outage. Incident report needs writing. [issue](https://github.com/2i2c-org/infrastructure/issues/2594).
3. Finished setting up the [ClimateMatch hub](https://github.com/2i2c-org/infrastructure/issues/2524). Part of this involved adding terraform support for proper, single-hub nodepools in GCP.
4. With help from @sean-morris, all Cloudbank Hubs now use a [data8 style image](https://github.com/2i2c-org/infrastructure/issues/2435). This has reduced the number of non-staging hubs using the old 'default' 2i2c image to 5! When unspecified, the default image in use now is [jupyter/scipy-notebook](https://github.com/2i2c-org/infrastructure/pull/2671). These communities should be [contacted](https://github.com/2i2c-org/infrastructure/issues/2674) and a different image be used for them, so we do not have to maintain this 'default' image anymore.
5. With the goal of removing special cases from the 2i2c infrastructure, I am working on removing the [manually maintained NFS servers](https://github.com/2i2c-org/infrastructure/issues/1105) from our infrastructure. I had thought only the 2i2c shared cluster had it, turns out the cloudbank one does too! The 2i2c shared cluster has been migrated off, the cloudbank one will be soon. With that, home directories are unified for all clusters, and no longer require specialized knowledge of filesystems, etc to manage.
6. Did a bunch of cleanup work on our terraform code.
   - Remove unused AzureFile SMB support, as we use NFS everywhere. Yay consistency. [Pull](https://github.com/2i2c-org/infrastructure/pull/2676)
   - Fix terraform linting errors and fix the job that was doing the lint to actually do the lint. [Pull](https://github.com/2i2c-org/infrastructure/pull/2677).
   - Use optional fields in our terraform variables, for cleaner `.tfvars` files. [Pull](https://github.com/2i2c-org/infrastructure/pull/2664)
   
### Upcoming week

- Help with stabilizing quarterly goal for next quarter for 2i2c. 
- Finish two incident reports for UToronto so we can close that out:
  - https://github.com/2i2c-org/infrastructure/issues/2628
  - https://github.com/2i2c-org/infrastructure/issues/2594
- See this PR through to completion: https://github.com/2i2c-org/infrastructure/pull/2406. Mostly documentation. 
- See this PR through to completion: https://github.com/2i2c-org/infrastructure/pull/2621. Mostly *upstream* documentation, started in https://github.com/jupyterhub/grafana-dashboards/pull/84.
- Finish moving cloudbank hubs to filestore, decomission old NFS VMs. https://github.com/2i2c-org/infrastructure/issues/1105
