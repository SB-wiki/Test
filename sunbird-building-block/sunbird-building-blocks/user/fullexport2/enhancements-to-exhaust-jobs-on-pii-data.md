Sunbird Lern Data products has jobs which generate reports with PII data. After generating the report in a csv file, this file is changed to a pwd protected zip file. 

 **Problem Statement:** 
1. The generated csv file is not deleted.  Once the zip file is created, the csv file has to be deleted.


1. Also created files are not encrypted, only password protection is done. So the PII information is not protected. To ensure that PII is encrypted, the file has to be encrypted. 


1. Identify all the jobs writing PII information as plain text.


1. Ensure that an encryption key is provided by the requester if it is a on-demand exhaust or auto-generate an encryption key if it is a standard exhaust.


1. In case of standard/daily exhaust the auto generated encryption key has to be encrypted and stored and should be decrypted when shown to the user based on his privileges


1. User provided encryption key should also be encrypted when stored in Postgres DB (this might be a data exhaust level api change)


1. The data within the CSV should be encrypted using the encryption key provided by the user.


1. All the above changes should be controlled via instance level configuration to ensure backward compatibility


1. PII fields list should be configurable. Right now the fields that are considered PII are being is assumed within the code. All APIs that are taking user input should validate the data against the PII fields and automatically encrypt while storing it in Cassandra or relevant transactional stores.



 **Affected Areas:** Jobs which will require this change to be implemented:


1. On-demand exhaust - UserInfo exhaust (Ref : [https://lern.sunbird.org/learn/product-and-developer-guide/batch-service/reports#user-personal-info-exhaust](https://lern.sunbird.org/learn/product-and-developer-guide/batch-service/reports#user-personal-info-exhaust) ) 


1. Standard exhaust - Org Consent report (Ref : [https://lern.sunbird.org/learn/product-and-developer-guide/user-and-org-service/reports](https://lern.sunbird.org/learn/product-and-developer-guide/user-and-org-service/reports) )



File type: CSV, ZIP

Code Link : [https://github.com/Sunbird-Lern/data-products/tree/release-5.2.0](https://github.com/Sunbird-Lern/data-products/tree/release-5.2.0)

 **Implementation:** Delete the CSV file after creating zip.

 **On-demand Job:** 

Encrypt the zip file by taking secret key as an input from user while submitting job request in case of exhaust jobs or Encrypt PII data in the CSV before creating zip file.

In UserInfo Exhaust Report, UI, exhaust APIs and job request table will need to have changes to receive the input from user and to store in table. So changes across Ed, Obsrv and Lern BBs. 


*  **Ed -** 




1. Use an env variable to either enable encryption or disable it.


1. For UI changes to receive the input from user.


1. Encryption key should be mandatory if flag is enabled.




*  **Obsrv**  - 




1. Use an env variable to either enable encryption or disable it.


1. Exhaust API changes, to update the encryption key in job request table for each job request. 


1. Encryption key should be mandatory if flag is enabled.


1. Encrypt the key before storing to job_request table.




*  **Lern**  - 




1. Use an env variable to either enable encryption or disable it.


1. Report job changes fetch the encryption from table and decrypt it.  


1. If encryption key is not present, job should continue with out encryption.


1. Use this decrypted key to encrypt the zip file or Encrypt PII data in the CSV before creating zip file.


1. Configure the PII fields that needs encryption. Currently these fields are configured in micro-service, but not in reports.


1. Create a tool which can decrypt/content the file and provide to the user



 **Standard/Daily Job:** 

In Org Consent Report, as these reports are not generated on demand, it not possible to take encryption key as user input. 


*  **Lern -** 




1. Use an env variable to either enable encryption or disable it.


1. Encrypt the zip file using the auto generated encryption key if flag is enabled.


1. OR key given by the adopter by storing it as an env variable. (This also should be encrypted while storing). But in this case if different tenants need different keys then it will have to be configured tenant wise.


1. If auto generated encryption key, then key should be encrypted and stored in the same folder as the zip file. This should be decrypted when shown to the user based on his privileges. 


1. Report job changes fetch the ecryption key and decrypt it. 


1. Use this decrypted key to encrypt the zip file or Encrypt PII data in the CSV before creating zip file.


1. Configure the PII fields that needs encryption. Currently these fields are configured in micro-service, but not in reports.


1. This will require only Lern BB code changes if one key is stored by default or stored based on tenants. 


1. Create a tool which can decrypt the file/content and provide to the user




*  **Ed - (if the key has to be auto generated and stored for each report)** 




1. Use an env variable to either enable encryption or disable it.


1. SB-Ed changes are required to fetch and decrypt and display the key to the user based on user privilege.




### Assumptions:

1. We will be using AES (symmetric) single key encryption, not RSA (asymmetric) using a pair of keys.


1. Also decryption will be done by the user with the key provided. Not while downloading the report.


1. Standard exhaust scenario, if the secret key has to be decrypted and displayed to user, the code for that will be in Ed backend.





 **Queries:** 


1. Either the whole file can be encrypted or only the PII data in the file. Which is preferred?





*****

[[category.storage-team]] 
[[category.confluence]] 
