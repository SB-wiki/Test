
## About:
We need to migrate and update the data for Lern BB to support different CSPs.


## Data that need to be Migrated:

1. Certificate template url needs to be updated in course_batch table 


    1.  Certificate template url  of course batch table will be migrated using spark-scala scripts


    1. steps:


    1. Get the latest cloud service provider hostname into input value.


    1. load the course_batch table data with necessary columns into spark dataframe


    1. structure of cert_templatescolumn is


```
{
   "do_2135960950322708481217":{
      "criteria":"{\"enrollment\":{\"status\":2}}",
      "identifier":"do_2135960950322708481217",
      "issuer":"{\"name\":\"DIKSHA\",\"url\":\"https://diksha.gov.in\"}",
      "name":"Independence certificate",
      "previewUrl":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2135960950322708481217/artifact/do_2135960950322708481217_1659679570014_certificate_2022-08-05_11_36.svg",
      "signatoryList":"[{\"name\":\"QA\",\"image\":\"data:image/png;base64,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\",\"designation\":\"CEO\",\"id\":\"CEO/CEO\"}]",
      "url":"https://preprodall.blob.core.windows.net/ntp-content-preprod/content/do_2135960950322708481217/artifact/do_2135960950322708481217_1659679570014_certificate_2022-08-05_11_36.svg"
   }
}
```

    1.  iterate the cert_templatescolumn data and get values of “url" , “previewUrl" and update to new value with new hostname.


    1. Update the cert_templates column



    

    
    1.  ES data will be updated using ingest pipeline

      Steps mentioned here :  [[CSP Changes for Course Batch and RC|CSP-Changes-for-Course-Batch-ES-and-RC-ES]]



    
1. Certificate template url needs to be updated in Certificate Obj in RC registry


    1.  Certificate template url  of Certificate table will be migrated using spark-scala scripts


    1. steps:


    1. Get the latest cloud service provider hostname into input value.


    1. load the TrainingCertificate table data with necessary columns into spark dataframe


    1. structure of templateUrl is


```
"templateUrl": "https://ntpproductionall.blob.core.windows.net/ntp-content-production/content/do_3135540347292221441497/artifact/do_3135540347292221441497_1654545255646_certificate_2022-06-07_01_24.svg"
```

    1. structure of _ossigneddata is 


```
{"@context":["https://ntpproductionall.blob.core.windows.net/ntp-content-production/schema/v1_context.json","https://ntpproductionall.blob.core.windows.net/ntp-content-production/schema/sunbird_context.json"],"type":["VerifiableCredential"],"id":"did:sunbird:","issuanceDate":"2022-09-01T18:23:30.171Z","credentialSubject":{"type":"CERTIFICATE OF COMPLETION","recipientName":"<E0><B2><AE><E0><B3><87><E0><B2><B0><E0><B2><BF> <E0><B2><B0><E0><B3><8B><E0><B2><9C><E0><B3><8D> <E0><B2><9C><E0><B2><BF>","trainingName":"KA_NEP_GC_131_<E0><B2><95><E0><B2><B2><E0><B2><BF><E0><B2><95><E0><B2><BE> <E0><B2><AB><E0><B2><B2><E0><B2><97><E0><B2><B3><E0><B3><81> <E0><B2><B9><E0><B2><BE><E0><B2><97><E0><B3><82> <E0><B2><A4><E0><B2><B0><E0><B2><97><E0><B2><A4><E0><B2><BF> <E0><B2><AA><E0><B3><8D><E0><B2><B0><E0><B2><95><E0><B3><8D><E0><B2><B0><E0><B2><BF><E0><B2><AF><E0><B3><86> <E0><B2><AA><E0><B3><82><E0><B2><B0><E0>
<B3><8D><E0><B2><B5> <E0><B2><AA><E0><B3><8D><E0><B2><B0><E0><B2><BE><E0><B2><A5><E0><B2><AE><E0><B2><BF><E0><B2><95> 1 <E0><B2><AE><E0><B2><A4><E0><B3><8D><E0><B2><A4><E0><B3><81> 2<E0><B2><A8><E0><B3>
<87> <E0><B2><A4><E0><B2><B0><E0><B2><97><E0><B2><A4><E0><B2><BF> <E0><B2><B5><E0><B2><BF><E0><B2><B7><E0><B2><AF> <E0><B2><95><E0><B2><A8><E0><B3><8D><E0><B2><A8><E0><B2><A1> ","trainingId":"do_3135509218938961921559"},"issuer":{"id":"https://raw.githubusercontent.com/project-sunbird/sunbird-devops/release-4.8.0/kubernetes/helm_charts/sunbird-RC/registry/templates/READ.md#Issuer","type":["Issuer"],"name":"ka","url":"https://diksha.gov.in/ka/","publicKey":["b8ae162e-4df5-40d3-938e-42eb1cb8f0ef"]},"proof":{"type":"RsaSignature2018","created":"2022-09-01T18:23:30Z","verificationMethod":"did:india","proofPurpose":"assertionMethod","jws":"eyJhbGciOiJQUzI1NiIsImI2NCI6ZmFsc2UsImNyaXQiOlsiYjY0Il19..paG-a2XwYswIWs5-OWNhtiFzfQi9mW0E5aQ5YeIcP57X2xnsdnqCzPd2vY5r5TVZ5CMk166z74yAmfcTcc1F9S4L9xdQms4wHjQUtOzcAKrAcjXiu-n6LeZAbz1vpaO20crmw4RzEJWKEZwKC0zbyiTrr2lJI-ggLsExlFcUDGLi-HhR45Xhdf0q12Gd6mkPuVAblgkqMu5MMXdbfKZM3wCSHmDTpyJnc-a5IDU_ZzNn3CORvbIB5HoleT8EJ4suIqicTdBxUUrkoGOcgn7cXCfQLfPP0-YrQtztWzMUpD-RFpKqFXDTa5pLbyH5To1dD-Z4cAISEXLGEtJ1-9lfLw"}}
```

    1. Update all records  templateUrl, _ossigneddata columns.



    

    
    1.   ES data will be updated using ingest pipeline

      Steps mentioned here :  [[CSP Changes for Course Batch and RC|CSP-Changes-for-Course-Batch-ES-and-RC-ES]]



    
1. Existing reports need to be migrated 

          => Copy all the reports from one CSP to another in same folder structure


1. Credential template, context files to be stored in to new CSP 

         => Copy all the templates from one CSP to another in same folder structure


1. Old Certificates in Azure needs to be migrated

         => Copy all the certificates from one CSP to another in same folder structure


1. Exisisting Certificate templates needs to be migrated.

         => Copy all the templates from one CSP to another in same folder structure


1. Postgres job_request table data updating


    1. Update the blob URLs base path of the report files using spark-scala script


    1. Get the latest cloud service hostname to access blob file through storage container


    1. load the job_request table data with necessary columns into spark dataframe


    1. Iterate through download_urls and processed_batches and update the hostname as per input for latest CSP.


    * table details


    * DB name: analytics


    * Table name: {{env}}_job_request



    
    * Sample Record from Job_request table



    

    

    


```
                                tag                                 |            request_id            |      job_id      |   status   |           request_data            |             requested_by             |  requested_channel   |    dt_job_submitted     |                                                                       download_urls                                                                       | dt_file_created |    dt_job_completed     | execution_time | err_message | iteration | encryption_key | batch_number |                                                                                                                   processed_batches                                                                                                                   
--------------------------------------------------------------------+----------------------------------+------------------+------------+-----------------------------------+--------------------------------------+----------------------+-------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------+-----------------+-------------------------+----------------+-------------+-----------+----------------+--------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 do_2134278323636633601111_0134278409923379202:01269878797503692810 | 7B7463609693ABBB33F48AA6EF813BDE | userinfo-exhaust | SUCCESS    | {"batchId":"0134278409923379202"} | fca2925f-1eee-4654-9177-fece3fd6afc9 | 01269878797503692810 | 2021-12-10 12:46:23.814 | {https://sunbirdstagingprivate.blob.core.windows.net/reports/userinfo-exhaust/7B7463609693ABBB33F48AA6EF813BDE/0134278409923379202_userinfo_20211210.zip} |                 | 2021-12-10 12:57:04.072 |           9614 |             |         0 | Test12         |              | [{"channel":"01269878797503692810","batchId":"0134278409923379202","filePath":"wasb://reports@sunbirdstagingprivate.blob.core.windows.net/userinfo-exhaust/7B7463609693ABBB33F48AA6EF813BDE/0134278409923379202_userinfo_20211210.csv","fileSize":0}]

```


The scala scripts for tables migration is mentioned here: [[CSP changes in Lern related tables:|CSP-changes-tables-and-ES-in-Lern]]







*****

[[category.storage-team]] 
[[category.confluence]] 
