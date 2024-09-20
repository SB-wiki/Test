The following process will be followed to update the Sunbird release upgrade document after QA sign off the release in the Sunbird staging environment


## Process

* Get all the build and deployment job details from the Jenkins server of the development environment


* Get manual configuration details from Sunbird Deployment Tracker (Google sheet). This sheet is used to update any manual configuration or infrastructure-related information in the development cycle


* Update Sunbird release upgrade documentation under the current release branch (pre-release)




## How to get the job Details?

* All Deployment jobs from the tracker sheet


* All other job summaries from deploy/staging/summary Jenkins job


    * filter for specific release cat /tmp/alljobs.txt| grep 3.9.0 > /tmp/release-jobs.txt


    * Create a google sheet with headers


```
name	image	artifact
```

    * Paste all contents from release-jobs to the sheet


    * Delete columns with public and private branch


    * Remove all duplicate jobs, and keep the job with the latest artifact image in the sheet.



    
* Put the contents from /tmp/release-jobs.txt to  


* Form configurations: point to SB Jira tickets


* Flink jobs Details should get from developer


    * As flink jobs will be mixed bucket in dev.



    


## Order of jobs

* DB migrations


* Schema uploads


* Manual run


* Regular build and deployments


    * Check for the order


    * Utkarsha for DP


    * Amit for User Org


    * Pradyumna for KP


    * Rajeev for portal and offline installer


    * Harish for content player



    

    





*****

[[category.storage-team]] 
[[category.confluence]] 
