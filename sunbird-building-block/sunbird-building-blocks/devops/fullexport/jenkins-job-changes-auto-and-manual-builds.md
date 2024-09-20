# Jenkins-job-changes---Auto-and-Manual-builds

As part of release-3.7.0, all configuration access in jenkins, rancher and VM’s are removed for everyone working on sunbird. This will require some changes in the jenkinsfile code. Please refer to these PR’s for information on how to update your build jenkinsfiles.

[https://github.com/project-sunbird/sunbird-core-dataproducts/pull/107](https://github.com/project-sunbird/sunbird-core-dataproducts/pull/107) (For non docker builds)

[https://github.com/project-sunbird/sunbird-analytics-service/pull/43](https://github.com/project-sunbird/sunbird-analytics-service/pull/43) (For docker builds)

None of the staging automated jenkins files need this change. The staging automated jenkins files are named as auto\_build\_deploy

With the new change, the build job looks like this -

![](<../../../../DevOps/FullExport/images/storage/Screenshot from 2021-02-11 17-43-16.png>)In the paramater called github\_release\_tag the default value will be refs/heads/${public\_repo\_branch}

${public\_repo\_branch} will always point to latest release version. As of today, it release-3.7.0.

Even with this change, polling scm works and any new commits merged to the release branches will be auto built and deployed.

There are some points to be noted here on the SCM polling and how it works -

**Release propagation:**

* The first build of a release must be triggered manually.
* When we move to release-3.8.0, the value of ${public\_repo\_branch} will be release-3.8.0. But any PR merges or commits will not be auto built and deployed automatically.
* The PR owner (very first PR of the release branch) has to trigget the job manually by clicking Build with Parameters. You don't have to change the refs/heads/${public\_repo\_branch} as ${public\_repo\_branch} will already be pointing to release-3.8.0. Just build the job.
* Once the first commit of a release branch is built, any new commits or PR merges will be automatically built.

**Hotfixes propagation:**

* Again this flow also follows the same principle, but requires an additional step.
* Lets say we are in release-3.7.0 and you want to send a hotifx to release-3.6.0.
* You would like to test this hotfix first in dev before sending to preprod / prod.
* In that case, you can go to the jenkins job (AFTER YOUR PR IS MERGED, since you cannot use your forked repos anymore), change the value of refs/heads/${public\_repo\_branch} to refs/heads/release-3.6.0 and then build the job.
* You are happy your fix is working, but you have stopped all automated builds of your job. Since now the SCM polling will keep checking release-3.6.0 branch for new commits to be built automatically.
* You need to ensure that after you verify your fix in dev, go back to the job and run the job again with the latest release branch using refs/heads/${public\_repo\_branch}.
* Or else your team mates latest release changes will not be auto built and deployed.
* This is the responsibility of the developer who works on the hotfix. He has to revert back the dev environment to latest release version after verifying the hotfix.

**Sunbird Adopters Use Case:**

* In terms of adopter use, no functionality has changed. Except we will ship the config files with the default value as refs/tags/${public\_repo\_branch} instead of refs/heads/${public\_repo\_branch} since adopters always use tags to build their tag.
* For Diksha or any other other adopter who usually builds on RC tags, they will use something like this refs/tags/release-3.7.0\_RC1
* Even just using release-3.7.0\_RC1 will work. This will not work only when we have a branch and a tag both with same name. In that case, it would be ambigious and Jenkins can checkout either of them, whichever comes first.

***

\[\[category.storage-team]] \[\[category.confluence]]
