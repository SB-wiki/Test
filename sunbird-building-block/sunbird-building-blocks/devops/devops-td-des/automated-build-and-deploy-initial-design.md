# Automated-Build-and-Deploy---Initial-Design

![](../../../../DevOps/devops-td-des/images/storage/SunbirdCICD-New-approach.png)

The idea is to automate the build and deployment of various Jenkins jobs to a specific environment based on Github tags.

Development team will provide couple of information which will be used in the automated build and deployment.

**What is required from the development team?**

* Deployment job name
* Github tag for the build job

Prerequisite for this is the development team will create the tag for their respective github repositories using a Jenkins job.

The current plan is to have a private Github repository which will consists of a file named **deploy.txt** . The contents of this file will look like below:

**deploy.txt**

Learner | release-2.9.0\_RC1

Player | release\_2.9.0\_RC5

The development team will create the tag and update the **deploy.txt** file with their deployment job name and the Github tag.

Optional: We can skip the tag creation for the environment if its OK and just use the branch’s latest commit. Before promotion to next environment, we can create a final tag.

**What happens next?**

* We will create a new Jenkins job in the specific environment which will poll this repository periodically.
* We will set a time slot for polling this repository - Lets say daily from 4PM - 6PM.
* Based on the job names, the respective build, upload and deploy jobs will be triggered.

**How it works in background?** Jenkins Jobs Mapping:

* We will have a map / dictionary which keeps track of the build and upload job for a specific deploy job. Example (this is still in inception on the format of the data structure) -

```json
{
  "Learner":
  {
    "build": "Build/Core/Learner",
    "upload": "ArtifactUpload/dev/Core/Learner",
    "deploy": "Deploy/dev/Core/Learner"
  }
}
```

* We will read the file **deploy.txt** from Github repository and then look for the job names updated by the development team.
* We will then loop through the file and parse the above Json map to identify what is the build, upload and deploy job.
* We will trigger these and wait for completion and then a slack / email notification will be sent.
* We will also probably have a array of parameters for the various jobs - This is still in inception and we haven’t decided whether we should have this or anything else, but putting out the idea here -

```
Learner[] = ["private_banrch", "branch_or_tag"]
Yarn[] = ["private_banrch", "branch_or_tag", "jobs_to_deploy"]] ]></ac:plain-text-body></ac:structured-macro><p /><h4>Identifying new entries based on commits:</h4><ul><li><p>We will store the current HEAD commit in a file after each run of the automated Jenkins job. Example -</p></li></ul><blockquote><p>lastCommit.txt</p><p>d0a5b1f9922dea2a18cff9e6fdcf48a4880ae061</p></blockquote><ul><li><p>When the next polling happens, lets assume we poll every 10 minutes, we will take a diff for the current HEAD and the commit which we inserted into the file</p></li></ul><ac:structured-macro ac:name="code" ac:schema-version="1" ac:macro-id="e410dca5-d016-42a6-9471-c45cb49ccf5d"><ac:plain-text-body><![CDATA[git diff d0a5b1f9922dea2a18cff9e6fdcf48a4880ae061 HEAD deploy.txt
Learner | release-2.9.0_RC2
Player | release_2.9.0_RC6
```

* Once we get this info, we will do a loop of this content and trigger the jobs.

Note: If we see that a same job is currently running from the previous poll and a new entry for same job is found in a new commit, we will force kill the currently running jobs from any of the phases (Build / Upload / Deploy), and trigger it again with the new information

Unique jobs which have more / different Jenkins jobs parameters:

* We will rename few jobs to distinguish them - Example - The name of the job Yarn is same in KP and DP. So we will rename it to DPYarn and KPYarn in order to distinguish the jobs in the automated code.
* Few jobs have a different set of parameters than most of the jobs, so such jobs will need some more additional information from the development team.
* Lets take the example of DataPipeline Yarn job which requires additional information on whcih Yarn job to deploy.
* So for all such unique jobs, we will accept additional inputs in below format (still in inception phase)

**deploy.txt**

DPYarn | release-2.9.0\_RC1 | DeDuplication\_1

( If more then one samza job is required to be deployed, then we will take it as a comma separated values as show below )

DPYarn | release-2.9.0\_RC1 | DeDuplication\_1, DeNormalization\_1, TelemetryExtractor\_1

Different tags for build and deployment jobs:

* The build code repository of many jobs is different as compared to deployment code repository. Example - Leaner service is built from **sunbird-lms-service** repository but the deployment scripts resides in **sunbird-devops** repository.
* In such cases we have two options -
  * Ask the development team to give the deployment tags also which will complicate the **deploy.txt** file as we will be asking more data and we need to keep track of these and parse them accordingly
  * Create a new tag for the deployment code repository automatically before deployement
  * Just the the branch instead of tag and we can provide a final tag before promoting to new environment

Challenges:

* Maintaining the map of build, upload and deploy jobs, adding new jobs etc.
* Maintaining the map of parameters for different types of jobs, adding new types of Jenkins parameters
* How will we handle parallel builds? More info below.

Parallel builds challenge:

* Few jobs cannot be run in parallel such as Learner and LMS due to conflicting jars. There are more of such examples which we will not discuss in this article.
* How will we parallelize the build sequencing and order.
* If we see an entry for LMS and Learner, we should do sequential builds but if we see entry for LMS and Telemetry, we can do parallel builds.
* This order / sequencing must be stored somewhere and a logic to prepare this order dynamically based on entries should be implemented.

Artifact Promotion through Github commits (We are far from this currently):

* We can use the same commit history of jobs from the repository and use it to automate deployments to next environment.
* We will have the same logic of having commit tracking in a file and performing a **git diff** . The only new difference will be to take the job name as a unique value with latest tag as there maybe multiple entries for same job with different tags.
* We are still far away from implementing this, but if the design is implemented, we can use the same workflow for promotion and also publishing to adopters

***

\[\[category.storage-team]] \[\[category.confluence]]
