# LERN-data-products-dependency-decoupling-from-other-BB

### &#x20;Objective

LERN Dataproducts is collection of scripts which will be used to generate reports for LERN related data creation and consumption.

Current data products are using some of the data locations from other building blocks.

From this migration, other building block data dependencies will be decoupled.

### Building block dependencies and approaches

| **Job Name**                                                           | **Dependency** | **Approach** |
| ---------------------------------------------------------------------- | -------------- | ------------ |
| <p><strong>Exhaust Jobs</strong></p><ul><li>Progress Exhaust</li></ul> |                |              |

* Response Exhaust
* Userinfo Exhaust

\| \*\*\_Lern BB\_\*\*

* user\_enrolments&#x20;
* assessment\_aggregator
* user\_activity\_agg

\*\*\_Obsrv BB\_\*\*

* User Redis
* Postgres Job\_request table

\*\*\_User ORG\_\*\*

* user\_consent
* system\_settings

\*\*\_Public API\_\*\*

* Content Search API

|

* Move exhaust APIs to Lern
* Deploy Usercache redis in Lern
* Move job\_request table under LERN environment
* Add custodian org details in job config or fetch using system settings API

Need discussion for user\_consent table - | | \*\*Course Consumption\*\* | \*\*\_Lern BB\_\*\*

* Course\_batch cassandra table&#x20;

\*\*\_User ORG\_\*\*

* Organization table from sunbird keyspace

\*\*\_Obsrv BB\_\*\*

* Summary-events druid datasource

\*\*\_Public API\_\*\*

* Content search API

|

* Use public API for getting ORG details
* Disable these jobs via config - cronjob configuration
* Instead of accessing tables directly use apis - scaling issues will come
* internal api calls to druid or public api with token authentication
  * OPA layer implementation for authentication and code changes for the API key credentials in Druid API call.

\| | \*\*Course Enrollment\*\* | \*\*\_Lern BB\_\*\*

* Course\_batch cassandra table
* Course batch elasticsearch index

\*\*\_User ORG\_\*\*

* Organization table from sunbird keyspace

\*\*\_Public API\_\*\*

* Content search API

|

* Use org search API ( \*\*Public API\*\* ) for getting organization details

\| | \*\*State Admin Report\*\* | \*\*\_User ORG BB\_\*\*

* \*\*cassandra table\*\*
  * User
  * User\_declaration
  * User\_consent
  * Location

|

* Use Location search API instead of cassandra table - scaling issue
* Add User\_declaration, User\_consent to Usercache and use it as single data point for user related reports. - multiple entries are there for declaration and consent respective to course and orgs.
  * During update or revoke of consent, cache should be in sync.

Need discussion for user related tables | | \*\*State Admin Geo Report\*\* | \*\*\_User ORG BB\_\*\*

* \*\*cassandra table\*\*
  * Organisation&#x20;
  * Location

\| | | \*\*Collection Summary Job V2\*\* | \*\*\_Lern BB\_\*\*

* user\_enrolments&#x20;
* course\_batch

\*\*\_Obsrv BB\_\*\*

* User Redis
* Druid API to trigger ingestion task for \*\*collection-summary-snapshot\*\*

\*\*\_Public API\_\*\*

* Content Search API

|

* internal api calls to druid or public api with token authentication
  * OPA layer implementation for authentication and code changes for the API key credentials in Druid API call.

\| | \*\*Exhaust API\*\* | Postgres table for job\_request |

* Moving Exhaust API service to LERN
* Move job\_request table under LERN environment

|

***

\[\[category.storage-team]] \[\[category.confluence]]
