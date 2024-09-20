# Download-manager-implementation-design

This document explains the download manager implementation inside OpenRAP container and the  interaction with the plugins and plugin states for a content download with different stages in detail. While downloading a file(content) and the different possible scenarios which occurs and how to handle them to restart or resume from the state where we left before the interruption.

**Download Manager**

```js
/*
* Below are the status for the download manager with different status
*/
enum STATUS {
    Submitted = "SUBMITTED",
    InProgress = "INPROGRESS",
    Completed = "COMPLETED",
    EventEmitted = "EVENTEMITTED"
}


/* Method to get the instance of the download manager */
getInstance = function(String pluginId) : DownloadManager {// create new instance of the download manager against plugin and return it.};
 
/*
 This method will ensure that when the service is started/restarted updates the queue using data from download_queue database
 */
reconciliation = function() {

// Get the data from database where downloads which are not emitted the event
// Filter the documents
// Emit the events for download files which are not emitted the events

// Add the downloads to queue if the files are having status Submitted, In-Progress
};

/*
 * Method to watch for the download queue whether it is running or not
 */
downloadQueueWatcher = function() {

// create a time interval which will check the health the download queue this should not fail

};


/*
 * Method to queue the download of a file
 * @param file - The file to download
 * @param path - Path to download the file
 * @return downloadId - The download id reference
 */
download = function(String file, String path) : String {// insert the download request with data to database// push the download request to queue // return the downloadId back};
 
/*
 * Method to queue the download of a file
 * @param file - The file to download
 * @param path - Path to download the file
 * @return downloadId - The download id reference
 */
download = function(String[] files, String folder) : String {
// insert the download request with data to database

// push the download request to queue 

// return the downloadId back
};
 
/*
 * Method to get the status of the download
 * @param downloadId String
 * @return Download object
 */
get = function(String downloadId) : DownloadObject {
// Read status of the request with downloadId and return downloadObject

};
 
/*
 * Method to pause the download
 * @param downloadId String
 */
pause = function(String downloadId) : Promise {
// call pause method with downloadId in the queue 

};
 
/*
 * Method to cancel the download
 * @param downloadId String
 */
cancel = function(String downloadId) : Promise {
// remove the download row from database
// remove the download request from queue using downloadId

};
 
/*
 * Method to pause all the downloads for the given plugin
 * @param downloadId String
 */
pauseAll = function() : Promise {
// call pauseAll method on the queue and return the promise
};
 
/*
 * Method to cancel all the downloads for the given plugin
 * @param downloadId String
 */
cancelAll = function() : Promise {// get all the downloadIds which are not completed// call killDownload with all the downloadIds on the queue and return the promise
};
 
/*
 * Method to list the download queue based on the status
 * @param status String - The status of the download - Submitted, Complete, InProgress, Failed. Blank option will return all status
 * @return Array - Array of download objects
 */
list = function(String status): DownloadObject[] {
// get the list of items from database if status is provided otherwise get all the status

};
 
// sample download object 

 {
    id: String, // Download id
    status: String, // Submitted, InProgress, Complete, Failed.
    createdOn: Date,
    updatedOn: Date,
    stats: {
        totalFiles: Number, // Total files to download
        downloadedFiles: Number, // Total files downloaded so far
        totalSize: Number, // Total number of bytes to download
        downloadedSize: Number, // Total number of bytes downloaded so far
    },
    files: [{ // Status of each file within the given download
        file: String, // File that is downloaded
        source: String, // source from where it is downloaded
        path: String, // Relative path where the file is downloaded to
        size: Integer, // Total file size in bytes
        downloaded: Integer // Downloaded until now
    }]
}


```

**Plugin**

```js
{


/*Below are different content status in plugin
*/
enum CONTENT_DOWNLOAD_STATUS {
    Submitted = "SUBMITTED",
	Extracted = "EXTRACTED",
	Indexed = "INDEXED"
}
init() {
// register with SDK and get Managers instance
// reconciliation() 

}/*
This method will ensure that when the service is started/restarted process the content based on the content status

Eg: if the content is extracted state then it will index the content
*/
reconciliation = function() {
// Get the Submitted content status and if completed then state with extraction
// Get the contents with Extracted state and index them database

};

// listen to the events for content complete

EventManager.on("sunbirded:download:complete", () => {// extract the content
// index the content
})
}
```

***

\[\[category.storage-team]] \[\[category.confluence]]
