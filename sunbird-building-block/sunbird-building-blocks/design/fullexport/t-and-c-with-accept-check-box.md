# T\&C---with-‘accept’-check-box

\| 1.13 | | [SB-9571 System JIRA](https://browse/SB-9571) | | DONE | |

|

| ---                                           |
| --------------------------------------------- |
| ---                                           |
| ---                                           |
| 1.13                                          |
| [SB-9571 System JIRA](https://browse/SB-9571) |
| DONE                                          |
|                                               |

|

### Background

All users logging in to Diksha for the very first time need to be shown a pop up that gets them to accept Diksha T\&C. The window will display the latest version of the Diksha T\&C from the Diksha app. [https://diksha.gov.in/term-of-use.html](https://diksha.gov.in/term-of-use.html)

The pop-up needs to appear at the time of the very first login of the user and whenever T\&C version is got updated. It can have the following messaging:

The user needs to accept the T\&C to continue and use the app

SolutionAfter successful login it will call get profile detail API. If in profile detail response promptTnC is equals TRUE and tncLatestVersionUrl is not null or empty will show the TnC screen on App.

```java
tncAcceptedVersion
tncAcceptedOn
tncLatestVersion
promptTnC
tncLatestVersionUrl = html link
```

### Scenarios&#x20;

Scenarios covered for TnC are [here](https://project-sunbird.atlassian.net/browse/SB-9571).

&#x20; &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
