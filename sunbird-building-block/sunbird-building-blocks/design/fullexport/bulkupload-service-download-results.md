# BulkUpload-Service-download-results

**Overview** User can use bulk upload service for various artifacts like User, Organization, Location etc. Currently, user can access the results of upload through upload/status api, where in user gets all the records uploaded in json format. This can be difficult to consume for the end-user. Hence it is ideal to upload this results into cloud-service, and user can download the same from BulkUpload status service.

**Solution** **Applicability**

The solution is applicable for all types of bulk upload results. i.e. Org, User, Location etc.

**User Outcome**

User will be able to download the results of bulk upload process, from manage upload page. (where user can filter all the uploads done by certain filters).

As part of the tabular results which tracks status of all upload processes, there will be one additional column - **Download Result** -which will allow user to download the results of upload in **CSV** format.

This link will only be enabled/visible if status of the bulk upload is marked to completed.

Based on this URL, user can download the results.

Naming convention for the file downloaded would be → **"\<upload\_type>\_\<process\_Id>.csv"** . E.g. org\_01201202.csv.

**CSV** file will have user-friendly labels (as per the system configuration).

**Approach 1: Upload & Store Generated URL (Link does not expire)**

As soon as the bulk upload is finished, we will upload the file to cloud storage, and generated URL will be stored within the table **bulk\_upload\_process.**

Once upload is done, we will set the status of upload to **Completed**

**Pros:**

1. Minimal information stored within our database, which can easily access the uploaded data.
2. Simple to implement.

**Cons:**

1. As this is public URL without any expiry, anyone with access to link can download this sensitive data.
2. We will have to parse the URL in reverse to generate the new signed URL.
3. We cannot switch between different providers, as we are storing hard-coded data.
4. In case of container URL changes, this will not be able to handle

**Approach 2: Upload & Store Data required to generate URL on the fly**

As soon as the bulk upload is finished, we will upload the file to cloud storage, but will not used the signed URL which is generated.

We will store enough data, to generate the signed URL on the fly.

**Pros:**

1. We can secure the URL and minimize the security risks of leaking the sensitive data.
2. We can use/switch between multiple providers, as we are storing minimum data to

**Cons:**

1. We will have to store the data used for generating the links as well as the provider type.
2. Link will expire within limited time-frame (as per configuration)

**Technical Design**

**DB Changes**

We will add one column **cloud\_storage\_data** in cassandra table → **bulk\_upload\_process** ,which will store the data on upload. It will be a json format data, in following format.

Above data will be stored in encrypted format within database, so one cannot decipher the data at all.

**Algorithm for approach 1**

* Before marking the status of bulkupload to completed, we will check the type - if it is **Org** or **User** or **Location** , it will continue the following process.

&#x20;      **Note** : Currently only User/Org/Location will use this functionality, hence we will be enabling it only for this 3 functionalities.

* Create a temporary CSV file, with name \_.csv.
* Read the configuration for user-friendly names from system settings.
* Read the first row from results (success/failure) and map the columns to user friendly names to write the first row.
* Add one more column **Result** to mark the results, as Success or Failure
* Now start adding the result rows, from success results first. mark the last column as **Success** in each case.
* Now start adding the result rows from failure results, mark the last column as **Failure** in each case
* Invoke the utility, which uploads the file into cloud storage based on : storageType, container, objectId, with pre-configured timeout.
* Expected environment variable to connect to the cloud-storage. Currently only azure will be supported, which requires two environment variables **AZURE\_ACCOUNT\_NAME, AZURE\_ACCOUNT\_KEY**
* In our case it will be currently&#x20;
  * storageType: "azure",
  * container: "org" or "user",
  * objectId: "user\_101010" or "org\_101110"
* Once successful, store the generated URL into our db column.
* Delete the temporary file.
* Mark the status of upload to Completed.

**Algorithm for approach 2**

* Only step after upload changes, rest are same as approach 1:
  * Once successful, encrypt the data used for uploading in above step as described in **DB Changes** section and store the data into **cloud\_storage\_data** column.

**Public API exposed**

**GET** upload/statusDownloadLink/processId

**Output** :

{

&#x20;"id":"api.upload.status",

"ver":"v1",

"ts":"2018-10-29 17:03:51:282+0530",

"params":{

"resmsgid":null,

"msgid":"1e44fd1f-acad-4f37-a3c5-69928eec98ca",

"err":null,

"status":"success",

"errmsg":null

},

"responseCode":"OK",

"result":{

"response":"signedUrl"

}

}

***

\[\[category.storage-team]] \[\[category.confluence]]
