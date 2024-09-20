 **Sonarcloud displays 0 code coverage for Nodejs:** 

The issue was because of sonar language which is mentioned in sonar-project.properties file.

sonar.language=js

Actually the code was in Typescript, we were mentioned language as JS. After updating it to  **ts** , the issue got resolved.



 **Parameter ‘sonar.pullrequest.branch’ is mandatory for a pull request analysis:** 

This issue we will face if we don’t pass  **SONAR_TOKEN**  in CircleCI.

Fix: Add SONAR_TOKEN in environment variables in CircleCI and enable the option pass secrets in CircleCI configuration.

[https://community.sonarsource.com/t/sonarcloud-analysis-for-pr-based-approach/16363/12](https://community.sonarsource.com/t/sonarcloud-analysis-for-pr-based-approach/16363/12)



 **The release-2.7.0 branch has no lines of code for JS:** 

This issue we faced for a few nodejs repositories, issue was because of the node version which we were using, it was version 6. 

Fix: Update the node version by talking to developers for compaitablity.



 **Pusblishing coverage for PR raised from different branches in same repo** 

If a pull request is raised between two branches of the same repository. The sonarcloud analysis for the PR will be in a pending state.

Sonarcloud publish is not working Expected — Waiting for status to be reported

If we push a commit to a branch on Github, CircleCI will trigger a pipeline which will then trigger a SonarCloud analysis on that branch. If we open a pull request for that branch afterward, there will be no new CircleCI pipeline triggered, and therefore there will be no SonarCloud analysis of the pull request. The SonarCloud check will therefore not be satisfied.

If you push changes to an already open pull request, CircleCI will detect that there is a pull request open for that commit. In that case, the SonarCloud analysis will run on the pull request, and it will satisfy the SonarCloud check on the PR.

Temparory fix:  


1. Raise PR from fork for merging branch also.


1. Making a dummy commit after raising the PR, will trigger the circleci for that commit.







 **CircleCI not able to checkout public repo:** 

Isse refernce and fix: [https://discuss.circleci.com/t/circleci-not-able-to-checkout-public-repo/37202/4](https://discuss.circleci.com/t/circleci-not-able-to-checkout-public-repo/37202/4)



*****

[[category.storage-team]] 
[[category.confluence]] 
