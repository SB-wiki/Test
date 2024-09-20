# Implementation-of-ML-Report-with-the-analytics-data-product-framework

**INTRODUCTION:**

The ML reports provide the program managers and admins detailed data on different solutions that are rolled out as a part of a state-run programs. As of now, there are 4 different types of solutions: Observation with a rubric, observation without a rubric, surveys, and projects. Each type of solution has its own data on the solutions consumed by the users.

Jira Link : [https://project-sunbird.atlassian.net/browse/SB-24105](https://project-sunbird.atlassian.net/browse/SB-24105)

*   **Project Report** : Enables user to undertake a set of action projects purposefully with a specific objective in a specific period of time. Education leaders can create projects, invite others as collaborators, assign timelines, execute and monitor progress.

    ```
              1.  **Task Report**  : Details of the projects assigned to User

              2.  **Status Report**  : Tracking status of project
    ```
*   **Observation Report** : Equips user to create their own framework and assess individuals of the education system including HMs , teachers and other officials.

    ```
               1.  **Status Report**  :  Status of the observation form assigned to user

               2.  **Question Report**  : Observation form detail assigned to user
    ```
*   **Observation with Rubric :**

    ```
               1.  **Status Report**  : Status of the observation form assigned to user with rubric form

               2.  **Question Report**  : Observation form detail assigned to user with rubric form 

               3.  **Domain criteria Report**  : Domain and criteria data with rubric form assigned to user
    ```

**Proposed Design for Data Product** : A new data product for Ml Reports to be implemented with the defined data product framework. This Report is generated based on Demand. An independent Data exhaust using Scala would be coded and extends BaseReportsJob. A generic ML Data product would be written to handle all these 7 different data exhausts that are listed above.

**Submit Api** : It is an existing api which will be used in our Data Product

![](<../../../../Analytics/Fullexport/images/storage/flow chart.png>)

**Queries** :

Postgress Request Body

```
{
    "request": {
    "dataset": "druid-dataset",
    "datasetConfig": {"type": "ml-task-detail-exhaust","params":{"programId" :"601429016a1ef53356b1d714","state_slug" : "apekx","solutionId" : "601d41607d4c835cf8b724ad"}},
    "encryptionKey": "test@123"
  }
}
```

Druid Query

```
{
  "queryType": "scan",
  "dataSource": "dev-ml-project",
  "intervals": "1901-01-01T00:00+00:00/2101-01-01T00:00:00+00:00",
  "columns": [
    "createdBy",
    "designation",
    "state_name",
    "district_name",
    "block_name",
    "school_name",
    "school_externalId",
    "organisation_name",
    "program_name",
    "program_externalId",
    "project_id",
    "project_title_editable",
    "project_description",
    "area_of_improvement",
    "project_duration",
    "tasks",
    "sub_task",
    "task_evidence",
    "task_remarks"
  ],
  "filters": [
    {
      "type": "equals",
      "dimension": "private_program",
      "value": "false"
    },
    {
      "type": "equals",
      "dimension": "sub_task_deleted_flag",
      "value": "false"
    },
    {
      "type": "equals",
      "dimension": "task_deleted_flag",
      "value": "false"
    },
    {
      "type": "equals",
      "dimension": "project_deleted_flag",
      "value": "false"
    }
  ]
}
```

Model Params

```
{
  "search": {
    "type": "none"
  },
  "model": "org.sunbird.analytics.exhaust.MLDruidExhaustJob",
  "modelParams": {
    "reportConfig": {
      "id": "ml-task-detail-exhaust",
      "queryType": "scan",
      "dateRange": {
        "staticInterval": "1901-01-01T00:00+00:00/2101-01-01T00:00:00+00:00",
        "granularity": "all"
      },
      "metrics": [
        {
          "metric": "total_content_plays_on_portal",
          "label": "total_content_plays_on_portal",
          "druidQuery": {
            "queryType": "scan",
            "dataSource": "dev-ml-project",
            "intervals": "1901-01-01T00:00+00:00/2101-01-01T00:00:00+00:00",
            "columns": [
              "createdBy",
              "designation",
              "state_name",
              "district_name",
              "block_name",
              "school_name",
              "school_externalId",
              "organisation_name",
              "program_name",
              "program_externalId",
              "project_id",
              "project_title_editable",
              "project_description",
              "area_of_improvement",
              "project_duration",
              "tasks",
              "sub_task",
              "task_evidence",
              "task_remarks"
            ],
            "filters": [
              {
                "type": "equals",
                "dimension": "private_program",
                "value": "false"
              },
              {
                "type": "equals",
                "dimension": "sub_task_deleted_flag",
                "value": "false"
              },
              {
                "type": "equals",
                "dimension": "task_deleted_flag",
                "value": "false"
              },
              {
                "type": "equals",
                "dimension": "project_deleted_flag",
                "value": "false"
              }
            ]
          }
        }
      ],
      "labels": {
        "createdBy": "UUID",
        "designation": "Role",
        "state_name": "Declared State",
        "district_name": "District",
        "block_name": "Block",
        "school_name": "School Name",
        "school_externalId": "School ID",
        "organisation_name": "Organisation Name",
        "program_name": "Program Name",
        "program_id": "Program ID",
        "project_id": "Project ID",
        "project_title_editable": "Project Title",
        "project_description": "Project Objective",
        "area_of_improvement": "Category",
        "project_duration": "Project Duration",
        "tasks": "Tasks",
        "sub_task": "Sub-Tasks",
        "task_evidence": "Evidence",
        "task_remarks": "Remarks"
      },
      "output": [
        {
          "type": "csv",
          "metrics": [
            "total_content_plays_on_portal"
          ],
          "dims": [],
          "fileParameters": []
        }
      ]
    },
    "store": "azure",
    "container": "'$bucket'",
    "key": "druid-ml-data-exhaust/"
  },
  "output": [
    {
      "to": "file",
      "params": {
        "file": "src/test/resources/ml-druid-data-detail"
      }
    }
  ],
  "parallelization": 8,
  "appName": "ML Druid Data Model"
}
```

Submit Api CURL

```
curl -X POST \
   \
  -H 'authorization:  <AUTH-KEY>
  -H 'channel':  <CHANNEL-ID>  
  -H 'content-type: application/json' 
	"request" :{
	"dataset": "ml-projects-cumulative",
	"tag": "0126796199493140480",
	"datasetConfig": {
     "programId" :"601429016a1ef53356b1d714"
     "solutionId" : "601d41607d4c835cf8b724ad",
     "state_slug" : "apekx"
    },
    "encryptionKey": "test@123"
	}
}'
```

**Output Csv** :

1. Project Task Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School ID | Unique identifier of the School mapped to the entity | String | | 8 | School Name | Name of the School mapped to the entity | String | | 9 | Org Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | Domain Name | Name of the Theme | String | | 15 | Domain Level | Level (L1, L2 , L3 … ) of the Themes | String | | 16 | Criteria Name | Name of the Criteria | String | | 17 | Criteria Level | Level (L1, L2 , L3 … ) of the level | String |

2. Project Status Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School Name | Name of the School mapped to the entity | String | | 8 | School ID | Unique identifier of the School mapped to the entity | String | | 9 | Organisation Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Project ID | Unique identifier of the Project created or mapped | String | | 13 | Project Title | Name of the Project created or mapped | String | | 14 | Project Objective | Project Description | String | | 15 | Category | Project Area of Improvement | String | | 16 | Project Duration | Duration of the project taken to complete | String | | 17 | Tasks | Name of the Task attached to Project | String | | 18 | Sub-Tasks | Name of Sub task attached to the task | String | | 19 | Evidence | Url of the attached evidence to the project | String | | 20 | Remarks | Comments for each question at the observation level | String |

3. Observation Status Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School Name | Name of the School mapped to the entity | String | | 8 | School ID | Unique identifier of the School mapped to the entity | String | | 9 | Organisation Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | observation\_submission\_id | Unique identifier generated by system for each submission | String | | 15 | Status of submission | Status of the observation submitted | String | | 16 | Submission date | Date of Submission | Date |

4. Observation Question Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School Name | Name of the School mapped to the entity | String | | 8 | School ID | Unique identifier of the School mapped to the entity | String | | 9 | Organisation Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | observation\_submission\_id | Unique identifier generated by system for each submission | String | | 15 | Question\_external\_id | Unique identifier of the question | String | | 16 | Question | Name of the question | String | | 17 | Question\_response\_label | Label of Question response | String | | 18 | Question score | Score of a particular question | String | | 19 | Evidences | Url of the attached evidence to the project | String | | 20 | Remarks | Comments for each question at the observation level | String |

5. Observation Status with rubric Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School Name | Name of the School mapped to the entity | String | | 8 | School ID | Unique identifier of the School mapped to the entity | String | | 9 | Org Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | observation\_submission\_id | Unique identifier generated by system for each submission | String | | 15 | Status of submission | Status of the submission | String | | 16 | Submission date | Date of submission | Date | | 17 | ECM marked NA | Evidence Collection Method which is marked Not Applicable | String |

6. Observation Question with rubric Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School Name | Name of the School mapped to the entity | String | | 8 | School Id | Unique identifier of the School mapped to the entity | String | | 9 | Org Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | Question\_external\_id | Unique identifier of the question | String | | 15 | Question | Name of the question | String | | 16 | Question\_response\_label | Label of Question response | String | | 17 | Question score | Score of a particular question | String | | 18 | Evidences | Url of the attached evidence to the project | String | | 19 | Remarks | Comments for each question at the observation level | String | | 20 | submission ID | Unique Submission Id generated while submitting | String |

7. Domain criteria Report :

\| 1 | **Column Name** | **Description** | **Datatype** | | 2 | UUID | Unique user-id who submitted the observation | String | | 3 | Role | Role declared by user | String | | 4 | Declared State | Name of the State mapped to the entity | String | | 5 | District | Name of the District mapped to the entity | String | | 6 | Block | Name of the Block mapped to the entity | String | | 7 | School ID | Name of the School mapped to the entity | String | | 8 | School Name | Unique identifier of the School mapped to the entity | String | | 9 | Org Name | Organisation name to which the user belongs to | String | | 10 | Program Name | Name of the program to which the observation is submitted | String | | 11 | Program ID | Unique identifier generated by the system for the program submitted | String | | 12 | Observation Name | Defines the name of Observation | String | | 13 | Observation ID | Unique identifier of Observation | String | | 14 | Domain Name | Name of the Theme | String | | 15 | Domain Level | Level (L1, L2 , L3 … ) of the Themes | String | | 16 | Criteria Name | Name of the criteria | String | | 17 | Criteria Level | Level (L1, L2 , L3 … ) of the Criteria | String |

***

\[\[category.storage-team]] \[\[category.confluence]]
