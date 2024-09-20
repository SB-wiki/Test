From pom files we can find unused depdendencies in pom by using maven.

Maven command used:

mvn dependency: analyze

Steps to follow:


1. Open any pom file with has dependencies mentioned.


1. Run the maven command where the pom reside


    1. mvn dependency: analyze



    
1. Following will be output



output\[WARNING] Used undeclared dependencies found:

\[WARNING]    org.sunbird:sunbird-cassandra-utils:jar:1.0-SNAPSHOT:compile

\[WARNING]    org.sunbird:sunbird-commons:jar:1.0-SNAPSHOT:compile

\[WARNING] Unused declared dependencies found:

\[WARNING]    junit:junit:jar:4.12:test

\[WARNING]    org.powermock:powermock-module-junit4:jar:1.6.5:test

\[WARNING]    org.powermock:powermock-api-mockito:jar:1.6.5:test

4. It will suggest the unused declared and used undeclared dependencies the pom file

5. Removing all unused dependencies will also leads to run-time issues.

6. By proper removing the unused dependencies, build should pass with test-cases and should run with all api’s.

 **Applied on Learner-Service:** 

We have applied this on following services sunbird-lms-mw and sunbird-lms-service. Build generated properly, deployed and tested with few api’s.

Tested org search api’s, user creation api’s(v2/v3).

Points to remember:


1. Don’t delete our project modules which is mentioned as dependencies in other projects


1. Don’t delete dependencies which helps in running the application.


    1. Following is the output when run on the 'sunbird-lms-service'


    1. When the dependency is removed, play server itself didn’t started.



    

lms-service sample output\[WARNING] Unused declared dependencies found:

\[WARNING]    com.typesafe.play:play-akka-http-server_2.11:jar:2.7.2:compile







*****

[[category.storage-team]] 
[[category.confluence]] 
