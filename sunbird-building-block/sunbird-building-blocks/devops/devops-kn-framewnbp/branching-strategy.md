# Branching-strategy

Project-Sunbird / Sunbird-Ed repos adhere to generalized branching strategy.

## Naming Convention

1.  Active development will be happening in the latest release-x.y.z branch.

    For example release-3.0.0
2.  Releaseable code will be tagged as Release Candidates with numbers.

    For example release-3.0.0\_RC1
3.  In the case of hotfixes, that’ll be tagged as release-x.y.z+1.

    For example release-3.0.1

![](../../../../DevOps/devops-kn-framewnbp/images/storage/3D-JPnaVJWUYBf1JVkJkC-cK\_hHqUnBZwq42\_6LpUxnaD4aTnTtBKqqKat09OA9QcaD9QL9Lj3Br3gWlVxrQHK0uMcINFHVC6jYusABAHJ3DSak0UzjJF3JF7y2Mc1dwsbLZHRhVLpA)

## Pull Requests

Development for any project should be done on the forks. For example, if you’re working on a feature in Sunbird Portal in release-3.0.0, then you should fork the repo, and develop your feature in the specific release version tag, say release-3.0.0

## Code Quality

Every repo has CircleCI ( for running test cases ) and SonarCloud ( for code-coverage ) enabled for code quality reports.

Test cases are a must for all new codes.

***

\[\[category.storage-team]] \[\[category.confluence]]
