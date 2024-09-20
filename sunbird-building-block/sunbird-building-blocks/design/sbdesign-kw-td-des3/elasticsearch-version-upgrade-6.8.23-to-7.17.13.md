
## Introduction
This document serves as a comprehensive guide for upgrading Elasticsearch within  _Sunbird Knowlg_ 

 \[Specifically in  _knowledge-platform, knowledge-platforms-jobs and sunbird-dial-service_ ]. We will transition from version 6.8.23 to the more secure version 7.17.13.


## Overview
The primary goal of this upgrade is to enhance security by addressing vulnerabilities present in Sunbird Knowlg, which currently uses Elasticsearch version 6.8.22. Upgrading to version 7.17.13 will mitigate these vulnerabilities.


## Background
Sunbird Knowlg currently relies on Elasticsearch 6.8.23, which has been identified as having security vulnerabilities. Upgrading to version 7.17.13 will mitigate these risks and improve overall system security and performance.


## Problem Statement
Security evaluations using Trivy have revealed vulnerabilities in the current Elasticsearch version 6.8.23 utilized by Sunbird Knowlg. Upgrading to version 7.17.13 is necessary to reduce these vulnerabilities.


## Proposed Solution

1.  **Backup existing data and Restoration:** 


    * Before proceeding with the upgrade, it's essential to back up all existing data and configurations to prevent data loss and ensure a smooth transition. In both local and Azure environments, we recommend utilizing Elasticsearch's [snapshot and restore functionality](https://www.elastic.co/guide/en/elasticsearch/plugins/6.8/repository.html) for efficient and incremental backups.


    * Additionally, in the Azure environment, you can use the rolling upgrade approach for seamless Elasticsearch node updates.



    
1.  **Upgrade Dependencies and Compatibility Testing:** 


    * This includes making changes to your project's pom.xml file, updating the Elasticsearch dependency to version 7.17.13, and ensuring compatibility with other components or libraries reliant on Elasticsearch.


    * In addition to upgrading Elasticsearch itself, it's essential to check compatibility of any other dependencies that are tied to the Elasticsearch version. 



    
1.  **Adapt Code:** 


    * Address any code that relies on deprecated Elasticsearch APIs or data types. Find equivalent replacements in the 7.17.13.


    * Update field mapping syntax if necessary.



    
1.  **Post-Upgrade Validation :** 


    * Verify that all core functionalities of Sunbird Knowlg that rely on Elasticsearch, such as search queries and indexing, continue to work as expected.



    


## Conclusion
Upgrading to Elasticsearch version 7.17.13 is crucial to fix known vulnerabilities and improve the security and stability of Sunbird Knowlg. Following these steps will help achieve a seamless upgrade, reducing risks related to vulnerable software.













*****

[[category.storage-team]] 
[[category.confluence]] 
