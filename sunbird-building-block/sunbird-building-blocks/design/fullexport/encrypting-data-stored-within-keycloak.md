Jira Link: [SC-911 Encryption of data in keycloak](https://project-sunbird.atlassian.net/browse/SC-911)

 **Overview** 

Sunbird uses Keycloak as tool for identity management services. The default storage mechanism stores the user-data in plain format within its local database. We have certain sensitive information such as mobile number, e-mail - which needs to be secured. So, we need a way to ensure the such highly sensitive data is secured, by storing it in encrypted format while being stored via Keycloak

To summarize we need to resolve following problems, in order to implement such encryption.


* Within end-storage (database) user data such as mobile and e-mail need to be stored in encrypted format


* We need to decrypt the data, while communicating with the end-user. For example, for sending email or sms - we need to be able to decrypt the data. 


* We need to eventually migrate all existing user data, and store it in encrypted format.





 **Problem Statement 1:** No one should be able to access the sensitive information, even if they have dump/access of Keycloak database.

 **Approach 1:** Encrypt user data, just before sending requests to Keycloak

In this approach we would encrypt user data just before creating/updating the data into key-cloak. 

We will have to write one-time migration as well, to update all the user-data and store it in encrypted format.

 **Overall steps:** 


* Encrypt user email and phone number, just before converting them to user-reprsentation and storing it into Keycloak. 


* While log-in check the incoming data, plainly search user-name, then encrypt and search against phone-number and e-mail. If a match found - allow the user to log-in. 


* Internally write migration to migrate and encode existing user data. Within user property add a Boolean which depicts whether user is migrated or not. So that it is easier to find and resume the background migration process. 



 **Pros:** 


* Simple to implement within existing infrastructure.


* No additional SPI implementation required. No new storage need to be created.



 **Cons:** 


* Keycloak admin - is not usable to search user information based on e-mail/phone. 


* Searching can only be done on exact strings, as we have to search the data after encrypting the search key. 





 **Approach 2:** Implement User Storage SPI mechanism provided by keycloak

In this approach, we can use the Keycloak capabilities to use a different user store, rather than default database store provided by keycloak. This will give lot of flexibility to us - as far as the implementation choices are concerned. Like we can choose what user attributes we want to store, which database we want to use to store user credentials data, whether we want to encrypt/decrypt data before storage. 

In this case we have to implement multiple interfaces, to be able to support it. 

 **Where primary interfaces are:** 


* User lookup, query & registration interfaces. 


* One interface implementation is required to provide configuration to be listed under User Federation screen on keycloak.


* There are other capabilities like support for password types and password update interfaces, that can be implemented to store/validate password against our database. e.g. here we can take input for connecting to user database, where user data will be stored. 



 **Overall solution:** 


* Implement the required User Storage SPI interfaces, and deploy them with keycloak installation.


* Within implementation make sure, within database, all user sensitive data is stored only after encryption.


* While fetching data, data is decrypted before returning the results. 


* Set-up keycloak to use the implemented User Storage SPI.


* One time migration of data from Keycloak to new database needs to be done. 


* Now each time user tries to log-in the request will automatically go to our implementation, which can take care of encrypting/decrypting the data. 



 **Pros** 


* This keeps the data as readable within Keycloak administration pages.


* This gives more flexibility in how we model user information. 


* No repetition of user-data storage like phone, email and many fields are stored within our database already. 



 **Cons** 


* Need to adapt, in future if keycloak interfaces are updated along with newer versions


* Additional administration cost, as user federation need to be set-up


* One time migration from keycloak database to our database would be required. 





 **Problem 2:** Decrypting data while processing when necessary

There are couple of notifications that are sent to user regarding registration and forgot password. 


* User welcome e-mail is sent post successful creation, and keycloak data is not read at that point of time.


* Forgot password is implemented using Authentication SPI, and hence would require us to decrypt the data to do further processing. 


* When user sends the data for forget password, look-up user using user-name without encrypting, if not found, encrypt and search based on e-mail or phone. Once found, load the user data.


* Decrypt the user data and finally send the e-mail/SMS notification based on this data. 





 **Problem 3:** One time migration of user data.

In either approaches, we take to encrypt data, migration of data is required to encrypt the old data. 

 **Approach 1:**  Based on log-in trigger check and encrypt the data. 

Whenever user logs-in, check the data within Keycloak, we look-up without encrypting, if user record found, we check data and encrypt and update the user-data, in background. 

 **Pros:** Dynamic migration, which means less down-time.

 **Cons** : Multiple calls to keycloak, and increase in system load as migration is happening on actively used system.



 **Approach 2:** Write one time migration - to encrypt user data


* Read all users from Keycloak user get user api, with pagination parameters 


* Read the data, and encrypt the user sensitive data, and call update of Keycloak.


* In case of failure, process will have to restart, and check - if user is already encrypted skip the user. 


* Once all user-records are processed, return success.



 **Pros:** One time job, so no load when actual system operations are running.

 **Cons:** In between down-time, while migrating users.



 **Approach 3:** Write background job, which keeps on migrating user-data


* Within keycloak, add boolean column “migrated” in user table. Default value to false.


* Scheduled background job will run and check the users whose migrated column is false.


* Process the data, and encrypt the data within keycloak. 


* Once user is migrated update the column within cassandra database for that specific user. 


* Once the migration is completed, we need to set a flag in system-settings to “all-users-migrated” to true.


* Until this point, we need to verify or look-up user based on raw value as well as encrypted value. 



 **Pros:** Migration runs in background. It will only impact dual look-up until all users are migrated.

 **Cons:** Additional queries until all entries are migrated.





*****

[[category.storage-team]] 
[[category.confluence]] 
