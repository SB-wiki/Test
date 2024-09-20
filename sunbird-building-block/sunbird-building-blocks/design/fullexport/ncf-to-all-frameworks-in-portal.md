# NCF-to-All-Frameworks-in-Portal

\| 1.13 | | [SB-9293 System JIRA](https://browse/SB-9293) | | DRAFT | |

|

| ---                                           |
| --------------------------------------------- |
| ---                                           |
| ---                                           |
| 1.13                                          |
| [SB-9293 System JIRA](https://browse/SB-9293) |
| DRAFT                                         |
|                                               |

|

### Background

Today, the generic portal and the custodian org has NCF framework as the default framework. This isn't ideal because the NCF framework is a catch-all framework which doesn't have state specific nuances of subjects, classes and further concepts.

With more users anticipated on the custodian org with self sign up opening up and the launch, there is a need to ensure that users belonging to the custodian org will be allowed to choose from all boards and a medium, class and subject (as supported by the states).

SolutionIn the portal, after a user successful logs in, the user is shown a mandatory onboarding popup to select Board, Medium, Class and Subject. In case a user belongs to custodian org,

![](<../../../../Design/FullExport/images/storage/Sunbird (1).png>)

**Step 1:** 1.  It will call [Get channel api](http://docs.sunbird.org/latest/apis/framework/#operation/ChannelV1ReadGet) to get the frameworks associated with the custodian org and which will be populated in board dropdown as single select. Our assumption is that the framework name and board name will be same and each framework contains single board. The NCF framework will not be considered for the Custodian Org.&#x20;

\*\*Step 2: \*\*

Once user selects single board in dropdown  we will call the [get framework api](http://docs.sunbird.org/latest/apis/framework/#operation/FrameworkV1ReadGet) to get the categories for that framework and board value (i.e framework name) will be replaced with actual board and associated medium , class , subject will be populated in medium, class and  subject which are multi select dropdowns

**Step 3:** When user selects all the required i.e board , medium , class then submit button will be enabled and portal will call update user api with selected values along with the framework to validate at the api end

**Assumptions:** 1. user can only select in board, medium, class and subject in same respective order and after selected if higher priority field is selected with another value the next level fields will be reset to none.

Eg: If i select \*\*AP Board, Telugu medium, Class 9 and Maths Subject \*\* if I change Board to \*\*TN Board \*\* then medium , class and subject will be reset to none and user need to select them again

2. Filters for users belongs custodian org will continue to show custodian org's default framework categories and user from other than custodian org will show filters from there org's default framework(which is existing behaviour).

In case of user belongs to a org which is not a custodian org then in step 1 with get channel api we will be taking default framework of that channel and populate same in the board dropdown

and step 2, step 3 and assumptions are same as above&#x20;

\*\*Note: \*\* This is planned for onboarding cards and we will be planning NCF to All frameworks for filters in next release after discussion on the behaviour of filters

***

\[\[category.storage-team]] \[\[category.confluence]]
