# Keycloak-Configuration

As part of relase-2.0.0, we are encrypting data in cassandra DB and removing users from Keycloak DB. Below are the steps that need to be performed for Sunbird to work.

\*\*Jira Link :  \*\* [https://project-sunbird.atlassian.net/browse/SC-911](https://project-sunbird.atlassian.net/browse/SC-911)

\*\*Design Doc : \*\* [Encrypting data stored within keycloak](https://project-sunbird.atlassian.net/wiki/spaces/SBDES/pages/1014988860/Encrypting+data+stored+within+keycloak)

**Note:  Take back up of keycloak database**

\*\*Switch to postgres user and run \*\*

```
pg_dump keyclaok > keycloak_backup.db
```

**Configuration Steps :**

* Login to admin console and click User Federation tab on left panel of the screen. As shown in fig.

![](../../../../DevOps/FullExport/images/storage/image2019-3-29\_13-4-51.png)

* Select cassandra-storage-provider from Add provider drop down on the screen , then you will be redirected to screen as shown&#x20;

![](../../../../DevOps/FullExport/images/storage/image2019-3-29\_13-7-16.png)

* Click save button , It will generate one provider id as shown                                                                                                            &#x20;

![](../../../../DevOps/FullExport/images/storage/image2019-3-29\_13-10-57.png)

* Copy the provider id and update the private repo inventory under Core/secrets.yml for the variable **core\_vault\_sunbird\_keycloak\_user\_federation\_provider\_id**
* Run below SQL queries on Keycloak database after replacing values for placeholders {PROVIDER\_ID} and {realm name} in below query templates. Value of placeholders {PROVIDER\_ID} and {realm name} is based on environment variables _**core\_sunbird\_keycloak\_user\_federation\_provider\_id**_  and  _**keycloak\_realm**_  respectively.

These below are Postgres queries. So you need to login to postgres and run these queries on keycloak db. Below is the code to switch to keycloak DB

\| psql (9.5.17, server 9.5.16) Type "help" for help.postgres=> **\l** postgres=> **\c keycloak** You are now connected to database "keycloak"  |

**Query Templates**                &#x20;

\| insert into FEDERATED\_USER(ID, STORAGE\_PROVIDER\_ID, REALM\_ID)select concat('f:{PROVIDER\_ID}:', USER\_ENTITY.ID), '{PROVIDER\_ID}', '{realm name}' from public.USER\_ENTITY; insert into FED\_USER\_CREDENTIAL(ID, DEVICE, HASH\_ITERATIONS, SALT, TYPE, VALUE, CREATED\_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, USER\_ID,                  REALM\_ID,STORAGE\_PROVIDER\_ID) select ID, DEVICE, HASH\_ITERATIONS, SALT, TYPE, VALUE, CREATED\_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, concat('f:{PROVIDER\_ID}:',USER\_ID), '{realm name}', '{PROVIDER\_ID}' from CREDENTIAL; insert into FED\_USER\_REQUIRED\_ACTION(REQUIRED\_ACTION, USER\_ID, REALM\_ID, STORAGE\_PROVIDER\_ID)select REQUIRED\_ACTION, concat('f:{PROVIDER\_ID}:', USER\_ID), '{realm name}', '{PROVIDER\_ID}' from USER\_REQUIRED\_ACTION; |

**Example:**

{PROVIDER\_ID} = 5a8a3f2b-3409-42e0-9001-f913bc0fde31

{realm name} = sunbird

\| {PROVIDER\_ID} = 5a8a3f2b-3409-42e0-9001-f913bc0fde31{realm name} = sunbird

\| insert into FEDERATED\_USER(ID, STORAGE\_PROVIDER\_ID, REALM\_ID) select concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:', USER\_ENTITY.ID),'5a8a3f2b-3409-42e0-9001-f913bc0fde31','sunbird'frompublic.USER\_ENTITY; insert into FED\_USER\_CREDENTIAL(ID, DEVICE, HASH\_ITERATIONS, SALT, TYPE, VALUE, CREATED\_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, USER\_ID, REALM\_ID,STORAGE\_PROVIDER\_ID) select ID, DEVICE, HASH\_ITERATIONS, SALT, TYPE, VALUE, CREATED\_DATE, COUNTER, DIGITS, PERIOD, ALGORITHM, concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:',USER\_ID),'sunbird','5a8a3f2b-3409-42e0-9001-f913bc0fde31'from CREDENTIAL; insert into FED\_USER\_REQUIRED\_ACTION(REQUIRED\_ACTION, USER\_ID, REALM\_ID, STORAGE\_PROVIDER\_ID) select REQUIRED\_ACTION, concat('f:5a8a3f2b-3409-42e0-9001-f913bc0fde31:', USER\_ID),'sunbird','5a8a3f2b-3409-42e0-9001-f913bc0fde31'from USER\_REQUIRED\_ACTION; |

|

This completes the Keycloak configurations. Next we will be running migration scripts for Cassandra and Keycloak

***

\[\[category.storage-team]] \[\[category.confluence]]
