# Migration-of-Data-Products-in-Sunbird-LERN

### &#x20;Objective

Data products is a collection of scala and python scripts which are used to generate reports, updating data in the redis and migration of data.

As of now, https://github.com/Sunbird-Ed/sunbird-data-products repo has all the scripts segregated into various folders based on the purpose of the scripts.

From this migration, all the scripts will be segregated into various repos based on the components of script usage.

### &#x20;Approach of Migration

**→** Data products and etl job scripts will be moved to corresponding repos based on the components of script usage

**→** Base classes and utils will be moved to sunbird-core-dataproducts to distribute the class across different repos' scripts.

### Dependencies of sunbird-data-products

**→ sunbird-analytics-core**

[https://github.com/project-sunbird/sunbird-analytics-core](https://github.com/project-sunbird/sunbird-analytics-core)

Analytics job driver and analytics framework is used to trigger the job in job manager

**→ sunbird-core-dataproducts**

[https://github.com/project-sunbird/sunbird-core-dataproducts](https://github.com/project-sunbird/sunbird-core-dataproducts)

Batch-models module is used from this

**→ sunbird-data-pipeline**

[https://github.com/project-sunbird/sunbird-data-pipeline](https://github.com/project-sunbird/sunbird-data-pipeline)

Ansible role, configuration and inventory are written in this repo

**→ Cassandra**

**→ Postgres**

**→ Redis**

**→ Druid**

**→ APIs**

**→ Azure Blob Container**

Blob container is being used to store the report and serve them to portal.

### Existing Data product folder structure

```
sunbird-data-products
  -> data-products
      -> job (Portal Report jobs)
      -> exhaust (Course Exhaust reports)
      -> sourcing (VDN environment sourcing metrics report)
      -> updater (Cassandra migration job)
      -> audit (Migration and DB correction script)
  -> etl-jobs
      -> analytics (Redis and Druid update script)
      -> learner (Groups and User migration)
  -> adhoc-scripts
  -> python-scripts (Python scripts used to generate reports)
      -> consumption
      -> etb
      -> misc (druid submitter submits the Druid query processor reports)
      -> location
```

### Updated data products

```
data-products
    /ansible (configs)
    /lern-data-products
        /userorg
            /jobs(reports/etl)
        /lms
            /jobs(reports/etl)
        /notification
            /jobs(reports/etl)
        /core
            /util
            /base_classes
    /adhoc-scripts
        /scripts
```

### Data product list

| **Script Name**              | **Objective**                                                        | **Data Provider** | **Estimate** **(hrs)** |
| ---------------------------- | -------------------------------------------------------------------- | ----------------- | ---------------------- |
| exhaust / progressexhaustjob | Generate progress reports of each enrolled user for the course batch | **cassandra**     |                        |

1. user table
2. user\_enrolments
3. assessment\_aggregator
4. user\_activity\_agg

**postgres**

1. job\_request table

**Content search API** | 6 | | exhaust / responseexhaust | Generate reports to identify each enrolled users response to each content on the course | **cassandra**

1. user table
2. user\_enrolments
3. assessment\_aggregator
4. user\_activity\_agg

**postgres**

1. job\_request table

**Content search API** | 6 | | exhaust / userinfoexhaust | Generate reports to get the all enrolled users on the course | **cassandra**

1. user table
2. user\_enrolments
3. user\_consent

**postgres**

1. job\_request table

\| 6 | | exhaust / BaseReportJob | Base class for data-products scripts | | 8 | | exhaust / BaseCollectionExhaustJob | Base class for exhaust jobs | | 12 | | sourcing / contentdetailsreport | Generate reports for the collections and content associated to it for the VDN program | **Druid** vdn-content-model-snapshot | 6 | | sourcing / funnel report | Generate reports for program contributors and contributions for contents. | **Postgres**

1. programs
2. nominations

**content search API** | 6 | | sourcing / sourcing metrics | Generate both the reports for collection and folder level of contributed contents in VDN. | **Druid** content-model-snapshot **Cassandra** content\_hierarchy **Org search API** | 6 | | sourcing / sourcing summary | | | | | job / course consumption | Generate report for consumtion metrics on the course batch | **Druid** summary-events | 6 | | job / course enrolment | Generate report for enrolment details on the course batch | **Elasticsearch** course-batch | 6 | | job / etbmetris | Generate report for textbook and dialcode for collection and dialcode level. | **Druid**

1. telemetry-rollup-syncts
2. content-model-snapshot

**Org search API** **Content hierarchy API** | 12 | | job / stateadminreport | | **Cassandra**

1. user\_declaration
2. user\_consent
3. organisation
4. location
5. user

\| | | job / stateadmingeoreport | | **Cassandra**

1. organisation
2. location
3. user

\| | | job / collectionsummaryjobv2 | Updates collection-summary-snashot druid datasource | **Cassandra**

1. user\_enrolments
2. course\_batch

**API**

1. Druid ingestion task trigger API
2. Content search API

\| 6 | | job / assessmentcorrectionjob | | | | | audit / collection reconcilation | | **Cassandra**

1. assessment\_aggregator
2. user\_enrolments
3. course\_batch
4. user\_content\_consumption
5. content\_hierarchy
6. user\_enrolments\_temp

\| | | audit / assessmentscore correction | | **Cassandra**

1. assessment\_aggregator
2. user\_enrolments

\| | | audit / coursebatch status updater | Updates course batch es index | **Elasticsearch** course\_batch **Cassandra** course\_batch | | | audit / Score metric migration | Migration job to correct and add updated attempt details in assessment\_aggregator table | **Cassandra**

1. assessment\_aggregator
2. user\_activity\_agg

\| 6 | | updater / Cassandramigrator | Migration script add the user\_enrolments data report cluster’s user\_enrolments table | **Cassandra**

1. user\_enrolments

\| 6 | | etl-jobs / analytics / UserCacheIndexer | Updates the user redis cache data with user and location from cassandra | **Cassandra**

1. user
2. location

**User Redis** | 8 | | etl-jobs / learner / GroupsServiceTablesMigration | | **Cassandra**

1. group
2. user\_group
3. group\_member

\| | | etl-jobs / learner / UserLookupMigration | | **Cassandra**

1. user
2. usr\_external\_identity
3. system\_settings

\| | | pythonscripts / content consumption | Consumption of contents for last week and last 6 months as two report files | **Druid**

1. content-model-snapshot
2. summary-rollup-syncts

**API**

1. org search
2. content search

\| 7 | | pythonscripts / ecg\_learning | Trend graph of http request count in Diksha environment for last 7 days | **Prometheus API** | 7 | | pythonscripts / user declaration report | | | | | pythonscripts / user details report | | Files generated from job / stateadmingeoreport will be downloaded from blob store and used to generate the report | | | pythonscripts / druid job submitter | Submit the Druid query processor reports(hawk eye reports) based on the scheduler | **Kafka Topic** analytics.job\_queue **Report search API** | |

### Data product and Owner

| **Script Name**                                   | **Owner**                                   |
| ------------------------------------------------- | ------------------------------------------- |
| exhaust / progressexhaustjob                      | Sunbird-Lern                                |
| exhaust / responseexhaust                         | Sunbird-Lern                                |
| exhaust / userinfoexhaust                         | Sunbird-Lern                                |
| exhaust / BaseReportJob                           | Sunbird-Lern                                |
| exhaust / BaseCollectionExhaustJob                | Sunbird-Lern                                |
| job / course enrolment                            | Sunbird-Lern                                |
| job / course consumption                          | Sunbird-Lern                                |
| audit / collectionsummaryjobv2                    | Sunbird-Lern                                |
| audit / coursebatch status updater                | Sunbird-Lern                                |
| updater / Cassandramigrator                       | Sunbird-Lern                                |
| job / stateadminreport                            | Sunbird-Lern → Diksha                       |
| job / stateadmingeoreport                         | Sunbird-Lern→ Diksha                        |
| job / assessmentcorrectionjob                     | Sunbird-Lern→ Diksha                        |
| audit / collection reconcilation                  | Sunbird-Lern→ Diksha                        |
| audit / assessmentscore correction                | Sunbird-Lern→ Diksha                        |
| audit / Score metric migration                    | Sunbird-Lern→ Diksha                        |
| pythonscripts / user declaration report           | Sunbird-Lern(userorg) deprecated            |
| pythonscripts / user details report               | Sunbird-Lern(userorg) deprecated            |
| etl-jobs / learner / GroupsServiceTablesMigration | Sunbird-Lern - One time script - deprecated |
| etl-jobs / learner / UserLookupMigration          | Sunbird-Lern - One time script - deprecated |
| pythonscripts / content consumption               | Diksha                                      |
| pythonscripts / ecg\_learning                     | Diksha                                      |
| job / etbmetris                                   | Diksha                                      |
| sourcing / contentdetailsreport                   | VDN                                         |
| sourcing / funnel report                          | VDN                                         |
| sourcing / sourcing metrics                       | VDN                                         |
| sourcing / sourcing summary                       | VDN                                         |
| etl-jobs / analytics / UserCacheIndexer           | Sunbird-Obsrv                               |
| pythonscripts / druid job submitter               | Sunbird-Obsrv                               |

### &#x20;Action items

Add 1-2 follow-up action items to help the team apply what they learned in the retrospective:

1incompleteType your action, use @ to assign to someone.

***

\[\[category.storage-team]] \[\[category.confluence]]
