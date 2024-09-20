Processing Self-Claimed users when state-admin bulk-upload the details, Presently we have 2 api’s for uploading users, one is for uploading sso users and another one is for shadow-user bulk-upload. Both have 2 different end points.

/v2/bulk/user/upload → shadow-user bulk-upload

 /v1/bulk/user/upload → sso users.


## solution 1:
Use the existing  **/v2/bulk/user/upload**  end-point by adding new attribute in the call, preferable name is operation or  type.

It is easy for maintenance.

Not much code changes from the controller part and on-boarding the api.

Request api details:


```json
curl --location --request POST 'https://dev.sunbirded.org/api/user/v2/bulk/upload' \
--header 'Content-Type: application/json' \
--header 'Authorization: ' \
--header 'x-authenticated-user-token: ' \
--form 'user=@/Users/harikumarpalemkota/Downloads/self-declared_user_upload_dev.csv' \
--form 'operation=selfdeclared'
```
operation value can be saved in the field objecttype (bulk_upload_process). 




## Solution 2:
Use a new end point.

Easy to use but difficult for maintain, since the same kind of activity is performed by existing api’s.



Fields for uploading data:

Mandatory fields :  **Diksha UUID** ,  **Status** ,  **State provided ext. ID, Channel, Organisation Id, Persona** 

Optional fields :  **School Name** ,  **School UDISE ID** ,  **Phone number** ,  **Email ID** ,  **Diksha Sub-Org ID, Error Type.** 

Process:


1. Validating the mandatory fields.


1. Save the uploaded data to bulk_upload_process table


1. Need to call back-ground actor for processing the uploaded-details


1. Based on the status field value, operation will be vary on the usr_external_identity table.


    1. status = VALIDATED, migrate the user.


    1. status = REJECTED, delete the declaration.


    1. status = ERROR, look for error-type - modify the declaration to reflect errors reported by admin.


    1. status = PENDING, do nothing



    
1. Once the whole process is completed, process-id set to completed in the bulk_upload_process table.

    



Note: All the processing activity is done on the fly in background. There will be no schedulers involved in this.




### 

Errors :
Possible errors while uploading the bulk-user-selfdeclaration.


1. When csv data is empty :


```json
{
    "id": "api.bulk.user.upload",
    "ver": "v2",
    "ts": "2020-08-11 11:31:35:739+0530",
    "params": {
        "resmsgid": null,
        "msgid": "be125fc8-fc43-484a-9fb2-a78c9ccc3ce8",
        "err": "NO_DATA",
        "status": "NO_DATA",
        "errmsg": "You have uploaded an empty file. Fill mandatory details and upload the file."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```


2. When csv data missed mandatory param header field in the csv :


```json
{
    "id": "api.bulk.user.upload",
    "ver": "v2",
    "ts": "2020-08-11 11:19:03:343+0530",
    "params": {
        "resmsgid": null,
        "msgid": "ebb758fb-5471-4ce8-9889-76bac0396276",
        "err": "MANDATORY_PARAMETER_MISSING",
        "status": "MANDATORY_PARAMETER_MISSING",
        "errmsg": "Mandatory parameter diksha uuid is missing."
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```
3. when csv data missed mandatory param value in the csv :


```
{
    "id": "api.bulk.user.upload",
    "ver": "v2",
    "ts": "2020-08-23 16:41:31:253+0000",
    "params": {
        "resmsgid": null,
        "msgid": "614e0464-d895-45dd-95db-abb17851813e",
        "err": "INVALID_REQUESTED_DATA",
        "status": "INVALID_REQUESTED_DATA",
        "errmsg": "[ In Row 1:the Column Diksha UUID:is missing ]"
    },
    "responseCode": "CLIENT_ERROR",
    "result": {}
}
```




*****

[[category.storage-team]] 
[[category.confluence]] 
