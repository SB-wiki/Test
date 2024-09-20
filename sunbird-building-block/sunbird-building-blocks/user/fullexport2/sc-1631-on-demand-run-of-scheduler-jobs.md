# SC-1631---On-demand-run-of-scheduler-jobs

### \*

* [Current scheduler details:](sc-1631-on-demand-run-of-scheduler-jobs.md#current-scheduler-details:)
  * [Conclusion:](sc-1631-on-demand-run-of-scheduler-jobs.md#conclusion:) Problem Statement:  As of now, learner-service code base has quartz based scheduled jobs (similar to cron jobs). They have defined schedules, but sometimes it is required to run the job instantly on demand. The task is to enable us to do this trigger.

Option 1: Build an api to trigger the required job based on the input.&#x20;

URl: /private/job/v1/trigger

Method: POST

```js
{
  "request": {
    "jobName": ["shadowuser"]
  }
}

```

Response: { "response": { "message": "SUCCESS" } } or error - likely that job name was incorrect.

| Pros           | Cons                                                  |
| -------------- | ----------------------------------------------------- |
| Easy to access | API must be secure The job actions must be idempotent |

Option 2:Instead of calling api externally, the same api is configured to the jenkins job.

It will restricted for few users only.

| Pros                                          | Cons                                                              |
| --------------------------------------------- | ----------------------------------------------------------------- |
| Only restricted users can access from Jenkins | Operationally, devops involvement to create the job is necessary. |

Option 3:As of now scheduler code is tightly coupled with learner service. We can make this as separate module/service. Or we can run a small container to handle all scheduler job itself, in this way it can be more helpful and controlled. Since stopping job container and restarting it is not going to hamper any other service.

| Pros |   |
| ---- | - |
|      |   |

### Current scheduler details:

This table will describe all scheduler job running inside sunbird.

| JobName         | Frequency          | Description                                                                                                               | Timing                |
| --------------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| shadowuser      | 0 0 2 1/1 \* ? \*  | 2.5: Automatic migration of users to a root-org 2.6: Tagging users as eligible for N root-orgs.                           | runs at every day 2am |
| bulkupload      | 0 0 23 1/1 \* ? \* | Not used (used only v1/\[user                                                                                             | org]/upload)          |
| updateusercount | 0 0 2 1/1 \* ? \*  | Not required (can be deleted). Built for announcements.                                                                   | runs at every day 2am |
| channelreg      |                    | Not required. Needed only as a backup. Org creation will create channel in KP as required. Built during EkStep → SB days. |                       |

#### Conclusion:

Accepted solution for implementation is as follows:

&#x20;1\. Option-1 will be implemented in release-2.8.0

* platform-user will provide an api to run scheduler job on-demand
* This api will have job name mapping details and when ever this api will be called it should trigger quartz schedule job.
* Sample to refer: [https://mkyong.com/jsf2/how-to-trigger-a-quartz-job-manually-jsf-2-example/](https://mkyong.com/jsf2/how-to-trigger-a-quartz-job-manually-jsf-2-example/)

2. Disable updateusercount and channelreg job - Do not delete code, but disable

&#x20; &#x20;

&#x20;&#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
