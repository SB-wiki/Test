# Secure-auto-migration-of-custodian-account-to-state-tenant-via-SSO-based-login

Introduction

Teachers may sign up on Diksha (Self sign up) before the formal state-led on boarding is initiated.

Following this, if a user attempts to access Diksha via SSO using the same identifier they used for self sign-up, they will be prevented from doing so as the identifier will be detected as a duplicate.

Note: There is a V1 fix for this in place currently for state AP. Any user initiating a first time SSO login using an identifier that already exists in the custodian org - causes an auto migration of the account from custodian to the state tenant they are doing SSO to.&#x20;

This approach is not entirely secure as there is no additional validation the user has to provide before the account migration to the AP tenant takes place. This workflow requires an additional validation, in order to ensure accounts are not erroneously migrated/ handed over.

Suggested Approach:

If an identifier is found to match an account in the custodian org when the user tries to login via SSO for the first time, the user should be prompted about the existence of the duplicate account, and asked whether the account belongs to them.

If the user stakes claim to the account, they have to prove ownership of the existing account (in custodian) by providing the password to the account. If a valid password is provided, the account in the custodian org is migrated to the state tenant. The SSO details sent by the state will apply to the new account for the user.

If the user refutes ownership of the existing account, they are provided with a new account on the state tenant as per the standard SSO workflow. The identifier is assigned to the new account in the state tenant. The old account in custodian that existed is stripped of the identifier and made inactive.

**Note:**

The following is how ownership is established :

1. Identifier ownership - successful OTP validation
2. Existing account ownership - successful entry of account password (Diksha password/ Google login)

Jira Ticket ID : [SB-13773 System JIRA](https://browse/SB-13773)

JTBD

* \*\*Jobs To Be Done: \*\* Enable users to login via SSO even if they have a self signed up account created with the same identifier they're using for the SSO login. Maintain one consolidated account for the user in the state tenant so that they do not have to deal with duplicate accounts.
* **User Personas:**  Users who are valid state users, but have taken initiative to carry out self sign-up before state initiates formal on boarding.
* **System or Environment:**  Elaborate the system or environment in which the product will be used

Requirement Specifications

* Overall process workflow

Approach:

A user will be required to provide the password of an account that they are trying to migrate before the migrate activity can be carried out .

1. The first step in the SSO workflow is to validate ownership of the identifier (phone number/ email) via OTP
2. If identifier ownership validation fails, the login attempt via SSO fails.
3. Once the identifier ownership is validated, the system runs a check to see if a duplicate account with the identifier already exists IN THE CUSTODIAN ORG (If a dupe exists in a state tenant, the new SSO login attempt will fail)
4. If a duplicate account is found in the Custodian org, the user is intimated about the existence of a duplicate account, and is asked whether they'd like to merge the two accounts.
5. If the user opts NOT to merge with an existing account, the system creates a NEW account with the identifier in the state tenant (as identifier ownership has already been proved) - and the existing account in the custodian org is stripped of its identifier
6. If the user opts to merge the accounts, the user is prompted to enter the ID/ password for the existing account in the custodian org OR login with Google

* 6a. If the account in the custodian org was created using form sign up, the user will provide the ID/ PW for the account, and ownership can be validated.
* 6b. If the account in the custodian org was created using Google sign in, the user can use the ‘sign in with Google’ option to demonstrate account ownership
* the user is not logged in into the account - the API only returns whether the user owns the account - ie. the ID/PW combination was correct.

7. If password validation for the existing account is successful, the user is prompted with a message that the account merge has been initiated, and that they will be notified when the merge action is completed.

Note: The account merge is carried out as an asynchronous activity - once the merge activity is complete, the user is sent a notification on the identifier of the state tenant account that the operation has been competed. The user details in the SSO call (name, org membership etc.) take precedence when the account is created in the state tenant (in case there is a discrepancy between the name on the account in the custodian org and the name sent in the SSO call) since these are details sent from the state.

8. If the account ownership proof fails the first time - due to incorrect password, one retry attempt is permitted. If incorrect password is provided on both occasions, account merge cannot proceed.

Since Keycloak has a limitation from being able to restrict the password entry to 2 attempts only:

If the user enters the wrong password for account validation during SSO auto-merge, the flow will carry on to the next screen ([https://projects.invisionapp.com/share/2YT9CGQNASD#/screens/376879377](https://projects.invisionapp.com/share/2YT9CGQNASD#/screens/376879377))

This screen will have

> an error message for \[ _incorrect password + Click ‘Back’ to retry + Click ‘Ok’ to create a new account_ ] Basreena Basheer this message needs updating

> a ‘Back’ button for the user to go back and retry password entry

> an ‘Ok’ button that will permit the user to create a new account.

If password validation fails and the user chooses to create a new account, the user is provided with a new account set up with the identifier provided by the user - as identifier ownership has already been established. The user messaging happens accordingly. The existing account in the custodian org is stripped of this identifier, and becomes an Inactive account.

Messaging on merge API call failure :

Messaging update (this is in case the call to the merge API fails - the user needs to be told right away that the merge operation has not been initiated, and that it has to be triggered again.&#x20;

Messaging on API call failure : “ Account merge has not been initiated. Please retry by logging in to your state system ”

Note: At any point after entering the merge workflow, if the user chooses to click on 'Back' - this will bring the user back to the page where the merge decision is initiated ([https://projects.invisionapp.com/share/2YT9CGQNASD#/screens/376879374](https://projects.invisionapp.com/share/2YT9CGQNASD#/screens/376879374))

Message template :&#x20;

_All your Diksha usage details are merged into your account . The account  has been deleted_

_You can re-login to refresh your account_

* Dependencies : The ability to re-assign an identifier from one account to another.

\| |

Wireframes & Designs:

Workflow:

[https://drive.google.com/file/d/1Mq8KHV0iFJsuLDydiTXG9WNUD\_9LJepN/view?usp=sharing](https://drive.google.com/file/d/1Mq8KHV0iFJsuLDydiTXG9WNUD\_9LJepN/view?usp=sharing)

**UX DESIGNS**

[https://invis.io/2YT9CGQNASD](https://invis.io/2YT9CGQNASD)

Wireframes:

[https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K](https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K)

Localisation Requirements

All user messaging is expected to be localised.

Telemetry Requirements

Ability to track how many such account migrations have successfully been initiated, how many are successfully carried out - by tenant.

Audit events as appropriate - when was a merge initiated, carried out etc.

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
