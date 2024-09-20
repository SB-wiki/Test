# Quality-Assurance--Release-Process-&-Strategy

## Process General Details

\| Testing Process for a Release | | The Quality Assurance process is the final gate before a release goes to market, to assess and collectively work on ensuring that a good quality release is developed and deployed, as per the requirements set by the Product management team. | | The testing cycle for a release is a multi-step process. It is initiated when a release scope is identified and continues till the final deployment in market, and post release bug analysis related to that release.

1. To uncover defects in the Release during development and integration
2. To validate that the all new features planned are functioning as per the desired specification
3. To validate that existing product functionality is working as expected and there are no breakages to existing workflow
4. To certify the overall quality of the system and assure high user satisfaction in production

\| | QA Lead, Tester | | The first discussions on scoping of a release marks the beginning of the QA cycle. A period ending 2 weeks from the deployment to production marks the ending of that release cycle for QA | | The stages are:

1. Release Scoping: QA role & participation
2. Test Case Design&#x20;
3. Test Case Execution in Staging environment (System testing)
4. Test Case Execution in pre-prod environment (UAT testing)
5. Final Sign-off and Production Deployment
6. Metrics for the release&#x20;

|

| ---                                                                                                                                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ---                                                                                                                                                                                                                                             |
| ---                                                                                                                                                                                                                                             |
| ---                                                                                                                                                                                                                                             |
| ---                                                                                                                                                                                                                                             |
| Testing Process for a Release                                                                                                                                                                                                                   |
| The Quality Assurance process is the final gate before a release goes to market, to assess and collectively work on ensuring that a good quality release is developed and deployed, as per the requirements set by the Product management team. |
| The testing cycle for a release is a multi-step process. It is initiated when a release scope is identified and continues till the final deployment in market, and post release bug analysis related to that release.                           |

1. To uncover defects in the Release during development and integration
2. To validate that the all new features planned are functioning as per the desired specification
3. To validate that existing product functionality is working as expected and there are no breakages to existing workflow
4. To certify the overall quality of the system and assure high user satisfaction in production

\| | QA Lead, Tester | | The first discussions on scoping of a release marks the beginning of the QA cycle. A period ending 2 weeks from the deployment to production marks the ending of that release cycle for QA | | The stages are:

1. Release Scoping: QA role & participation
2. Test Case Design&#x20;
3. Test Case Execution in Staging environment (System testing)
4. Test Case Execution in pre-prod environment (UAT testing)
5. Final Sign-off and Production Deployment
6. Metrics for the release&#x20;

|

## Process Flowcharts

![](<../../../../Others/ekstepprocess-ind-unknown/images/storage/Test Case Execution.jpeg>)1. Release Scoping: QA role & participation

\| Discussions related to scope of a release is the primary trigger here | |

* Clarity on scope in JIRA will be there
* Create QA plan and share with RM
* Solution owners are identified and on-boarded from the very beginning of the release
* Any planned leaves, known interrupts during this period are identified

\| | QA, Release Manager, Product Manager, Tech Manager | | QA to be involved in the initial scoping discussions. This will enable the team to have a clear view on what is the purpose of a particular release, the exact asks from the Product side & the proposed timelines against which the release is planned

* Get information about the scope of the release + proposed timelines + No. of planned deployments
* Raise known risks & highlight any concerns in implementing testing for that scope
*
  * e.g. current limitation in knowledge for concurrent load testing should be raised upfront
* Do an effort analysis & share with the Release managers (RM) to get a transparent buy-in on how much time will execution take

\| | --- | | --- | | --- | | --- | | Discussions related to scope of a release is the primary trigger here | |

* Clarity on scope in JIRA will be there
* Create QA plan and share with RM
* Solution owners are identified and on-boarded from the very beginning of the release
* Any planned leaves, known interrupts during this period are identified

\| | QA, Release Manager, Product Manager, Tech Manager | | QA to be involved in the initial scoping discussions. This will enable the team to have a clear view on what is the purpose of a particular release, the exact asks from the Product side & the proposed timelines against which the release is planned

* Get information about the scope of the release + proposed timelines + No. of planned deployments
* Raise known risks & highlight any concerns in implementing testing for that scope
*
  * e.g. current limitation in knowledge for concurrent load testing should be raised upfront
* Do an effort analysis & share with the Release managers (RM) to get a transparent buy-in on how much time will execution take

|

## 2. Test Case Design

\| Completed, finalized scope, with PRD's written and linked to the respective story in JIRA is the basic requirement to start the stage | |

* Test cases for all new features will be written and reviewed with respective PM’s
* Regression Test cases will be reviewed internally and updated to absorb all new features of the previous releases. Automation of the regression suite will continue to increase the coverage
* Smoke Test suite will be automated and updated if required
* Sanity Test suite will be automated and updated if required

\| | QA, Product Manager | | QA must be a participant in / active recipient of any discussions which are related to the stories & enhancements tagged to the release. For this they should engage actively in all scrum-of-scrum meetings and grooming sessions.

* Read story & enhancement descriptions in JIRA, raise a comment in case it is found incomplete
*
  * Collate all such tickets end of week, and share a mail with respective PM’s asking for clarity
  * \*\*Add the label for the solution\*\* for each Story/Enhancement/Bug, ensure 100% of the tickets have the respective label
* Identify any gaps in tickets where the respective UI has not been shared or the PRD needs more information
*
  * Write comment in JIRA & send a mail asking for the same
* Start writing Test Scenarios and Test Cases:
*
  * These need to be written in Zephyr/google sheets/other tool
  * In parallel they should be added in the Regression Suite excel sheet under ‘New feature’ type and with the Issue ID
  * These should be maintained solution-wise. Solution owner should remain responsible for the complete writing of test cases for their solution
  * Peer review should be done on the scenarios & test cases in detail
  * Schedule a meeting with the Product Managers for verification of the scenarios/ test cases where written
* Maintain a detailed tracker, in the same excel sheet, which will be auto-updated with the information of execution

\| | --- | | --- | | --- | | --- | | Completed, finalized scope, with PRD's written and linked to the respective story in JIRA is the basic requirement to start the stage | |

* Test cases for all new features will be written and reviewed with respective PM’s
* Regression Test cases will be reviewed internally and updated to absorb all new features of the previous releases. Automation of the regression suite will continue to increase the coverage
* Smoke Test suite will be automated and updated if required
* Sanity Test suite will be automated and updated if required

\| | QA, Product Manager | | QA must be a participant in / active recipient of any discussions which are related to the stories & enhancements tagged to the release. For this they should engage actively in all scrum-of-scrum meetings and grooming sessions.

* Read story & enhancement descriptions in JIRA, raise a comment in case it is found incomplete
*
  * Collate all such tickets end of week, and share a mail with respective PM’s asking for clarity
  * \*\*Add the label for the solution\*\* for each Story/Enhancement/Bug, ensure 100% of the tickets have the respective label
* Identify any gaps in tickets where the respective UI has not been shared or the PRD needs more information
*
  * Write comment in JIRA & send a mail asking for the same
* Start writing Test Scenarios and Test Cases:
*
  * These need to be written in Zephyr/google sheets/other tool
  * In parallel they should be added in the Regression Suite excel sheet under ‘New feature’ type and with the Issue ID
  * These should be maintained solution-wise. Solution owner should remain responsible for the complete writing of test cases for their solution
  * Peer review should be done on the scenarios & test cases in detail
  * Schedule a meeting with the Product Managers for verification of the scenarios/ test cases where written
* Maintain a detailed tracker, in the same excel sheet, which will be auto-updated with the information of execution

|

## 3. Test Case Execution in Staging Environment (System testing)

\| Deployment of the build after code-freeze is the trigger for this stage | |

* Thorough testing of all new features & the regression suite will be done
* All defects raised will be either resolved or converted to bugs/ enhancements before release sign-off is given

\| | QA, Tech Manager, Product Manager | | --- | | --- | | --- | | Deployment of the build after code-freeze is the trigger for this stage | |

* Thorough testing of all new features & the regression suite will be done
* All defects raised will be either resolved or converted to bugs/ enhancements before release sign-off is given

\| | QA, Tech Manager, Product Manager |

Test Environment

Testing will be done in 2 environments: First cycle will be in Staging (Stage 3: System testing cycle) & second cycle will be in Pre-prod (Stage 4: UAT cycle).&#x20;

| Entry Criteria QA                                                                       | Responsibility                                                             | Remarks         |
| --------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- | --------------- |
| 1                                                                                       | Agreed Scope for the release (Functional + Technical) / Actually delivered | Release Manager |
|                                                                                         | - List of added items to the agreed scope of Rel                           |                 |
|                                                                                         | - List of items which have missed the agreed scope of Rel, aligned with PM |                 |
|                                                                                         | - List of partially delivered items which can be deployed and are testable |                 |
|                                                                                         | - All items delivered should be in Released status                         |                 |
| 2                                                                                       | Unit Test report with 75% coverage for each module                         | Program Manager |
| 3                                                                                       | Deployment tracker to be shared and signed off from DC                     | Release Manager |
| 4                                                                                       | Code Freeze > no new features / Bugs will be delivered post delivery to QA | Release Manager |
| Value Add                                                                               | For end user facing story, does it have developer documents in place       | Documentation   |
| API documentation for any new API’s added or existing ones modified needs to be updated | Documentation                                                              |                 |

Each build will follow the process listed below.&#x20;

E-mails:

1. Post deployment, send a mail on:
2.

```
1. how many items in the scope & in the Releases status, how many in Ready for Release status & how many are still open.
```

```
1. Ask for the sanity execution results


1. Raise any mismatch found in the scope delivered, as against scope promised


1. Re-check delivery timelines, & raise a flag if schedule is impacted



```

1. Share a daily status update with all stakeholders regarding the work done update > are we on track / delayed.&#x20;
2.

```
1. Share the Test case execution status: Feature & Solution wise
```

```
1. Share the no. of test cases which have passed/failed/are blocked


1. Share information related to the defects, mapping against solution type and severity


1. If delayed, state the reason why


1. Raise known risks if any, along with mitigation plan



```

Types of testing done:

1. Sanity Test Execution: Every new code deployment, will be followed by a quick sanity test that will assess the stability of code and test environment to ascertain if the build is fit-for-test.
   1. Automation plays a key role here; first the automated suite is run and then all failed test cases are checked manually
2. Functional Testing:&#x20;
   1. New Feature
   2. Regression Testing
   3. P1 scenario testing
   4. Backward Compatibility Testing (up to last 3 builds)
   5. Similar activity will be done for the App as well

Test case Execution task:

1. Run the automated sanity suite- retest failed test cases manually and raise the relevant defects
2.

```
1. If sanity fails due to more than 5 S1 blockers, reject the build
```

1. Use the excel to allocate work within team (solution-wise owner to take ownership)
2. Initiate execution of test cases
3. Raise defects found in JIRA, tag it to the main issue ID.&#x20;
4.

```
1. All defects raised will be either resolved or converted to bugs/ enhancements before release sign-off is given for testing
```

```
1. If a defect is raised & needs to be converted into a bug/enhancement, then follow the specified process



```

Important points to note regarding defects:

1. In case any outsourced individual comes in for a temporary engagement, they will not be allowed to report defects in JIRA directly; these will be shared with the solution owner to check validity of the defect.
2. Defect Triage meeting: Sync up with Rm to schedule a meeting with the Teach Managers to get ETA on defects raised.
3. All defects raised need to be closed/ converted to bugs/ converted to enhancements before release sign-off can be given.

| Exit Criteria: QA | Responsibility                                                                                                             | Remarks |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------- | ------- |
| 1                 | For the Delivered Scope                                                                                                    | QA      |
|                   | - All items in scope which were in Released status should be in closed status                                              |         |
|                   | - All S1/S2 defects on New Feature/Enhancement/Bugs should be closed                                                       |         |
|                   | - All regression defects should be closed irrespective of severity                                                         |         |
|                   | - List of Tech items not tested by QA to be shared                                                                         |         |
|                   | - All defects should be in closed status. S3 defects not being taken up should be converted to bugs after aligning with PM |         |

## 4. Test Case Execution in Pre-Pod Environment (UAT)

A meeting with the DevOps team should be done to arrive at the final tracker for the deployment to prod. The same one will be used in pre-prod as well (any exceptions should be called out).

After sign off from Staging environment, new feature and user experience testing will be done before final sign off for the release. Not in scope: No Regression testing will be done.

| Entry Criteria: UAT | Responsibility                                                              | Remarks         |
| ------------------- | --------------------------------------------------------------------------- | --------------- |
| 1                   | Agreed Scope for the release (Functional + Technical) / Actually delivered  | Release Manager |
|                     | - List of items which have missed the agreed scope of Rel, aligned with PM  |                 |
|                     | - List of partially delivered items which are deployable and testable       |                 |
|                     | - All items (features, stories & Bugs) delivered should be in Closed status |                 |
|                     | - List of Tech items not tested by QA to be shared                          |                 |
|                     | - All defects should be in closed status                                    |                 |
| 2                   | Deployment tracker to be shared and signed off from DC                      | Release Manager |

E-mails:

Share a daily status update with all stakeholders regarding the work done update > are we on track / delayed.&#x20;

1. Share the Test case execution status: Feature & Solution wise
2. Share the no. of test cases which have passed/failed/are blocked
3. Share information related to the defects, mapping against solution type and severity
4. If delayed, state the reason why
5. Raise known risks if any, along with mitigation plan

Test case Execution task:

1. Run the automated sanity suite- retest failed test cases manually and raise the relevant defects
2.

```
1. If sanity fails due to more than 5 S1 blockers, reject the build
```

1. Initiate execution of new feature test cases
2. Complete exploratory testing of all solutions to be done
3. Execute the automated regression suite
4. Complete execution of backward compatibility test cases (up to last 3 builds)
5. Complete execution of P1 test cases written for all P1 bugs raised in the past up to last 3 releases
6. If a defect is raised & needs to be converted into a bug/enhancement, then follow the specified process

HOTFIX VERIFICATION:

In case a hotfix is needed for deployment of a fix for a P1 bug:

1. The Release Manager must call for a meeting with the PM representative, Engineering team, Dev Ops team and QA team to understand the work and inter-dependencies involved
2. Identify the impact area both from engineering and QA perspective for providing a holistic fix for the bug; ensure that the RCA is already done/ planned to be done
3. The timelines and scope of the hotfix should be arrived at and circulated with all relevant stakeholders; any changes to either should be duly updated to all
4.

```
1. It should be kept in mind that 2 or more hotfixes should not be given with a very small gap of each other
```

1. Hotfix gets deployed directly on pre-prod and does not go through a testing cycle in Staging
2. Identify the set of test cases which need to be executed for testing, update the same in the Jira ticket as well.
   1. Reach out the PM and TM for a sign off on the test cases shared, update as per review comments
3. Once deployment is complete, plan for testing; if deployment is scheduled at night, identify the set of people who would be working at night time
4. Send a status update mail:
   1. Identify test cases which have failed, if any
   2. Share the scope of testing done, including the identified test cases plus sanity plus backward compatibility etc.

## 5. Final Sign-off and Production Deployment

| Exit Criteria: UAT | Responsibility                                                                                                             | Remarks             |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------- | ------------------- |
| 1                  | For the Delivered Scope                                                                                                    | Implementation Team |
|                    | -All items in scope which where in Released status should be in closed status                                              |                     |
|                    | - All S1/S2 defects on New Feature/Enhancement/Bugs should be closed                                                       |                     |
|                    | - All regression defects should be closed irrespective of severity                                                         |                     |
|                    | - List of Tech items not tested by QA to be shared                                                                         |                     |
|                    | - All defects should be in closed status. S3 defects not being taken up should be converted to bugs after aligning with PM |                     |
| 2                  | Documentation of Release Notes should be complete                                                                          | Documentation       |
| 3                  | Sign off to be given post Go/No Go meeting                                                                                 | Implementation Team |

## Process Metrics

1. Regression traceability index: Completeness of Regression test suits
2. Functional traceability index: Test Coverage of New Functionalities being built in the release
3. Test efficiency: Total defects identified by QA against the total defect introduced by the engineering team during the development process
4. Defect Leakage Rate to Production -> Rate at which the defects leaked into Production undetected
5. Defect Leakage Rate to UAT-> Rate at which the defects leaked into UAT undetected
6. Planned Functional Test cases Vs Actual Functional Test Cases
7. Planned Regression Test cases Vs Actual Regression Test Cases

## Process Metrics

***

\[\[category.storage-team]] \[\[category.confluence]]
