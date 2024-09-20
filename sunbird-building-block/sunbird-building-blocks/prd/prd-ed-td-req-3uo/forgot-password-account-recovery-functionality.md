# Forgot-Password----Account-Recovery-functionality

Introduction

1. Make the current "Forgot Password" workflow more secure by addition of a name match as on account (in addition to OTP verification of the identifier) before a user is allowed to update the password of an account
2. Logout the user on successful change of password, and require the user to login once again

Jira Ticket ID : [SB-13637 System JIRA](https://browse/SB-13637)

&#x20;

JTBD

* \*\*Jobs To Be Done: \*\* Make the password reset workflow secure
* **User Personas:** Any user with an account on Diksha

Requirement Specifications

Overall process workflow

Add name match (fuzzy) as an additional check for password reset workflow:

The user will be required to:

1. Enter Identifier (mobile/ email) for the account to undergo password reset AND Enter the name on the user account
2. If there is an account(s) (active/ inactive - see note below) that both parameters match (exact match for identifier + fuzzy match for the name on the account), the recovery options for the account are presented to the user { primary ID, secondary ID - if available, recovery ID (to be built) }

If no account is found with the identifier provided in (2) above, the user will see a message

" Phone number/ Email ID not registered with Diksha."

If the name provided in (2) above does not match the name on the account linked to the identifier provided, the user is shown an error message : "The entry does not match the name registered with Diksha"

3. The user can choose which ID to get their OTP on - and enter the OTP on the screen once they receive it
4. If the OTP validation is successful, the user is permitted to reset the account password
5. If OTP is incorrect, the user is shown the message "Incorrect OTP", and the system reverts to the login screen.
6. Once the password is successfully reset, the user is shown the message "Password successfully updated. Click here to login" - which takes the user to the login screen.

Workflow: [https://drive.google.com/file/d/1IWVtGSR4npEmUeRpaKErDQcSPA7\_0MyB/view](https://drive.google.com/file/d/1IWVtGSR4npEmUeRpaKErDQcSPA7\_0MyB/view)

&#x20;has identified a library that we’re using for fuzzy name match. This has a configurable setting for accuracy. He will provide some examples that indicate what is expected to be a match, and what isn’t. (illustrating fuzzy match functionality)

NOTE:

_Note that the matching has to be carried out with current ‘active’ accounts as well as orphan account (that may have been stripped of their identifiers - see_ [https://project-sunbird.atlassian.net/browse/SB-13642](https://project-sunbird.atlassian.net/browse/SB-13642)

Account recovery requires a user to provide the Identifier (could be old/ stripped) and the name on the account. As a user trying to recover my old account, I may provide my old identifier that I used to create an account (which now belongs to another user) and the name on my account. As the combination of the Identifier+Name can only yield a unique match to my old account, recovery will be triggered against my old account, and not against the new account belonging to another user.

**UX Designs :**

Account Recovery:[https://invis.io/CDT3XPDB7SJ](https://invis.io/CDT3XPDB7SJ)

The same screens/ workflow will be used for both portal and app by employing a webview.

Localisation requirements :

All user messaging is expected to be localised

&#x20;&#x20;

Wireframes:[https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K](https://whimsical.com/DYU88Y9U2LQik8MpgRDn7K)

**UX Designs :**

Account Recovery: [https://invis.io/CDT3XPDB7SJ](https://invis.io/CDT3XPDB7SJ)

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

Impact on Existing Users/Data&#x20;

As confirmed with

> &#x20;For the older app builds, the current forgot password workflow will continue to function as-is

> &#x20;For the newer app builds going forward (post 2.3) - The new forgot password workflow (as detailed in this ticket) will kick in. The only update is that once the user resets their password successfully, they will be taken to a page that has a message “Password reset successful, click here to login” - clicking on this message will take the user to the login page.

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
