# Admin-Manage-Page----Geo,-Teacher-Data,-Uploads

Introduction

JTBD

* **Jobs To Be Done:**

A new ‘Manage’ page needs to be provided to anchor access to the various datasets that a state admin can view/ manage. These include:

1. Geo data: View details of geo(org) data that has been successfully created for the state
2. View details of validated state teacher accounts created in the state tenant.
3. Manage and view details of the Shadow (reference) DB - this section is made available only if SSO integration is not enabled for the state

This page will be accessible only by the state admin (Tenant admin role) - and will be accessed from a ‘Manage’ link in the Portal drop-down menu which is a link that only the state admin will be shown

**Jira Ticket :: System JIRA2207a759-5bc8-39c5-9cd2-aa9ccc1f65ddSC-1283**

Requirement Specifications

* **Overall process workflow**

> > The 3 sections (as specified above) will be displayed in a 'summary format' (totals) on the manage page

> > Clicking on the 'more' will open an expanded view in a new tab

> > The expanded view will have :&#x20;

Schools aggregated at the district level for the section on Geo data

Teachers aggregated at the district level for the section on Validated teacher data

> > The "User List upload" will show only for states that do not have SSO integration enabled. This section allows a state admin to&#x20;

a. Upload a new list of users into the Shadow DB

b. See a summary of the shadow DB - total user records uploaded (for state) onto shadow DB, records that have been validated, records that were Rejected by users, records that failed, as well as records in the shadow DB that have duplicates (for phone number/ email IDs). Clicking on each of the links enables the admin to download a csv file of Validated, Rejected or Failed, Invalid user entries in order to check. (see wireframes doc for list of variables in the files that are downloaded)

&#x20;&#x20;

* **UX Designs**

[https://invis.io/FSU7PAI5KWC](https://invis.io/FSU7PAI5KWC)

* **Telemetry requirements**

Basic telemetry to be able to track how many people visit the page, how many downloads are carried out from the page

WIREFRAMES ::

See link to Google Docs : [https://docs.google.com/document/d/1Ey4x6DCJlnQyplJpiIqMdtoNptu8fPl\_D1E4SCtRADI/edit?usp=sharing](https://docs.google.com/document/d/1Ey4x6DCJlnQyplJpiIqMdtoNptu8fPl\_D1E4SCtRADI/edit?usp=sharing)

The doc above has the wireframes for the pages, as well as the list of variables in each of the files to be downloaded (for the 'User List Upload' section)

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
|                                                                                      |                                                                                                                                   |                                                                         |

Telemetry RequirementsUse this section to provide requirements of the events for which telemetry should be captured. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Event Name                                                                     | Description                                                       | Purpose                                                      |
| ------------------------------------------------------------------------------ | ----------------------------------------------------------------- | ------------------------------------------------------------ |
| Mention the event that will generate telemetry and which needs to be captured. | Provide event details. e.g. clicking upload for textbook taxonomy | Provide a reason why the event telemetry should be captured. |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
