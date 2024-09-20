# User-Initiated-Account-Merge

IntroductionUser initiated account merge will permit a user who owns two accounts on Diksha (one on a state tenant and one on the custodian org) to merge the accounts and accumulate all usage history (course enrolments, course/ content consumption, course progress and badges) into one account. (the ‘primary’ state tenant account)

The other account (the custodian org account) is automatically deleted, and the identifier (ph/ email) freed up for reuse.

Jira Ticket ID: [SB-13777 System JIRA](https://browse/SB-13777)

JTBD

* \*\*Jobs To Be Done: \*\* A user has carried out self sign up (onto the custodian org). The state then initiates formal on boarding of users (via SSO, or Shadow DB based account creation):
  1. If the state attempts to create  an account with the same identifier that the user had provided to Diskha during self sign up, the account creation process will fail due to duplication of the identifier. This prevents the user from being granted a validated state account.

This problem is addressed from 2 angles of account creation :  1. SSO based account creation : Secure auto migration of user account to state tenant when an SSO login is initiated for an account that already exists in the custodian org :: ([https://project-sunbird.atlassian.net/browse/SB-13773](https://project-sunbird.atlassian.net/browse/SB-13773)) 1. Shadow DB based account creation : Shadow DB part 2 :: Auto match with ID in custodian + teacher ID validation :: ( _Jira link to be added_ )

```
1. If the state user creation process uses a different identifier for the user, the account gets created on the state tenant, and the user ends up with two different accounts, one on the state tenant, and one on the custodian org. This could lead to further confusion

```

A user may carry out some activity using their self signed up account (consume a course, etc.).

There is a need for such user activity to reflect in the state tenant account of the user, so that it can reflect in state reports. In such a scenario, the usage data from the self signed up account has to be merged into the state tenant account.&#x20;

Also, users often realise that they don't need two accounts, and want to have just one account - this means merging accounts to ensure no history is lost.

This PRD addresses the scenario (2) above, to provide a user initiated option for merging two accounts - one in a state tenant, and the other in the custodian org.

* **User Personas:** Users who explore/ sign up on Diksha before a formal state on boarding approach is announced. Such users will be constrained from creating an account in the state tenant if they already have a self signed up account with their primary identifier.

Requirement Specifications

**Use case overview:**

This merge can be initiated only from an account in the state tenant, and can be used to merge an account in the custodian org (secondary) to the account in the state tenant (primary).

The merge operation causes the usage history from the secondary account to be aggregated into the primary account. The parameters of the primary account (name, org ,sub org, ph/ email etc.) are retained as is. The secondary account is deleted post merge, and its identifier freed up for reuse.

The merge operation is expected to be carried out in an async fashion by the system. When the user successfully initiates a merge, they will get a message that the operation has been initiated, and that they will be notified once the merge is completed by the system. The system carries out the merge later and sends a notification to the user once complete.

The 'Merge accounts' link is not expected to be actively used by all users, and hence will be 'hidden' from plain sight. Users who face issues with multiple accounts will be advised to merge their account from their account in the state tenant - this communication will be managed by the states

**Overall process workflow**

Note: The merge operation can be initiated only from a valid active account in the State tenant

(the 'merge option should not be available if a user is logged in to the custodian org - ie. self signed up account)

1. User logs in to their account in the state tenant (app/ portal)
2. User selects option to 'merge account' ( appropriate warning messaging provided :: \[ok]  \[cancel] )
3. User is prompted to prove ownership of the secondary account by providing login credentials for the secondary self-signed up account (login using ID/pw, login using Google)
4. The account merge can proceed only if the secondary account is found in the custodian org AND the user is able to prove ownership of the secondary account as in (3) above. If not, the merge operation fails and the user is shown appropriate messaging.
5. Proof of secondary account ownership :

5a. The user can enter the ID/PW for the account. The system validates that that account exists in the custodian org, and that the credentials are correct. The response to the merge operation in this case should be a ‘go-ahead’ as necessary checks have been established.

5b. The user can choose to login using Google by clicking the ‘Sign in with Google’ button. This validates the user credentials, establishes that the account is in the custodian org, and returns a ‘go ahead’ for the merge operation

6. Once the conditions for merge are satisfied, account merge operation is initiated - this can be carried out in an async fashion. The user is notified that the account merge has been initiated, and that they will get a notification when it is complete. The user can click "Ok' to continue to stay logged in in the state tenant .
7. When the async merge operation happens, all usage details from the secondary account until that point are merged into the primary account (Course enrolments, Progress and certifications/ badges)
8. The secondary account is deleted and the identifier (email/ phone) associated with it is freed up for reuse.
9. The user is sent a notification (on the identifier for the primary account - email OR Phone) stating that the account merge is complete, and that they can now see consolidated usage details of both accounts in their state tenant account.

Messaging on merge API call failure :

Messaging update (this is in case the call to the merge API fails - the user needs to be told right away that the merge operation has not been initiated, and that it has to be triggered again.&#x20;

Messaging on API call failure : “ Account merge has not been initiated. Please retry from the profile menu ”

Message template :&#x20;

_All your Diksha usage details are merged into your account . The account has been deleted._

_You can re-login to refresh your account._

.

**Wireframes & UX:**

Wireframes :

[https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K](https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K)

**UX DESIGNS:**

Account Merge: [https://invis.io/VPT3XP68EBS](https://invis.io/VPT3XP68EBS)

'Merge Account' button on the portal and the app:

PORTAL: The 'merge' button will be added to the portal dropdown menu that has profile, logout etc. (see designs)

APP: The “Merge Account” button on the app will go inside the Settings menu in the hamburger for the mobile app. You can put it before “About us” and after “Share the DIKSHA App”.

Localization Requirements

All user messaging is expected to be localised.

Telemetry Requirements

Ability to track, by tenant, how many such account merges have

1. Been initiated
2. Been successful

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
