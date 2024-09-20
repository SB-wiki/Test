To streamline the process of easier Maintainability and Management of storage account we are categorization the storage account into 4 Major parts.


1. Public Storage Account - For Public Storage assets like portal CDN, Plugins, FAQ html pages.


1. Private Storage Account - For Private Storage assets like druid temp storage, secor backups, user, org, course dashboards.


1. Management Storage Account - For All DB Backups.


1. Artifact Storage Account - Shared by all the environments for Build artifacts.



Further more we use [SAS tokens ](https://project-sunbird.atlassian.net/wiki/spaces/DevOps/pages/1133019396)to have fine grained control for the storage accounts.



*****

[[category.storage-team]] 
[[category.confluence]] 
