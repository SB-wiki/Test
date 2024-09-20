# Dashboard-Table-configuration

### Problem Statement

* The admin dashboard type of reports should be dependent on the tenant.
* In the admin dashboard Table, all fields are in string formate when fetched from the JSON even though their datatype is number or Date. Because of this, the sorting of the table on these fields is not working as expected.
* In the admin dashboard Table, there is a requirement to have filters so that the table data can be filtered depending on the required field value
* In the admin dashboard Table, there should be an option for multiple tabs of the table (These tables are the subset of the master data that we are getting)

### Proposed Solution

&#x20;     1\. The admin dashboard type of reports should be dependent on the tenant

&#x20;     **Solution** &#x20;

&#x20;        For a given tenant's root org the supported report type can be stored in the bucket where the report JSON is stored.

&#x20;     **Pro's**

&#x20;      all the dashboard types are stored as a JSON and if a new type has to be added this will make it easy to add

&#x20;    2\. In the admin dashboard Table, all fields are in string formate when fetched from the JSON even though their datatype is number or Date. Because of this, the sorting of the table on these fields is not working as expected

\*\*     Solution\*\* &#x20;

&#x20;        1\. Each of the fields can have two attributes that specify the datatype and is the field sortable this will be in the JSON so that the update will be easy. whoever is consuming the JSON will write the conversion mechanism from string to the required datatype

&#x20;         **Pro's**

&#x20;            all the field types are stored as a JSON and if a new type has to be added this will make it easy to add and the handling of data becomes easy

&#x20;        2\. Depending on the field name the consumer writes the conversion mechanism of the datatype.

&#x20;          **cons**

&#x20;             As the datatype is dependent on the field name this may not be accurate and also if a new field name is added then the mechanism need to be added to convert the datatype.

&#x20;   3\. In the admin dashboard Table, there is a requirement to have filters so that the table data can be filtered depending on the required field value

\*\*      Solution\*\* &#x20;

&#x20;        1\. JSON can have the visible column list&#x20;

&#x20;         this can be done as shown in the link [https://datatables.net/extensions/fixedcolumns/examples/initialisation/colvis.html](https://datatables.net/extensions/fixedcolumns/examples/initialisation/colvis.html)

&#x20;   4\. In the admin dashboard Table, there should be an option for multiple tabs of the table (These tables are the subset of the master data that we are getting)

\*\*       Solution\*\* &#x20;

&#x20;        1\. JSON should have details of the tabs to be shown and the data regarding the tab&#x20;

&#x20;        &#x20;

***

\[\[category.storage-team]] \[\[category.confluence]]
