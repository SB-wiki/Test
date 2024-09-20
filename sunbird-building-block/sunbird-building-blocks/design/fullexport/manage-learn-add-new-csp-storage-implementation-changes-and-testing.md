
## Context
This document details how to enable any new CSP provider for Manage Learn capabilities which is part of Sunbird Ed




* Manage Learn capabilities currently support  Azure, AWS, OCI, and GCP


* ML Core Service interacts with cloud storage for upload/download operation, and all other services(Survey, Projects, and Reports) as well as mobile apps and portals use these APIs for their needs:


    * Get a Signed URL (To upload assets to the cloud)


    * Get Downloadable URL



    
* In Mongo DB where all the transactions of projects and observations are stored, only the relative path of the evidences of assets uploaded by users is captured. Bucket and CSP details are provided via config to the ML Core service.


* In order to add support for any other cloud storage (e.g: Digital Ocean), below steps need to be followed:




## ml-core-service:

### Git Repos: [https://github.com/project-sunbird/ml-core-service/tree/release-5.1.0](https://github.com/project-sunbird/ml-core-service/tree/release-5.1.0)
 **Latest branch** : release-5.1.0



Step 1:- Introduce the necessary environment configuration basis the env sample as below (Refer - [https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/.env.sample](https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/.env.sample) )



Sample ENV Configuration for AWS/GCP/OCI/AZURE
```
#Cloud Storage Configuration
CLOUD_STORAGE = "AWS/GC/AZURE/OCI"                                                  // Cloud storage provider.

# Google Cloud Configuration
GCP_PATH = "./generics/helpers/credentials/storage.json"                        // Path to the the Google cloud authentication key
GCP_BUCKET_NAME = "gcp bucket name"                                             // Google cloud bucket name 

# Azure Cloud Configuration
AZURE_ACCOUNT_NAME = "AZURE_KEY"                                                // Azure account name
AZURE_ACCOUNT_KEY = "Ih..............NBN"                                       // Azure account key
AZURE_STORAGE_CONTAINER = "Azure_bucket"                                        // Azure container/bucket name

# AWS Cloud Configuration
AWS_ACCESS_KEY_ID = "AK...........WA"                                           // Aws cloud storage access key id
AWS_SECRET_ACCESS_KEY = "QB......................9sB"                           // Aws cloud storage access key
AWS_BUCKET_NAME = "aws bucket name"                                             // Aws cloud storage bucket name
AWS_BUCKET_REGION = "ap-south-1"                                                // Aws cloud storgae region
AWS_BUCKET_ENDPOINT = "s3.ap-south-1.amazonaws.com"                             // Aws cloud storage api's endpoint

# Oracle Cloud Configuration                                                    
OCI_ACCESS_KEY_ID = '23b90..............d01d'                                   // Oracle cloud storage access key Id
OCI_SECRET_ACCESS_KEY = '22levMw5Ci............SmNE='                           // Oracle cloud storage secret access key 
OCI_BUCKET_NAME = 'oracle cloud bucket name'                                    // Oracle cloud bucket name
OCI_BUCKET_REGION = 'ap-hyderabad-1'                                            // Oracle cloud bucket region
OCI_BUCKET_ENDPOINT = 'https://pmt5.compat.storage.ap-h1.oraclecloud.com'       // Oracle cloud bucket endPoint 
```




Step 2 - Define environment key for bucket name for preSignedUrls and getDownloadableUrl functions in here - [https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/module/cloud-services/files/helper.js](https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/module/cloud-services/files/helper.js)

Step 3 - Modify functions of [https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/module/files/helper.js](https://github.com/project-sunbird/ml-core-service/blob/release-5.1.0/module/files/helper.js)  to enable new cloud provider 

Step 4 - Add support for new cloud provider in the module here - [https://github.com/project-sunbird/ml-core-service/tree/release-5.1.0/module/cloud-services](https://github.com/project-sunbird/ml-core-service/tree/release-5.1.0/module/cloud-services)



 **Note - Include new library via package.json and keep same function signatures in new module files added** 



Step 5 - Override value for below variables under private devops repo (file path:  **ansible/inventory/<env_name>/Core/common.yml** ) for new storage account:

ml_cloud_config

Step 6 - After Configuration Change, Deploy the service.

Step 7 - Test the 2 APIs as mentioned under  **Context**  section.


# Adding New Cloud Libraries for data-pipeline
This document details about integration points for any new CSP provider with ml-analytics platform.

ml-analytics release-5.1.0,  latest as on Dec, 2022

Few points to note:


* ml-analytics-service has integrated code with Azure, AWS, Oracle and GCP.


* ml-analytics-service uses cloud for pre-processed data to be pushed before ingesting into Druid datasources.



noteIn order to add support for any other cloud storage under ml-analytics components, below steps need to be followed:

In order to add support for any other cloud storage under ml-analytics components, below steps need to be followed:


### Git repository: 
[https://github.com/Sunbird-Ed/ml-analytics-service](https://github.com/Sunbird-Ed/ml-analytics-service)Latest Branch: release-5.1.0
### Changes to the cloud_storage folder:

1. Add a new blank file with the name of the cloud service provider with the name of the cloud provider (Eg: ms_azure.py, oracle.py). Make sure the file is created inside the cloud_storage folder in the same hierachy as other files such as ms_azure.py, gcp.py


1. Import relavant and necessary libraries that can interact with the new cloud provider.


1. Define a Python Class Object .


1. Under the intilization method or __init__, construct and initlialize variables that identify the  - 


    1. Cloud account ID


    1. Cloud account Key


    1. Cloud account storage container/blob


    1. Any other necessary variable that need to be initiated to interact with the cloud storage (Eg: token, type)



    
1. Create a Class-method named upload_files that has three (3) arguments - 


    1. bucketPath - Accepts the cloud account storage container/blob


    1. localPath- Accept the local path of where the file is generated


    1. fileName- Accepts the name of the file



    
1. Then call the upload function from the library.



An example of the code is given below:


```py
### -----Step 2 ----- ###
import os
import boto3

### ---- Step 3 ---- ###
class Oracle:
    '''
    Class to inititate and upload data in Oracle
    '''

### ---- Step 4 ---- ###
    def __init__(self, regionName, accessKey, secretAccessKey, endpoint_url, bucketName):
        self.oracle = boto3.client(
            service_name = 's3',
            region_name = regionName,
            aws_access_key_id = accessKey,
            aws_secret_access_key = secretAccessKey,
            endpoint_url = endpoint_url
        )
        self.bucket = bucketName

### ---- Step 5 ---- ###        
    def upload_files(self, bucketPath, localPath, fileName):
    
### ---- Step 6 ---- ###        
        with open(f"{localPath}/{fileName}", "rb") as file:
            self.oracle.upload_fileobj(file, self.bucket, f"{bucketPath}/{fileName}")
```

### Changes to the cloud.py file

1. Import the Library you created in the cloud.py file


1. Inside the MultiCloud Class - look for upload_to_cloud method


1. Add an elif statement that refer to the recently created cloud library- 


    * Initialize the cloud library by passing in the necessary parameters


    * Call the upload_files method and pass in these below values:


```py
<<name_of_service>>_service.upload_files(bucketPath = blob_Path, localPath = local_Path, fileName = file_Name)
```


    

An example of the code is shown below:


```py
### ---- Step 1 ---- ###
from from oracle import Oracle
...

### ---- Step 2 & 3 ---- ### 
elif elements == "ORACLE":
                oracle_service = Oracle(
                    regionName = config.get("ORACLE", "region_name"),
                    accessKey = config.get("ORACLE", "access_key"),
                    secretAccessKey = config.get("ORACLE", "secret_access_key"),
                    endpoint_url = config.get("ORACLE", "endpoint_url"),
                    bucketName = config.get("ORACLE", "bucket_name")
                )
                oracle_service.upload_files(bucketPath = blob_Path, localPath = local_Path, fileName = file_Name)
```

### Changes to the config.sample file
For the config.sample file, append a section in the config file:

An example is provided below:


```text
[ORACLE]

endpoint_url = {{ ml_ORACLE_endpoint_url }}

access_key = {{ ml_ORACLE_access_key }}

secret_access_key = {{ ml_ORACLE_secret_access_key }}

region_name = {{ ml_ORACLE_region_name }}

bucket_name = {{ ml_ORACLE_bucket_name }}
```
Post adding these changes - [this repository ](https://github.com/project-sunbird/sunbird-devops/blob/master/ansible/roles/ml-analytics-service/defaults/main.yml)needs to be updated with the relevant values of the the added configuration variables. 





*****

[[category.storage-team]] 
[[category.confluence]] 
