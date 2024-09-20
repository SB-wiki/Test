    * [Needs](#needs)
    * [Proposal](#proposal)

### Needs

1. List of functional tests that are already in place


1. Functional tests written for the new code added/modified in R2.7


1. Figure out a way of how we can publish API functional tests report every release




### Proposal
1. Lists of functional tests<func_repo> have branch/tag relevant to the SB release that contains all the functions tests. 

2. Functional tests written for the code added/modifiedDev team will maintain a [CHANGELOG.md](http://CHANGELOG.md) in the functional-repo that will contain the following details:


```text
release-2.6
------------
v1/user/exists - NEW
v2/user/create - MODIFIED

Total tests = Y
Results = <URL within this repo - results.zip>

release-2.5
------------
v1/org/exists - NEW
v2/org/create - MODIFIED

Total tests = X
Results = <URL within this repo - results.zip>
```
3. API functional tests report every releaseUpdate a results.zip file in every release branch in func-repo. This is overwritten by the next release. \[ **Recommended** ]

4. Demo Report[https://github.com/anmol2302/sunbird-functional-tests/blob/reportPub/sunbird_service_api_test/CHANGELOG.md](https://github.com/anmol2302/sunbird-functional-tests/blob/reportPub/sunbird_service_api_test/CHANGELOG.md)





*****

[[category.storage-team]] 
[[category.confluence]] 
