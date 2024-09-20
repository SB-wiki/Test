# How-to-configure-resource-bundles-in-portal

This document describes how to create, update and use the resource bundles in sunbird portal, follow the step by step guide to use resource bundles feature provided in sunbird portal&#x20;

**Step-by-step guide**

#### 1. Prerequisites

**Node**  - install the latest release of 8.11.2 LTS series

**Gulp -** install gulp using **npm install gulp -g**

#### 2. Set Up the Portal in local machine:

1. To set up the Sunbird application  **release 1.8**  , get the [code](https://github.com/project-sunbird/sunbird-portal.git) from the sunbird-portal Git repository.
2. Clone the repository to your local system using the command:

\*\*             git clone https://github.com/project-sunbird/sunbird-portal.git\*\*

\*\*             Note\*\* : Stable versions of the sunbird portal code are available via tags for each release. The master branch contains the latest stable release. To get the latest stable release of                                        Sunbird, [click here](https://github.com/project-sunbird/sunbird-portal/).

&#x20;    3\.  After executing the  **git clone**  command, run the following set of commands in the console:

```
 $ cd {PROJECT-FOLDER}/src/app
 $ npm install
```

&#x20; &#x20;

**3. Creating or Updating Resource bundles:**     go to following location in project  by running below command

```


                $ cd resourcebundles/data
```

&#x20;   here you can see two folders with names  \*\*formElements, messages \*\* each folder contains **.properties** files in different languages for example for \*\*English language \*\* it will be en.properties file

\*\*   Creating new resource bundle\*\*

&#x20;    to create new resource bundles in  **Telugu**  language, create a file with name \*\*te.properties \*\* and copy data from **en.properties** file to it.

&#x20;    and update the resource bundle values like below&#x20;

&#x20;  &#x20;

&#x20;          **en.properties** contains add=ADD and open **te.properties** file which is created earlier and

&#x20;          updated add=జోడించడానికి

\*\*  Updating existing resource bundle\*\*

&#x20;   to update existing resource bundles open that resource bundles and change the values as per your need

after creating or updating resource bundles run the following command from {PROJECT-FOLDER}/src/app location

&#x20;      $ gulp build-resource-bundles

it will generate the corresponding json files for each language  in  **{PROJECT-FOLDER}/src/app/resourcebundles/jsonHow to set a specific language as portal default language**

for example if we want to set telugu as portal default language we need to update&#x20;

\*\*sunbird\_portal\_default\_language \*\* environment variable to \*\*te \*\* and restart the service to see the changes

***

\[\[category.storage-team]] \[\[category.confluence]]
