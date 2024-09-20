# Other-Jenkins-configurations

**A) Artifact Pushes**

&#x20;  1\. The default configuration is to upload the artifacts (zip, jar etc files) to azure blob and docker containers to the configured container registry.

&#x20;  2\. Docker container push require a hub account mandatorily. But if you decide to not use azure storage blob to store artifacts, then you can change the configuration in Jenkins jobs to disable to push to azure blob.

&#x20;  3\. Go to the Jenkins ArtifactUpload jobs and Deploy jobs and change the order from ArtifactRepo JenkinsJob to JenkinsJob ArtifactRepo

**B) Log rotation**

&#x20;  1\. By default the log rotation for build jobs is configured as 1. Which means only the last built artifact is kept in build jobs and others are deleted. You can change this value in the job configuration.

&#x20;  2\. The log rotation for all other jobs is by default set to 5. Which means the last 5 successful artifacts are stored.

_**Note: When the jenkins-jobs-setup.sh script is triggered, it will overwrite these changes. You can run a simple find and replace using sublime or any other editor to make the configuration changes as per your desire. The find and replace needs to be run on the config.xml files. This can be done even before the jenkins-jobs script runs or later in the /var/lib/jenkins/jobs directory (Take a backup first!)**_

***

\[\[category.storage-team]] \[\[category.confluence]]
