# Sunbird-CSP-Addition-of-new-Service-File-for-S3-storage

## Introduction:

The Manage Learn Service interacts with various components of the client-cloud-service npm package for diverse cloud interactions in the application. There is a need to specify that the Manage Learn Service will be deployed in the NIC cloud, utilizing NIC cloud storage for evidence uploads. The use case for Manage Learn involves users uploading their evidence, such as files, photos, videos, and PDFs, to the cloud as part of their submissions.

However, a limitation arises as the current client-cloud-service only supports AWS, OCI, AZURE, and GCP. The challenge with NIC storage is that it is implemented using the S3 protocol, but there is no requirement for a specific region since it is hosted in India. Additionally, NIC storage does not work with pre-signed URLs; hence, the evidence needs to be uploaded directly to the cloud.

To address this, we propose introducing an additional service file for S3 with cloud storage, specifically designed for NIC's private cloud, following the S3 protocol. Within this service file, we will introduce an upload function to handle file uploads. This addition is necessary because in NIC, there is no concept of signed URLs, and direct cloud upload is the preferred method.

Implementing two methods in the S3 storage service file in an upload function that returns the upload status, and a downloadable URL function that retrieves the URL post-upload. Exclusively utilizing the aws-sdk library for cloud interaction in this file.

## Objective:

The primary objective of this proposal is to extend the functionality of the Manage Learn Service by addressing compatibility issues with NIC cloud storage. Currently, the service interacts seamlessly with various cloud platforms, including AWS, OCI, AZURE, and GCP, but encounters limitations when dealing with NIC storage due to its unique implementation using the S3 protocol.

## Proposed Changes:

### Introduction of S3 Storage Service:

We are introducing an additional service file designed to operate with S3 protocol-based cloud storage, eliminating the need for a specific region. While primarily intended for compatibility with NIC cloud storage, it is worth noting that this service file can also function with AWS S3, although it is not the recommended use case.

![Screenshot 2024-02-16 at 5.38.54 AM.png](<../../../../Design/FullExport/images/storage/Screenshot 2024-02-16 at 5.38.54 AM.png>)

### Custom Configuration Parameters:

The S3StorageService file requires the following parameters: access key, secret key, endpoint, and bucket name. Notably, specifying a region is unnecessary, as the service will be exclusively hosted in India.

### Library Compatibility:

A Proof of Concept (POC) has been conducted utilizing the aws-sdk library to ensure smooth integration with the NIC server's storage service. The implementation will focus on two main functions: upload and generating downloadable URLs.

## Implementation Steps:

### Code Modification:

In the code modification, a new service file, S3StorageService, will be added to implement the upload and downloadableUrl functions. The index.js file will be updated to incorporate the new service file and export functions from S3StorageService.

Will Implement two methods in this S3 storage service file

1. **Upload function:-**

The function, accepting file data, bucket name, and file name as inputs, will return a status indicating whether the file was successfully uploaded to the specified bucket.

1.  **Downloadable Url function:-**

    Following the file upload, invoking this function is possible to obtain the downloadable URL. The function, requiring the bucket name and file name as parameters, facilitates the retrieval of the corresponding URL

For this s3 storage service file and cloud interaction will use only **aws-sdk** library.

### Documentation Update:

Revise documentation to include details about the new S3 Storage Service, its configuration parameters, and integration steps. Clearly outline the handling of NIC S3 buckets without region-specific configurations.

## Benefits:

### Expanded Compatibility:

The addition of the S3 Storage Service broadens the compatibility of our client-cloud-service package, catering to clients with diverse storage solutions.

### Seamless Integration:

Clients can easily adopt our services for NIC server storage without significant modifications, thanks to the generic nature of the client-cloud-service package.

### Enhanced Service Adoption:

The proposed changes enable us to meet the evolving needs of clients, fostering greater adoption of our services.

***

\[\[category.storage-team]] \[\[category.confluence]]
