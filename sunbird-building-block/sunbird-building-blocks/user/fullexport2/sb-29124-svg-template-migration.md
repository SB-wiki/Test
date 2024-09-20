
### About
This tool is to migrate all existing sunbird svg template to sunbird-RC svg template format.


## Steps to use tool for migration

1. Download the java executible jar ([migration.jar](https://github.com/project-sunbird/sunbird-utils/blob/release-4.8.0/svg_template_migration/template-migration/migration.jar)) from the [https://github.com/project-sunbird/sunbird-utils/tree/release-4.8.0/svg_template_migration/template-migration](https://github.com/project-sunbird/sunbird-utils/tree/release-4.8.0/svg_template_migration/template-migration)  .






```
wget https://github.com/project-sunbird/sunbird-utils/blob/release-4.8.0/svg_template_migration/template-migration/migration.jar?raw=true
mv migration.jar\?raw\=true migration.jar
```


Note:

Above jar will download and migrate all the svg template as per sunbird-RC format from the given env(domain url) using content search api in specific folder corresponding to svg file , folder name will be the content id (aka doId) at same location where jar is present.



2. Run the below java command for migration & download




```
Command to run the jar:

To migrate template
java -jar migration.jar "domain_url" "offset" "limit"

Example:
java -jar migration.jar "staging.sunbirded.org" "0" "500"

Note:
Run above command multiple times to migrate all the svg template based on the total count.
```



## Steps to use tool for re-uploading template



### Prerequisite:
Copy all the folder which contains the svg files (or downloaded folder from above java command) to a new folder. 

Note : Do not copy any other file or jar in newly created folder(in this case the jar and one config file)




1. Download the java executible jar ([uploader.jar](https://github.com/project-sunbird/sunbird-utils/blob/release-4.8.0/svg_template_migration/template-upload/uploader.jar)) from the [https://github.com/project-sunbird/sunbird-utils/tree/release-4.8.0/svg_template_migration/template-upload](https://github.com/project-sunbird/sunbird-utils/tree/release-4.8.0/svg_template_migration/template-upload)    .






```
wget https://github.com/project-sunbird/sunbird-utils/blob/release-4.8.0/svg_template_migration/template-upload/uploader.jar?raw=true
mv uploader.jar\?raw\=true uploader.jar
```


Note: 

This script will re-upload the migrated svg file to the same location (original svg location).



2. Run the below java command for uploading

Note: Azure Account Name for uploading in prod = ntpproductionall




```
Command to run the jar:

To re-upload the migrated template
`java -jar uploader.jar "domain url" "offset" "limit" "container account" "container key" "location of migrated template"

Example:

java -jar uploader.jar "dev.sunbirded.org" "0" "500" "account_name" "account_key" "new folder location where we copied the downloaded svg folders"


```


*****

[[category.storage-team]] 
[[category.confluence]] 
