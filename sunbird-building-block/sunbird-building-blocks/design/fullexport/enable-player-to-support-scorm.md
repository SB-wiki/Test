# Enable-player-to-support-scorm

## How does SCORM Work

SCORM is a specification that defines

1. How distributable learning content should be packaged
2. How the content can be embedded in a LMS
3. How does the embedded content communicate with the LMS
4. The standards / specifications of this communication

### SCO

A SCO is the actual content package contained within a SCORM file. Most content authoring tools produce SCORM files with a single SCO, and most LMS also only support single SCO SCORM files. However the specification allows creating SCORM files with multiple SCOs. ( _imsmanifest_ .xml – **it details the contents of the scorm zip package** )

## SCORM <> LMS Communication

A SCORM compliant LMS is required to implement the API (Application Program Interface), which consists of 8 functions given as API signatures.

[https://scorm.com/scorm-explained/technical-scorm/run-time/run-time-reference/#section-5](https://scorm.com/scorm-explained/technical-scorm/run-time/run-time-reference/#section-5) - And read about API signature

The below diagram shows how a SCORM content embedded in the LMS, communicates with the LMS.

![](<../../../../Design/FullExport/images/storage/SCORM Implementation.jpg>)

## What data can SCORM send (Data model)

1. Data model defines a set of variables that can be read and set by LMSGetValue() and LMSSetValue() respectively, what each of the various variables mean, and how they should be managed by the LMS. It also defines whether the data model elements are optional or mandatory for the LMS, format of the data stored in each variable, and whether elements are read-only, write-only, or read-write.&#x20;
2. And read about data model.

[https://scorm.com/scorm-explained/technical-scorm/run-time/run-time-reference/#section-5](https://scorm.com/scorm-explained/technical-scorm/run-time/run-time-reference/#section-5) -

## Current SCORM support in sunbird CB

1. The SCORM adapter is currently available in the Sunbird CB repository - [https://github.com/sunbird-cb/sunbird-cb-portal/tree/cbrelease-4.8.0/project/ws/viewer/src/lib/plugins/html/SCORMAdapter](https://github.com/sunbird-cb/sunbird-cb-portal/tree/cbrelease-4.8.0/project/ws/viewer/src/lib/plugins/html/SCORMAdapter)
2. The adapter is a wrapper on top of the HTML5 player
3. The adapter currently expects a Index\_lms.html file to be present in the root of the folder, and plays it
4. The adapter intercepts the LMS\_\* events from the SCORM and maps it to the content state update API calls
5. A new progressDetails attribute has been added to the content progress cassandra table to allow storing progress/bookmarking data sent by the SCORM

## Implement SCORM supoport in sunbird ED

Port the current implementation from Sunbird CB to Sunbird ED. This will allow Sunbird to play and track SCORM files and their completion.

### SCORM file upload -

1. Create content API (api/v1/create/content or update) along with content metadata should store following values against the content

```
'scormValues': {
'entry': <First SCO to be launched>,
'version': <scorm2004/SCORM_1.2- to decide which API to be used> 
'grademethod': <Grading method to give score to the user in case of multiple attempts>
}
```

1. Tables to be populated after reading imsmanifest.xml file.

```
onScormPackageUpload(zipPath) {
    if (!file_exists(zipPath . '/imsmanifest.xml')) {
        throw_error('uploaded zip is not a scorm file')
    } else {
        readIMSManifestFile(zipPath . '/imsmanifest.xml')
    }
}

function readIMSManifestFile($manifestfile) {
    1. Load and read the imsmanifest.xml file
    2. Things needed to be stored against the content
       a. scorm version -> Read the manifest->metadata->shemaversion
       b. The first sco to be set as 'entry' against the content 
    3. Poulate the #__scorm_scoes table and #__scorm_scoes_data after reading all the items and resources
}
```

#### Table #\_\_scorm\_scoes

\| id | bigint(10) | AUTO\_INCREMENT | | content\_id | bigint(10) | | | title | varchar(255) | | | scormtype | varchar(5) | | | manifest | varchar(255) | | | organization | varchar(255) | | | parent | varchar(255) | | | identifier | varchar(255) | | | launch | longtext | |

#### Table #\_\_ **scorm\_scoes\_data**

\| id | bigint(10) | AUTO\_INCREMENT | | sco\_id | bigint(10) | | | name | varchar(255) | | | value | longtext | |

### SCORM consumption through player

Tracking user

Here for the first step we will store all the data provided by scorm in the database and use it for tracking completion and passing status of a student (populate scorm tracking tables given in [here](https://docs.google.com/spreadsheets/d/1krwjn8t7H5Y80EtHsCKrUBALk5qw5jjH28atG3QjXPk/edit#gid=0))

#### Generating telemetry

[https://docs.google.com/spreadsheets/d/1krwjn8t7H5Y80EtHsCKrUBALk5qw5jjH28atG3QjXPk/edit#gid=1594049563](https://docs.google.com/spreadsheets/d/1krwjn8t7H5Y80EtHsCKrUBALk5qw5jjH28atG3QjXPk/edit#gid=1594049563)

###

Do we want to support Attempts? SCORM is designed to allow a student to exit and return at a later date to the same point they left from. This means that each time they enter the SCORM they are using the same single attempt. Some SCORM packages are intelligent about handling re-entry, many are not. What this means is that if the student re-enters an existing attempt, if the SCORM content does not have internal logic to avoid overwriting cmi.core.lesson\_status and cmi.core.score.raw, they can be overwritten by a lower score, confusing the learner.

When a SCORM sets the cmi.core.lesson\_status value to 'completed', 'passed' or 'failed' then we can allow the user to create a new attempt by adding a **Start new attempt** checkbox to the entry page. If cmi.core.lesson\_status is set to 'incomplete', 'browsed' or 'notattempted' the student can only re-enter the existing attempt.

With this we can provide settings to allow this to be controlled, some of these settings can be hidden by default as advanced options.

* Number of attempts

This allows the teacher to set how many SCORM attempts the student may create - this is not how many times a student can re-enter a SCORM attempt.

* Attempts grading

This allows the teacher to set how multiple SCORM attempts(not re-entries) are graded. It is important to note that a 'failed' cmi.core\_lesson\_status allows a new attempt to be generated but the attempts grading setting "last completed attempt" only includes 'completed' and 'passed' values in it's calculations.

* Display attempt status

This displays a users SCORM attempts and how their final grade is calculated on the SCO

* Force completed

This is a setting that can be used to force a SCORM package to report a 'completed' cmi.core.lesson\_status if it doesn't currently set the value.

* Force new attempt

This hides the **Start new attempt** checkbox and will force a new attempt if the previous attempt has cmi.core.lesson\_status value to 'completed', 'passed' or 'failed'

[http://www.vsscorm.net/2010/01/20/a-simple-scorm-1-2-content-package/](http://www.vsscorm.net/2010/01/20/a-simple-scorm-1-2-content-package/)

***

\[\[category.storage-team]] \[\[category.confluence]]
