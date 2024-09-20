# Update-ToC-in-Collection-editor-attributes-by-excel-upload

BackgroundThe textbook creator should be able to update the existing Text book unit attributes in the TOC by uploading the excel (CSV) file.

Key design problemsOn click of \*\*' Update TOC' \*\* button user will be uploading the CSV file with updated Text book unit attributes.

Solution 1:'Update Toc' button is updated in the 'sunbirdcommonheader' plugin, on click of the button, we are dispatching an event 'org.ekstep.uploadfile:show'&#x20;

The plugin to upload the CSV file(should be configurable) will listen to the event org.ekstep.uploadfile:show

The configurations for the plugin will be the title, description, file formats .

To provide the upload file with drag and drop feature, the library fineuploader used in the `org.ekstep.uploadcontent` plugin will be utilized, the suggested name of the plugin is `org.ekstep.uploadfile-1.0`&#x20;

The CSV file should have the updated attributes like Name, Description, topics, keywords, DIAL code

Validate if the CSV file is uploaded else throw an error saying, uploaded\_file\_name has a invalid extension, Please enter a .CSV file.

the request of the api will be  request { data : \[file] }

and notify the user if there are any errors from the error response and update the Text book unit attributes on success of api response

On success of the response, read the getHeirarchy?mode=edit to get the updated attribute values of the textbook unit and assign it to data.&#x20;

Now dispatch the event `org.ekstep.collectioneditor:content:update`, with data from the getHierarchy result, the org.ekstep.contentMeta plugin will listen to the event and update the attributes of TOC

**Pros:**

Plugin can be reused for any file upload.

**Cons**

Basic validations like empty record check is known after the api call.

Solution 2:After upload of CSV using the 'org.ekstep.uploadfile' plugin, the request to send the CSV file will be { data : \[file] }.

The settings of fineuploader plugin provides the option,&#x20;

request: { endpoint: '/server/uploads' }The file is uploaded to the server, from server the file is been read for processing the file.On success of the response, read the getHeirarchy?mode=edit to get the updated attribute values of the textbook unit and assign it to data.&#x20;

Now dispatch the event `org.ekstep.collectioneditor:content:update`, with data from the getHierarchy result, the org.ekstep.contentMeta plugin will listen to the event and update the attributes of TOC

&#x20;

**Pros:**

**Cons**

Basic validations like empty record check is known after the api call.

***

\[\[category.storage-team]] \[\[category.confluence]]
