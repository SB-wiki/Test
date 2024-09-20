# On-boarding-for-states-that-only-have-data-2---Auto-match-with-ID-in-custodian-+-teacher-ID-validati

Introduction

Provide the ability for states that claim to have reliable user data to&#x20;

(1) \[\[Upload their user data in to the system|On-boarding-for-states-that-only-have-data-1----Ability-for-a-state-admin-to-create-a-shadow-DB]] - into a Shadow reference DB

(2) Enable auto-matching of users for migration to the state tenant - based on comparison of identifiers to the entries in the Shadow DB created in (1) above.

Once a state admin \[\[creates a Shadow DB|On-boarding-for-states-that-only-have-data-1----Ability-for-a-state-admin-to-create-a-shadow-DB]] of the state users on the system this DB is used as a reference by the system to match against identifiers of users who sign up/ sign in. A match indicates a likely state user, and this is confirmed with the user by requiring them to enter their state external ID for comparison against the Shadow DB entry.&#x20;

This PRD lists the match activity that is carried out post the creation of the Shadow DB by the state admin.

Jira ticket :: [SC-1243 System JIRA](https://browse/SC-1243)

JTBD

* \*\*Jobs To Be Done: \*\* Enable auto-matching of users for migration to the state tenant - based on comparison of identifiers to the entries in the Shadow DB created by the state admin.

Requirement SpecificationsThis section consists of requirement specifications for specific use cases in the User JTBD. The requirements for each use case are elaborated in detail through sub-sections for:

* **Use case overview**

When a state provides a list of valid user details that goes into the shadow DB, the identifiers provided must be compared against:

> every existing account in the system - if a match is found with an account in the custodian org, the account should be flagged for further validation, and the user should be prompted to check if they belong to the state as specified in the shadow DB, and validated with matching their external user ID as well - the next time they log in. If a match is found with another existing user account in a state tenant, the entry in the shadow database can be marked as incorrect

> all new user sign up/ account creation that happens - if a match is found with an identifier that a user is attempting to sign up with, the user should be asked whether they belong to the state, and also prompted for their external user ID if a match is initiated by the user saying 'Yes'.

The identifier matching is to be carried out periodically (say daily) by a script that runs in the background. When a match is detected, the record is flagged for user notification when the user logs in next.

If a user provides the correct external ID as listed in the shadow DB after validating identifier ownership, the user account can be moved to the state tenant as a valid user account for the state.

If the identifier matches but the external ID does not, the claim of the user is rejected, and a new account is created/ user continues with the old account in the custodian org with the identifier instead.

USER VALIDATION WORKFLOWS - as part of Sign Up/ Sign In:

* Any valid user identifier in the system (new user sign up, existing user account, new identifier added to the profile by the user) is to be periodically compared against the Shadow DB to see if there is an identifier match.
* If a match is established, the user is prompted with the following : “Are you a Govt. teacher for ?” - If the user answers “Yes”, they have to prove the claim by providing the external Identifier for the record.

> Once both the phone/ email and the ext. ID are seen to match, the user account is migrated to the state tenant. The corresponding row in the Shadow DB is marked as ‘Validated’

> If the Ext. ID is not seen to match even after two tries from the user, the claim fails, and the Shadow DB entry is updated to ‘Failed’

> If the user answers ‘No’ to the prompt of “Are you a govt. teacher for ?”, the user is retained in the custodian org, and the User\_Action for the Shadow DB entry is marked as “Rejected”

NOTE : The same workflows should kick in if the user edits their profile to add/ edit a new identifier (phone/ email), and a match is detected with an entry in the Shadow DB.

* The state admin should be able to pull reports based on record statuses in the Shadow DB (see [Jira ticket](https://project-sunbird.atlassian.net/browse/SC-1283))

Note:&#x20;

This messaging on the 'Enter Teacher ID' screen needs to be made a tenant specific configuration . The current text can be the default to begin with, but we should be able to change the text (header text and messaging) for each tenant - this needs to be made a tenant specific config.

&#x20; &#x20;

Update: This messaging will be "User Verification"

1. **Additional Design considerations: (addition post design discussions os of Oct 2019)**

&#x20;    &#x20;

**+** Make the workflows **configurable** - to choose between mandatory/ optional as an implementation team setting : \* Teacher ext ID can be optional/ mandatory for the shadow DB file upload - based on the config for the tenant \* The messaging will accordingly specify Teacher ext. ID to be optional/ mandatory - based on the config for the tenant \* The validation workflow for users will either ask for the teacher ID OR not - depending on whether it is made mandatory for the tenant or not.

**+** Add a **config** (by tenant) to specify which parameter - email ID OR Phone Number - should be used for matching from self signed up accounts

E.g.: Implementation team should be able to set a config which states that for State UP, use Email ID as the identifier for custodian org match, while use Phone number for State Kerala

The user match against records from a state should happen only against the chosen identifier as set by the state, and not against both email & phone number. This will help reduce the occurrence of multiple matches from the shadow DBfalseSystem JIRA2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSB-16235"

**+** **User Validation** based on Shadow DB entries:

Given duplicate phone numbers/ ext. IDs could exist across states, it becomes necessary to get the State of the user as a user input, in order to further prune the subset of matching records in the Shadow DB

\*\* If the identifier matches entries in the Shadow DB across multiple states, the user is shown a drop-down to select a State that they belong to - this dropdown is populated with values of all the states that have registered a match in the Shadow DB

E.g.: Phone number 99xxxxxx99 from custodian matches 5 records in the Shadow DB - 3 from State S1 and 2 from State S2.

(a) The user will be shown a prompt “Are you a State Government Teacher?”

(b) On answering ‘Yes’, the teacher will be shown 2 input boxes:

Dropdown : Select State (values loaded from the match list above - S1 and S2)

Free Text : Enter State ID (teacher enters ext. user ID for matching against entry in Shadow DB)

(c) If the ext. ID match is established, the account is migrated from the custodian org to the state tenant.

The list of states in the dropdown will be populated based on the states in which the identifier registers a match. (say it will have 2 states, if the identifier matches 2 rows in the shadow DB from across 2 states.Also, if the identifier matches entries in the shadow DB only from 1 state, then the state dropdown is not required, as the user needn't specify a state.

* **Overall process workflow**

Workflow : [https://drive.google.com/file/d/1RRDHlI-IMD6\_aahN\_LMcH0PWMCOL4CC0/view?usp=sharing](https://drive.google.com/file/d/1RRDHlI-IMD6\_aahN\_LMcH0PWMCOL4CC0/view?usp=sharing)

* \*\*Localization requirements  \*\*

All user messaging is expected to be localised/ available in regional languages

* **Telemetry requirements**

Ability to track how many such matches occur, how many are successfully validated, and how many fail (And due to what reasons - rejected, failed etc.)

Ability to track how many updates have been made to the shadow DB, and by what quantum, tenant-wise

Ability to track how many record over-writes are carried out in the shadow DB, tenant-wise

* **Dependencies**

Creation of Shadow DB : see ticket [https://project-sunbird.atlassian.net/browse/SC-1241](https://project-sunbird.atlassian.net/browse/SC-1241)

DESIGNS

UI: [https://invis.io/GXTBPFPWDJM](https://invis.io/GXTBPFPWDJM)

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
