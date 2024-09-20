Technical design document for changes related to release-3.8.0.

 **SB-22745 Backend: Store Minor_flag against user's profile** :

Task created for this [https://project-sunbird.atlassian.net/browse/SB-22745](https://project-sunbird.atlassian.net/browse/SB-22745)

We are going to use existing field ‘dob’ for this, it will be in format “yyyy”. This field value is sent in the create api and update api and while reading we get year from this field and calculated the whether the user is minor or not.

If the user is minor we will sent in read api response as “isMinor”: true else “isMinor”:false.

Note: While saving to backend we will saving dob to “yyyy-MM-dd” format, in-order to modify to the mentioned format we are going to add “-12-31” default to all dob values.



[[SC-2190 : Data model changes to organisation schema to store schools as organisations|SC-2190---Data-model-changes-to-organisation-schema-to-store-schools-as-organisations]]



[[SC-2184 : Data model changes to user schema to store location, persona, subpersona in generic way|SC-2184---Data-model-changes-to-user-schema-to-store-location,-persona,-subpersona-in-generic-way]]



*****

[[category.storage-team]] 
[[category.confluence]] 
