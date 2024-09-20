
### What is jenkins shared library?

* In short, shared library is the set of common code that you can store in one place and reuse across any  Jenkinsfile and github repositories.


* We can achieve DRY principle by using share libraries


* For more details, please read this doc - [https://www.jenkins.io/doc/book/pipeline/shared-libraries/](https://www.jenkins.io/doc/book/pipeline/shared-libraries/)




### Shared library location

* All the jenkins shared libraries are present here - [https://github.com/project-sunbird/sunbird-devops/tree/shared-lib](https://github.com/project-sunbird/sunbird-devops/tree/shared-lib)


* In jenkins, under the Manage Jenkins → Configuration page, there is a shared library section. We need to configure use the branch and repo in this configuration




### Updating shared libraries

* When updating shared libraries, its not recommended to directly update the changes in the branch


* This has a large blast radius and can cause all the jenkins jobs to stop working, including adopter jenkins machines


* As a good practice, a new branch should be created and changes should be tested from this new branch


* The new branch can be configured on jenkins for a few days to ensure that the changes are working as expected and do not break any flows


* Once verified, the changes should be merged back to the shared-lib branch so that the community can also get the benefit of these changes




### Shared Library Code Reference

* Jenkinsfile indicating the use of shared library - [https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L1](https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L1)


    * This name should be configured on Jenkins also with the same name deploy-conf



    
* Invocation of one of the shared library - [https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L36](https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L36)


    * To call the shared library, use the name of the file without the extension



    
* The shared library code that runs on invocation - [https://github.com/project-sunbird/sunbird-devops/blob/shared-lib/vars/ansible_playbook_run.groovy](https://github.com/project-sunbird/sunbird-devops/blob/shared-lib/vars/ansible_playbook_run.groovy)


* Another shared library invocation reference - [https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L48](https://github.com/project-sunbird/sunbird-devops/blob/master/pipelines/provision/cassandra/Jenkinsfile#L48)


* Another shared library code that runs on invocation - [https://github.com/project-sunbird/sunbird-devops/blob/shared-lib/vars/slack_notify.groovy](https://github.com/project-sunbird/sunbird-devops/blob/shared-lib/vars/slack_notify.groovy)


* The share libraries work exactly like function calls of any programming language


* You can pass parameters / arguments and also return back values to callers from shared libraries




### List of Shared Library Code

* All the shared library codes are located here - [https://github.com/project-sunbird/sunbird-devops/tree/shared-lib/vars](https://github.com/project-sunbird/sunbird-devops/tree/shared-lib/vars)


* ansible_playbook_run.groovy


    * Clone private repo, copies the inventory to appropriate locations, runs the ansible playbook



    
* artifact_download.groovy


    * Downloads provided artifact from cloud storage



    
* auto_build_deploy.groovy


    * Used in staging automated deployments to automatically trigger the artifact upload and deploy jobs



    
* auto_build_deploy_player.groovy


    * Used in staging automated deployment of Player job to automatically trigger the artifact upload and deploy jobs



    
* copy_file_to_wksp.groovy


    * Allows a user to upload a file from Jenkinsjob and copy to workspace



    
* deployed_versions.groovy


    * Gives the list of jobs deployed in a release along with the tags (This job needs some enhancement. Currently the data returned is partially correct)



    
* docker_params.groovy


    * Used in container workload jenkins job to return information about few parameters to the caller



    
* email_notify.groovy


    * Used to send email notifications on the job status



    
* lp_dp_params.groovy


    * Used in non-container workload jenkins job to return information about few parameters to the caller



    
* pre_checks.groovy


    * Used in automated deployment jenkinsfiles to ensure the tag is an allowed tag for staging environment and the deployment is triggered in the allowed window / slots (start and end time)



    
* slack_notify.groovy


    * Used to send slack notifications on the job status



    
* stagingRC.groovy


    * Used in staging tag creation jenkinsfile to ensure the tag is an allowed tag for staging environment and the deployment is triggered in the allowed window / slots (start and end time)



    
* summary.groovy


    * Used to write the deployed jobs information in a file so that its easy to retrieve the list of deployed jobs in a particular release (this job can be enhanced to provide the data in an enhanced way so that it can be consumed without additional parsing)



    



*****

[[category.storage-team]] 
[[category.confluence]] 
