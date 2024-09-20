# Azure-SAS-Token-usage-in-Sunbird-Design-Document.

* **Existing structure:-**
  * We have multiple storage accounts, with different storage containers with different ACLS \[Public, Blob, Container] **.**
* **Refactoring of Storage containers:-**
  * Identify all the Storage accounts in all Environments and services using them and migrating the storage containers based on the storage account strategy.
* **Storage Account Strategy:**
  * **Have 3 different Storage accounts per environment**
  * **Public Storage Account:-** with all the containers with public acccess like CDN\[Portal and Player, HTML/CSS/JS files, FAQ's]
  * **Private Storage Account** \[Reports, Telemetry]
  * **Backups** \[All DB Backups]
  * **Having 2 or Single Storage Accounts** **per environment** &#x20;
  * **Application Account:** Single Storage Account for all the applications with SAS and Container ACL for restricting access.
  * **Backups Account:** Backups of All DB's \[We can eliminate this as well by migrating to application container with container ACL and SAS Strategy]
* **SAS Overview:-**
  * A shared access signature (SAS) provides secure delegated access to resources in your storage account without compromising the security of your data. With a SAS, you have granular control over how a client can access your data. You can control what resources the client may access, what permissions they have on those resources, and how long the SAS is valid, among other parameters.
  * **SAS can be generated For:-**
  * Blob
  * Folder
  * Container
  * Storage Account
  * SAS will have starting and ending time in which it will be valid for the service it is created for.
  * It is one of the best practice to connect to the blob data by the application using SAS token instead of the key.
* **Security Features of SAS:-** &#x20;
  * Fine grained access control, we can give only read/write access to container/storage account
  * Time Based Access
  * Generate SAS for a Blob, for a folder, for a container or for a storage account.
  * can encrypt data in transit by allowing only HTTPS calls and restricting any http calls.
* **Infra Changes:-**
  * Migrate the existing containers to accepted storage account strategy and update all the variables and deploy the dependent services.
* **Code Changes are required:-**
  * Change code to use sas token instead of keys by our application, Changes are required by Dev team for the application data and Devops team for the build artifacts and backups.
* **SAS Token Design:-**
  * Generate token to container instead of storage account.
  * For generation of key we have to sign the SAS token with Storage Account key. To invalidate the SAS token we have to rotate the key from which the SAS is created.
  * SAS tokens can't be invalidated one at a time and
  * Use both the keys of storage account to generate SAS tokens and have a list of them to rotate the SAS tokens by rotating the Storage Keys.
  * Have a SAS Token revocation plan like 3 years or yearly.
  * Have a key rotation period set as a google calender for each environment to rotate the keys before they expire.
* **SAS Token POC Commands:-**
  * **NOTE:** Time is always in UTC so convert the time from your standard time to UTC to generate the SAS Token.
  * **Terminilogy:-**
  * **ACCOUNT\_KEY** = Storage Account key.
  * **ACCOUNT\_NAME** = Storage Account name.
  * **SAS\_TOKEN** = Shared Access Signature token.
  * **CONTAINER\_NAME** = Storage Container Name.
  * **Generate SAS for storage account**
  * az storage account generate-sas --account-key ACCOUNT\_KEY --account-name ACCOUNT\_NAME --resource-types sco --services bfqt --permissions acdlpruw --start 2019-11-20 --expiry 2020-11-20
  * **USE SAS generated for storage account to list the containers:-**
  * az storage container list --account-name ACCOUNT\_NAME --sas-token "SAS\_TOKEN"
  * **USE SAS generated for storage account to upload contents in blobs** :-
  * az storage blob upload --account-name ACCOUNT\_NAME --sas-token "SAS\_TOKEN" --container-name CONTAINER\_NAME --name fileNameInBlob --file localFileName
  * **USE SAS generated for storage account to delete contents in blobs:-**
  * az storage blob delete --account-name ACCOUNT\_NAME --sas-token "SAS\_TOKEN" --container-name CONTAINER\_NAME --name fileNameInBlob
  * **USE SAS generated for storage account to create container:-**
  * az storage container create --name CONTAINER\_NAME --account-name ACCOUNT\_NAME --sas-token "SAS\_TOKEN"
  * **USE SAS generated for storage account to delete container:-**
  * az storage container delete --name CONTAINER\_NAME --account-name ACCOUNT\_NAME --sas-token "SAS\_TOKEN"
* **Azure Reference LINKS:-**
  * **https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview**
  * **https://blogs.msdn.microsoft.com/windowsazurestorage/2012/06/12/introducing-table-sas-shared-access-signature-queue-sas-and-update-to-blob-sas/**
  * **https://docs.microsoft.com/en-us/rest/api/storageservices/define-stored-access-policy**
  * **https://docs.microsoft.com/en-us/cli/azure/storage/container?view=azure-cli-latest#az-storage-container-generate-sas**
  * **https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas**

***

\[\[category.storage-team]] \[\[category.confluence]]
