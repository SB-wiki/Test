# Deployment-Steps-for-Keycloak-User-Federation

\*\*Jira Link :  \*\* [https://project-sunbird.atlassian.net/browse/SC-911](https://project-sunbird.atlassian.net/browse/SC-911)

\*\*Design Doc : \*\* \[\[Encrypting data stored within keycloak|Encrypting-data-stored-within-keycloak]]

**Note:  Take back up of keycloak database.**

**Steps :**

1. Checkout [https://github.com/project-sunbird/sunbird-auth](https://github.com/project-sunbird/sunbird-auth) code and **switch to release-1.15 branch** and make build.
2. Create providers folder inside keycloak
3. Copy built jar (i.e.keycloak-email-phone-autthenticator-1.0-SNAPSHOT.jar) to providers folder
4. Run the keycloak
5. Login to admin console and click User Federation tab on left panel of the screen. As shown in fig. ![](../../../../Design/FullExport/images/storage/image2019-3-29\_13-4-51.png)
6. Select cassandra-storage-provider from Add provider drop down on the screen , then you will be redirected to screen as shown ![](../../../../Design/FullExport/images/storage/image2019-3-29\_13-7-16.png)
7. Click save button , It will generate one provider id as shown                                                                                                               ![](../../../../Design/FullExport/images/storage/image2019-3-29\_13-10-57.png)
8.  Copy this provider id and save this as env variable ( in learner-service) \*\*sunbird\_keycloak\_user\_federation\_provider\_id  , \*\* along with                                                                                                                                                **sunbird\_authorization**

    **sunbird\_cassandra\_host**

    **sunbird\_encryption\_key**

    **sunbird\_sso\_username**

    **sunbird\_sso\_password**

    **sunbird\_sso\_url**

    **sunbird\_sso\_realm**

    **sunbird\_sso\_client\_id**

    **sunbird\_cs\_base\_url**
9. Run below SQL queries on Keycloak database **after replacing** values for placeholders {PROVIDER\_ID} and {realm name} in below query templates. Value of placeholders {PROVIDER\_ID} and {realm name} is based on environment variables  _sunbird\_keycloak\_user\_federation\_provider\_id_ and  _sunbird\_sso\_realm_ respectively.

**Query Templates**                &#x20;

```
insert into FEDERATED_USER(ID, STORAGE_PROVIDER_ID, REALM_ID)select concat('f:{PROVIDER_ID}:', USER_ENTITY.ID), '{PROVIDER_ID}', '{realm name}' from public.USER_ENTITY;

insert into FED_USER_CREDENTIAL(ID, DEVICE, HASH_ITERATIONS, SALT, TYPE, VALUE, CREATED_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, USER_ID,                  REALM_ID,STORAGE_PROVIDER_ID) select ID, DEVICE, HASH_ITERATIONS, SALT, TYPE, VALUE, CREATED_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, concat('f:{PROVIDER_ID}:',USER_ID), '{realm name}', '{PROVIDER_ID}' from CREDENTIAL;

insert into FED_USER_REQUIRED_ACTION(REQUIRED_ACTION, USER_ID, REALM_ID, STORAGE_PROVIDER_ID)
select REQUIRED_ACTION, concat('f:{PROVIDER_ID}:', USER_ID), '{realm name}', '{PROVIDER_ID}' from USER_REQUIRED_ACTION;
```

**Example:**

{PROVIDER\_ID} = 5a8a3f2b-3409-42e0-9001-f913bc0fde31

{realm name} = sunbird

```
insert into FEDERATED_USER(ID, STORAGE_PROVIDER_ID, REALM_ID) select concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:', USER_ENTITY.ID), '5a8a3f2b-3409-42e0-9001-f913bc0fde31', 'sunbird' from public.USER_ENTITY;

insert into FED_USER_CREDENTIAL(ID, DEVICE, HASH_ITERATIONS, SALT, TYPE, VALUE, CREATED_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, USER_ID, REALM_ID,STORAGE_PROVIDER_ID) select ID, DEVICE, HASH_ITERATIONS, SALT, TYPE, VALUE, CREATED_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:',USER_ID), 'sunbird', '5a8a3f2b-3409-42e0-9001-f913bc0fde31' from CREDENTIAL;

insert into FED_USER_REQUIRED_ACTION(REQUIRED_ACTION, USER_ID, REALM_ID, STORAGE_PROVIDER_ID) select REQUIRED_ACTION, concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:', USER_ID), 'sunbird', '5a8a3f2b-3409-42e0-9001-f913bc0fde31' from USER_REQUIRED_ACTION;
```

&#x20;      10\.  Run the ETL to delete the user from keycloak. (To be run only in case of Sunbird upgrade)

***

\[\[category.storage-team]] \[\[category.confluence]]
