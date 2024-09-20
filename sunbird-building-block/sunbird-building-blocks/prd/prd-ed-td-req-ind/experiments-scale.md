# Experiments-@Scale

_Instructions to use this template:_

1. \_Use this template to write the Product Requirements Document (PRD) for a single User JTBD or Initiative. \_
2. _Each workflow within the PRD will correspond to an Epic in JIRA. Each User Story will correspond to a Story in JIRA that will be part of the Epic._
3. \_Each section in the template has instructions, with examples explaining the type of content to be written in that section. \_
4. _You may start typing into the section by eliminating the instructional text, or delete the instructional text after you have entered all content for the section._
5. _Repeat from section \<Use Case 1> Overview for every use case in the User JTBD or Initiative_

IntroductionAs we are moving to the next phase of the Sunbird development. We need to efficiently roll out the changes and new features in a controlled manner. If can leverage the existing user base to take the feedback. Monitor the usage and take the decision based on the (usage) data.

&#x20;Let assume we are spending $100 to build a feature. that will affect 1000's of existing users.

To decide and test the which feature/ button placement works better for the users.

We need to take the new design to the users and take their feedback. Taking a feature to exist user and ask did they like it over the old design is very subjective. It requires a lot of energy and resource to get quality feedback. Along with that, it takes a long time and has a vulnerability to make the existing stable feature unstable.&#x20;

A better way to do the same exercise is to choose an unbiased but relevant user of the same feature. Create two groups of these users for observation.

One group of the user will be shown the old design and the other group (control/test) will be shown the new design.

And collect the telemetry data for both groups.

based on the telemetry analysis, the user behaviour should tell which design/feature was used by what percentage of the users.

\*\*It also ensures that a stable branch of the feature remains stable and changes for the experiments are kept separate from the stable branch. \*\*

It should solve for

1. Does the new feature /design improve the feature metrics?
2. What persona is benefiting from the new design&#x20;
3. Is the hypothesis is holding good?&#x20;

Does it improve the usage matrix of the feature with a new design or there is a drop in the usage matrix int the control group?

JTBD

* \*\*Jobs To Be Done: \*\*
  * PMs wants to roll out the new features and changes to a set of user/devices selected based on criteria.&#x20;
  * PMs wants to measure success based on the telemetry data.&#x20;
  * PMs want to know what experiments are planned, active and running now.
  * PMs want to know the users/devices under an experiment group and control group
  * PMs want to know the users/devices selected /running more than one experiment.&#x20;
  * PMs want users to exit (force pull-out) an experiment.
  * Users should be agnostic of the experiment.
  * User should be able to opt-out of the experiment.&#x20;
* **User Personas:**  PM and users.&#x20;
* **System or Environment:**  Portal and Mobile (or both)

Requirement SpecificationsFollowing the major story/feature required for experiments.&#x20;

* Experiment definition
* Lifecycle and rollout of an experiment
  * Separate Code experiment (Mobile) SC-1075
  * Separate Code experiment (Portal)
  * Rollback of the experiment&#x20;
  * Process and deployment at an experiment at scale
*   Separate deployment of experiment

    * "Mobile code push for an experiment: SB-13158

    SC-1076"

    * Mobile code push via notification from the server
    * Portal changes for an experiment
    * API changes for existing services
    * Offline Desktop experimentation
* Telemetry changes
  * Telemetry to capture start, end expiry of the experiment.
  * Telemetry to capture user opt-out (self), force removed(server), moved out on expiry of the experiment.&#x20;
  * Telemetry change in Mobile (ad-hoc data analysis) SC-1104&#x20;
  * Telemetry change in the portal (ad-hoc data analysis)&#x20;
  * Analytics, data product and dashboard&#x20;
* User selection for an experiment
  * Manual selection of device/user for experiment SC-1098
  * Random selection of users in 2.2.0 -- SC-1074&#x20;
  * Criteria based selection of devices/users for experiments
* Switch user to Original path (out of experiment) &#x20;
  * Opt-out from client&#x20;
  * Opt-out from the backend (force pull out) SC-1106
  * Auto opt-out from the client on expiry of experiment
* Governance changes (schema)
* Module-based experiment to allow multiple experiments per user or device

Experiment definition OverviewThis story captures the experiments object need to be stored in the system.&#x20;

An experiment is an alternative to the existing feature/ workflow or design, using which the experiment is done and user action/events are stored as telemetry to process later.

The experiment needs to be defined to capture all relevant details which should be used to build, deploy and analyse the details later.&#x20;

```
Experiment definition details
```

```
[SC-1103 System JIRA](https:///browse/SC-1103)
```

```
```

```
This Story covers the experiment definition.
```

```
An experiment should be an alternative to the existing feature/workflow in the production system.

An experiment should have the following attribute
```

```
Identifier, unique id to recognise the experiment

channel: Mobile| Desktop| Portal

tag:-- Autogenerated. 



There should be two group created one for experiment (modified path) and one for control group(orginal path).

Both group should have the same percentage(or number) of users. Where each group see the modified vs original workflow/feature.

control group is specially importance for the mobile (and offline desktop app). As there is extra download size involved in both the groups.



Experiment group will get new code/feature (downloaded) from the server.

Control group will see the same size of the code (modified path) but not used. This is specially required for the feature/UX experiment on the mobile app.

Where extra dowbload can impact on the usage (internet bandwidth, extra disc space on mobile). 

Experiment definition




```

* Experiment definition
  * Define the experiment.
  * Define the modified design for Mobile/ portal
  * Define the tags for telemetry
  * Define the user selection criteria&#x20;
  * Define start and end date
  * Define the metrics to be captured.&#x20;
  * Define if this experiment can be run in parallel or along with another experiment (multivariant) this will ensure small experiments to be executed simultaneously for a user or device.&#x20;
* Experiment run should have.
  * Dates: Start, expiry end dates.
  * User/Device Selection criteria
*

```
user to experiment mapping. 
```

```
* 
```

```
user/device id. 
```

```
* Experiment id.


* 
```

```
Experiment joined date.
```

```
* Experiment exit date.



```

* Along with it record any tech object/attribute, experiment feature URL etc.&#x20;
* The experiment should we allow the change/ modification of experiments,&#x20;
  * Change the user selection criteria.&#x20;
  * versioning the experiment changes with change in the experiment.&#x20;

Deployment Lifecycle and rollout of an experiment overviewThis story details the lifecycle of an experiment. An experiment goes through the following steps start to finish.

To roll out an experiment to the user, it needs to go through the following steps.

1. Experiment code branch for mobile
   1. There should be a different code base for the experiment branch of mobile. This is code hygiene expectation such that. Experiment code and production codes are kept separate.&#x20;
   2. No change in the experiment branch should adversely affect the Production branch.
   3. No extra testing effort on the Production branch.
   4. Deployment of the experiment branch is separate from the main branch
2.  Experiment code branch for portal

    1. There should be a different code base for the experiment branch of the portal. This is code hygiene expectation such that. Experiment code and production codes are kept separate. &#x20;

    No change in the experiment branch should adversely affect the Production branch.

    No extra testing effort on the Production branch.

    Deployment of the experiment branch is separate from the main branch
3. Rollback of the experiment
   1. Rollback of the experiment of the flaky experiment is deployed, It should also undo the data changes. And migrate the user to the original branch.
   2. Rollover the experiment with the new code bases. Show the user the new code base, the user remains in the experiment and sees the new experiment interface.
4. Process and deployment at an experiment at scale
   1. Define a process with playbook and scripts to run an experiment. This should be used to define, create and deploy an experiment. This playbook should become a guideline for further execution experiments.&#x20;
5. Merge the experiment or discard from the branch.&#x20;
   1. After the experiment is executed based on the metrics, the code should be merged with the production branch or discarded.&#x20;

Deployment of ExperimentsExperiments should be built separately from the production codebases. As feature branch and need to be deployed separately.

1. Mobile code push for the experiment: SB-13158, SC-1076 &#x20;
2. Mobile code push via notification from the server
3. Portal changes for the experiment
4. API changes for existing services
5. Offline Desktop experimentation

Telemetry changesThis story is about the need of having the experiment info in the telemetry.

A user being agnostic to the experiment or changed workflow, he will perform the task intended. The user action will be recorded as telemetry and synced to the telemetry server.

Data product should be able to include them in the data products the also able to provide a separate analysis of the user/devices in the Experiment.

Product manager(s) and business should be able to look in the metric from both the groups and able to take a decision on it.&#x20;

1. Telemetry change in Mobile (ad-hoc data analysis) SC-1104&#x20;
2. Telemetry change in the portal (ad-hoc data analysis)&#x20;
3. Analytics, data product and dashboard

User selection for an experimentWhen a user/device will visit (registered or anonymous )the sunbird, based on selection logic, the user will be either added to the experiment group or put in the control group (the original path ) by default, all users are in the control group.  The user selection is based on the various attribute of a user profile or device or combination of both. the user selection criteria or query can be stored for later reference.

In the case of multiple (multivariant) experiment running for a user or device. Selection logic should take this into account and store this value.&#x20;

1. Manual selection of device/user for experiment SC-1098&#x20;
2. Random selection of users in 2.2.0 -- SC-1074&#x20;
3. Criteria based selection of devices/users for experiments
4. Ageing of the device should be updated daily,&#x20;
   1. this should be executed for the user to initial/ trigger the experiment for user/ at the device.&#x20;
   2. The same check should be executed daily at the exit.&#x20;
   3. At expiry, the user should move out of the original path.&#x20;

Switch user to Original path (out of experiment)  This story details the scenarios and requirement for opt-out from an experiment.&#x20;

* Opt-out from client&#x20;
  * A user should be able to opt-in for experiments which are planned and or active, he should be able to do by providing a consent via setting in the user profile/ device. &#x20;
  * A user should be able to see the experiments running for him and he should be able to unjoin a planned of an active(running) experiment.
* Opt-out from the backend (force pull out) SC-1106
  * Server-side, we should have the ability to move out a user from the experiment.
  * On request of the user.
  * user is reporting accepted workflow.
  * We have enough user enrolled for the experiment.&#x20;
  * Enough data is captured for an experiment.
  * PM wants to close the experiment early.
  * The experiment is flaky (showing error, unaccepted behaviour) and needs to be closed early.&#x20;
* Auto opt-out from the client on expiry of experiment
  * Experiment duration has reached the expiry date, user/devices should switch back the control group/original path.&#x20;
  * For offline devices and offline desktop, this needs to happen automatically from the client-side. All the telemetry related to the experiment should be sent to the server.&#x20;

event to capture the user moved to the original path should be capture as telemetry and send to the server.&#x20;

Governance changes (schema)- Tech itemModule-based experiment to allow multiple experiments per user or device\<Use Case 1 - User Story 1> OverviewReplace the text within < > in the heading above with the name of the use case and the name of the first user story. Provide a high-level overview of the user story here. Each user story is further elaborated in its sub-sections. The principles to bear in mind while writing a user story are: 1) it comprehensively captures a unique feature or functionality that a user can accomplish using the system 2) it encapsulates a single unit of functionality 3) it corresponds to one JIRA story 4) it is accomplished in one release. If in a rare case, the functionality of a user story needs to be developed iteratively, the story should contain the Minimum Viable Product (MVP) content within the 'Main Scenario' section. All functionality to be developed in future releases should be part of the 'For Future Release' section. Whenever the functionality is taken up for a release, it should become part of the 'Main Scenario' section. The 'Main Scenario' section should always be in sync with the current system functionality if the story is released. Scenarios detailed for the User Story are part of the acceptance criteria of the story.

Replace the text within < > in the heading above with the name of the main scenario of the user story. Describe the typical usage scenario, as envisaged from a user perspective in a sequence of steps in the following table. As mentioned, the main scenario must necessarily cover the MVP and must always be in sync with the system functionality. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

\<Alternate Scenario 1>

Replace the text within < > in the heading above with the name of the alternate scenario. Describe one or more alternate methods that a user can use to achieve the same functionality. Use the following table to elaborate on the alternate scenario. Repeat this section as many times as required for the number of alternate scenarios described. To add or remove rows in the table, use the table functionality from the toolbar.&#x20;

| Srl. No. | User Action | Expected Result |
| -------- | ----------- | --------------- |
|          |             |                 |
|          |             |                 |

Exception ScenariosDescribe a list of exception scenarios in the following table and how they are handled. To add or remove rows in the table, use the table functionality from the toolbar. &#x20;

| Srl. No. | Error / Exception | Expected Handling |
| -------- | ----------------- | ----------------- |
|          |                   |                   |
|          |                   |                   |

WireframesAttach wireframes of the UI, as developed by the UX team for screens required for this story  &#x20;

For Future ReleaseAn optional section that describes functionality that may not be completed within a release

JIRA Ticket IDInsert the JIRA Ticket ID created for this story here. Click the + sign on the toolbar, select JIRA Issue/Filter from the list and either select a JIRA issue from the list or create one.  &#x20;

\<Use Case 1 - User Story 2> OverviewRepeat the entire Section and its corresponding subsections to elaborate the next user story in the use case. Repeat the section as many times as required.&#x20;

Localization RequirementsUse this section to provide requirements to localize static content and/or design elements that are part of the UI in the following table. Localization of either the framework, content or search elements should be elaborated as a user story. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| UI Element                                                                           | Description                                                                                                                       | Language(s)/ Locales Required                                           |
| ------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Mention the UI Element that requires localization. e.g. Label, Button, Message, etc. | Provide the exact details of the element that requires localization. e.g. User ID, Submit, 'The content is currently unavailable' | Mention all the languages or locales for which localization is required |
|                                                                                      |                                                                                                                                   |                                                                         |

Telemetry RequirementsTelemetry should have info of experiment active on the client-side.&#x20;

| Event Name                                     | Description                                                                                                                                                                                                                                       | Purpose                                                      |
| ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| Telemetry for user selection in the experiment | this telemetry should capture the experiment added to user/device.                                                                                                                                                                                | Provide a reason why the event telemetry should be captured. |
| Telemetry to download of the code              | Every experiment will need extra code push to the client, this telemetry event should capture the start and end of the code  to the clientThis should also push the expiry date to the client. so that the client can switch to the original path |                                                              |

1. This will provide how many user/device has initiated the code push.
2. And how many completed the download of the code push.
3. Need to capture if there is any cancellation or interrupt in the code push.

\| | Telemetry for the start of the experiment | This telemetry should provide the start of the experiment with experiment info. Active experiments, start timestamps  | The purpose to capture at what time the experiment starts on the client. in case of the portal, it would be immediate but on the mobile or offline desktop app, it will be delayed.  | | Telemetry for the end of the experiment  | This telemetry should capture the details when an experiment has reached to the end on the client, and the user/device has moved to the original path. It should also capture how the movement of user from the experiment was triggered. be it client opt-out, forced from server or expiry of the experiment.  | This is required to know if users facing the issues. How many users are opting out? how many are forced out? and how many have completed the experiment.  |

Non-Functional RequirementsNon-functional requirements

| Performance / Responsiveness Requirements                                | Load/Volume Requirements                                                                                                                                                                                                                | Security / Privacy Requirements                                     |
| ------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------- |
| All users/devices should be checked for the selection of the experiment. | Potentially user/device from the portal or mobile app can be either in an experiment or control group. So user selection check will happen for users/devices coming to Sunbird. User check response should be under a second response.  | Provide security and privacy requirements for an effective Use Case |
| Code push                                                                | Code push should be in the background and under 2 mins for all connection type.                                                                                                                                                         |                                                                     |

Impact on other Products/SolutionsUse this section to capture the impact of this use case on other products, solutions. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| Product/Solution Impacted                                                     | Impact Description                                 |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| Specify the name of the product/solution on which this use case has an impact | Explain how the product/solution will be impacted. |
|                                                                               |                                                    |

Impact on Existing Users/Data Use this section to capture the impact of this use case on existing users or data. To add or remove rows in the table, use the table functionality from the toolbar.  &#x20;

| User/Data Impacted                                                  | Impact Description                           |
| ------------------------------------------------------------------- | -------------------------------------------- |
| Specify whether existing users or data is impacted by this use case | Explain how the users/data will be impacted. |
|                                                                     |                                              |

Key MetricsSpecify the key metrics that should be tracked to measure the effectiveness of this use case in the following table. To add or remove rows, use the table functionality from the toolbar

| Srl. No. | Metric                           | Purpose of Metric                                                                                                                                                                                  |
| -------- | -------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|          | Specify the metric to be tracked | Explain why this metric should be tracked. e.g. tracking this metric will show the scale at which the functionality is used, or tracing this metric will help measure learning effectiveness, etc. |
|          |                                  |                                                                                                                                                                                                    |

***

\[\[category.storage-team]] \[\[category.confluence]]
