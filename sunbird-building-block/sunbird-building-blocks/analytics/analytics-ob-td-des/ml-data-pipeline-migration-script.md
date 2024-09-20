
### Document Release Version


| Project | Release Date | Version | 
|  --- |  --- |  --- | 
| Manage-learn | 23 Dec 22 | V 5.1.0 | 


### Details of Released Tag


| Components | Jenkins Job | Deploy Tags (Devops) | Github Repository | Comments | 
|  --- |  --- |  --- |  --- |  --- | 
| Data-pipeline | managed-learn/ml-analytics-service | release-5.1.0_RC13 | [https://github.com/Sunbird-Ed/ml-analytics-service/tree/release-5.1.0](https://github.com/Sunbird-Ed/ml-analytics-service/tree/release-5.1.0) |  | 



 **Summary of the Changes** 
* Making manage-learn Cloud agnostic



 **Affected Areas** 
* Druid Datasources 

    evidences column of sl-observation

    evidences column of sl-survey


* Program Dashboard Reports 

    ml-obs-question-detail-exhaust

    ml-observation-with-rubric-question-detail-exhaust

    ml-survey-question-detail-exhaust




### Details of  changes:

* [ED-131](https://project-sunbird.atlassian.net/browse/ED-131) Data-pipeline changes

    Note : The logic behind the script is to replace the base path of the evidence url to CNAME or the new cloud provider. please find the sample below

    Present url : https://sunbirdstagingpublic.blob.core.windows.net/samiksha/survey/63a1627ca1d0c60008cf2012/fb5774d5-21d2-448a-b2af-c2c4e2f33c7b/f135ef49-97e2-492b-88dd-a4a5a1787a97/1671520911878.jpg

    Will be modified as : https://obj.dev.sunbird.org/survey/63a1627ca1d0c60008cf2012/fb5774d5-21d2-448a-b2af-c2c4e2f33c7b/f135ef49-97e2-492b-88dd-a4a5a1787a97/1671520911878.jpg




### Env Configurations (Needs to be done before service deployment):
The below environment variable needs to be configured in the [devops repo](https://github.com/project-sunbird/sunbird-devops/blob/release-5.1.0/ansible/roles/ml-analytics-service/defaults/main.yml#L105).



| Variable Name | Values | Comments | 
|  --- |  --- |  --- | 
| ml_analytics_cname_url | [https://sunbirdstagingpublic.blob.core.windows.net/samiksha](https://sunbirdstagingpublic.blob.core.windows.net/samiksha/)/ | To store the CSP base path | 

Note : Please make sure you add '/' at the end of Values

 **Data Migrations : (Run this script after service deployment)** 
* Login to ml-analytics server and switch to data-pipeline user


* Execute this command to update this sl-observation data source

    . /opt/sparkjobs/spark_venv/bin/activate && python /opt/sparkjobs/ml-analytics-service/cloud_storage/py_cloud_migration.py --solution observation 


* Execute this command to update this sl-survey data source

    . /opt/sparkjobs/spark_venv/bin/activate && python /opt/sparkjobs/ml-analytics-service/cloud_storage/py_cloud_migration.py --solution survey





 **Verification Steps after Migration :** 
1. Login to portal with Program Manager role


1. Click on the user and select Program dashboard


1. Pop up menu will be displayed, select the Program , Resource and confirm


1. Select the  report type as Question Report from the drop down and click on request report button


1. Trigger this job in Jenkins Deploy/DataPipeline/AnalyticsReplayJobs/


1. Refresh the HawkEye portal  and select the program and source for which you requested the report, download the CSV


1. In the CSV check the  **Evidences**  column, should have updated Url. Sample  shared below



Present url : https://sunbirdstagingpublic.blob.core.windows.net/samiksha/survey/63a1627ca1d0c60008cf2012/fb5774d5-21d2-448a-b2af-c2c4e2f33c7b/f135ef49-97e2-492b-88dd-a4a5a1787a97/1671520911878.jpg



Modified url : https://obj.dev.sunbird.org/survey/63a1627ca1d0c60008cf2012/fb5774d5-21d2-448a-b2af-c2c4e2f33c7b/f135ef49-97e2-492b-88dd-a4a5a1787a97/1671520911878.jpg





*****

[[category.storage-team]] 
[[category.confluence]] 
