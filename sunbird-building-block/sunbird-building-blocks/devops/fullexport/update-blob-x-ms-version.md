context: Azure blob has multiple revisions. if the revision is too old (2009) our content player video seek won’t work. For that, we’ve to update the blob version.

There is no straight forward way to do that

The following steps need azure shell in windows machine. Azure cloud shell won’t work because AzureRM module is only supported for desktop app

- Disable all CORS rule for the blob which you want to update as there is some code issue with azure storage sdk which won’t support multiple http headers.

NOTE: Please make a note on cors rule before deleting, it has to be added back once x-ms-version is updated to blob.

ref: [https://github.com/Azure/azure-storage-net/issues/916](https://github.com/Azure/azure-storage-net/issues/916)




```
PS C:\Users\ops> Install-Module -Name AzureRM -AllowClobber

# if for some reason the above command is not working( connection error ) 
# then run the following command and retry
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

PS C:\Users\ops> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

PS C:\Users\ops> Import-Module Azure.Storage

PS C:\Users\ops> $ctx = New-AzureStorageContext -StorageAccountName <storagename>  -StorageAccountKey <key>

PS C:\Users\ops> Update-AzureStorageServiceProperty -ServiceType Blob -DefaultServiceVersion 2014-02-14 -Context $ctx 
```



* Add cors rule





*****

[[category.storage-team]] 
[[category.confluence]] 
