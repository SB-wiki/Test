 **Overview** There are set of tasks that runs based on schedule within sun-bird platform. This are used for checking resuming the process that may have been interrupted. Currently there are few scheduled tasks that are scheduled through quartz. While there is only one scheduled task, which is primarily invoked for refreshing the cache. Currently there is no way to trigger/control the schedule of this jobs externally.

 **Problem statement** Most of the tasks are scheduled to run once/twice during the 24 hours. Now in certain cases while monitoring, we may wish to take immediate actions, and trigger the tasks manually, rather than waiting for it to happen on schedule. For e.g. we have added/associated many users with organisations, and now want it's immediate impact on the user count per block. Or you added some system settings and wish to refresh. Having a mechanism or ability to trigger such actions manually can be useful to speed-up the user actions.

 **Solution** Proposal is to create an api for this purpose. The api can be only invoked from user account having ADMIN role only or we won't on-board this api, it need to always call inside container.In that case only few people having server access can make this call.


### Approach 1:
Create a static list of jobs, available or being scheduled from SchedularManager



| Pros | Cons | 
|  --- |  --- | 
| Easy to implement | Difficult to maintain, as developer might not be aware of putting the newly addedtasks into this list. | 
|  |  | 

 **Approach 2:** 

Use the job-store postrgres to get list of jobs from quartz



| Pros | Cons | 
|  --- |  --- | 
| Easy to implement | Solution tightly coupled as it is expecting to use table-names, column names which are generated/created by quartz | 
| No entries will be missed, which was casewith manual updates of entries | Can be problematic if job-store is changed. | 

 **Approach 3:** 

Use scheduler methods to get list of supported background jobs. 



| Pros | Cons | 
|  --- |  --- | 
| This will give seamless user experience regardlessof where job-data is stored |  | 
| No risk of manually updating supported background jobs |  | 


### API definition
 **Background Job API** We will get scheduler instance and list all the jobs from scheduler, where we can fetch all the job groups, job names and description.



 **GET**  /api/v1/backgroundtasks


```
{
    "id": "api.backgroundtasks.read",
    "ver": "v1",
    "ts": "2018-11-27 14:45:34:869+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ddd59a7d-0c66-4f10-87e8-e8b5ea6a1da6",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": {
                      \[
                         {

                           "taskGroup":"group1",
                           "taskName": "taskName",
                           "description" :"task description"
                         },
                         {

                           "taskGroup":"group1", "taskName": "taskName2", "description" :"task description" }, {

                           "taskGroup":"group2", "taskName": "taskName3", "description" :"task description" } } } }


```


 **POST**  /api/v1/backgroundtasks/trigger/:taskName

Request Body: <EMPTY>

 **200 OK** 


```
{
    "id": "api.backgroundtasks.trigger",
    "ver": "v1",
    "ts": "2018-11-27 14:45:34:869+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ddd59a7d-0c66-4f10-87e8-e8b5ea6a1da6",
        "err": null,
        "status": "success",
        "errmsg": null
    },
    "responseCode": "OK",
    "result": {
        "response": "SUCCESS
    }
}


```



```

```
 **400 Bad Request -** In case job is running currently, we will throw error, that it cannot be triggered immediately.




```

```

```
{
    "id": "api.backgroundtasks.trigger",
    "ver": "v1",
    "ts": "2018-11-27 14:45:34:869+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ddd59a7d-0c66-4f10-87e8-e8b5ea6a1da6",
        "err":  "JOB_ALREADY_RUNNING",
        "status": "failure",
        "errmsg": "Job currently in running state, pleas try after sometime", }, "responseCode": "OK", "result": { "response": "SUCCESS } }
```
Response  **404 Not Found** : If no such background job found

Response  **401 Not Authorized**  If not logged in as admin




```

```

```

```


*****

[[category.storage-team]] 
[[category.confluence]] 
