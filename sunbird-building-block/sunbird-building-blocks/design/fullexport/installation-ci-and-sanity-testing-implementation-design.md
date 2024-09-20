# Installation-CI-and-Sanity-Testing---Implementation-Design

\| 1.9.0,1.10.0 | | [System JIRA](https://browse/) | | DRAFT | |

\| | Lead designer | | Lead developer |

| Lead tester                    |
| ------------------------------ |
| ---                            |
| ---                            |
| ---                            |
| ---                            |
| ---                            |
| ---                            |
| 1.9.0,1.10.0                   |
| [System JIRA](https://browse/) |
| DRAFT                          |
|                                |

\| | Lead designer | | Lead developer | | Lead tester |

### Goals

To Make sure that an Adaptor is able to install Sunbird Server Installation by following the Documentation and Post Installation the Sunbird works as expected.

* To create a CI which install the Sunbird on the VM's provided.
* Creates the root org, users and runs the sanity to check the installation.
* If all goes well it will pull the logs to a provided repo, Sends a success message and cleans the VM, keeps it ready for next run and shut down the VM.
* If any issue is in any of the steps of Installation or the create Org or Create User or sanity testing it will send a Notification and stops the process and will not clean the VM.

### Background and strategic fit

currently the server installation of the sunbird is not automated and has some error in the documentation to follow the steps.

This CI will help us resolve Issues in the Devops process and also tell us the sanity of the installed Sunbird Instance

### Assumptions

* The VM's are ready and installed with a compatible ubuntu and git

### Requirements

| # | Issue Number                                                    | Story Title                                                                                |
| - | --------------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| 1 | [SB-5377](https://project-sunbird.atlassian.net/browse/SB-5377) | As a CI feature for Sunbird Installation need to create min 2 VM                           |
| 2 | [SB-5539](https://project-sunbird.atlassian.net/browse/SB-5539) | As a process automation of Sunbird Installation the VM instance should be Started          |
| 3 | [SB-5544](https://project-sunbird.atlassian.net/browse/SB-5544) | As a Process CI of Sunbird Installation, Sunbird should be installed in a 2vm              |
| 4 | [SB-5560](https://project-sunbird.atlassian.net/browse/SB-5560) | Create taxonomy in the current sunbird Installation                                        |
| 5 | [SB-5562](https://project-sunbird.atlassian.net/browse/SB-5562) | check for the stability of sunbird Installation by using the automated testing sanity tool |
| 6 | [SB-5564](https://project-sunbird.atlassian.net/browse/SB-5564) | Once the sanity is completed reports has to be generated notification has to be sent       |

### User interaction and design

we are proposing a CI to Install the sunbird form the latest release branch and post-installation create org, Users, and Taxonomy.

then run a sanity test with some of the standard scenarios like

* create content with a content creator login
* publish the content with reviewer login
* use the content in course and consume the same as an end user.

proposing to use the circleCI for the Continues Integration.

The flowchart shows the steps involved in the process of creation of the CI&#x20;

![](<../../../../Design/FullExport/images/storage/Untitled Diagram.jpg>)

### Not Doing

* Automating the VM creation.
* Refactoring the config into multiple files so that the installation process becomes more accurate
* After Each Installation Do a health check of the services Installed
* check the DB installation is done before the DB update is run

***

\[\[category.storage-team]] \[\[category.confluence]]
