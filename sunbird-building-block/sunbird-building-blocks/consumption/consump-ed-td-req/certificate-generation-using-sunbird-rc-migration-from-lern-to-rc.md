Existing System:

From Platform stand point, all the certificates generated attributing to trackable collection was driven by Sunbird Lern. Currently there are two kinds of certificate generation capability:

a) PDF format

b) SVG format



Proposed System:

Intent of this activity is to change the certificate generated attributing to trackable collection from Sunbird Lern to Sunbird RC. 



”Sunbird RC provides microservices to issue portable standard schema based W3C VC complaint credentials with attestation and verification flows. These credentials are instantly verifiable, can be in multiple languages, are usable offline, and printable with QR codes”



The transition to RC will happen in phases. SB will need to support both old certificates (generated via existing cert service) as well as the new certificates (generated via SB RC) until this is completed.

In order to do this, verification workflows for both the old Certificates as well as for the new certificates needs to be supported.


1. Old certificates : (current verification workflow to be retained))On scanning the QR code for verification, user is taken to a page where s/he enters the 6 digit code and then the certificate details are displayed for verification.


1. New Certificates : code entry for validation is not required. The front end (app/ portal) will cache the public key used by Diksha, and the certificate can be verified on the app using the public key. There are no server pages required. QR code will have a json with w3c verifiable credentials, the public key can be used to decrypt the jws to verify the certificate.







*****

[[category.storage-team]] 
[[category.confluence]] 
