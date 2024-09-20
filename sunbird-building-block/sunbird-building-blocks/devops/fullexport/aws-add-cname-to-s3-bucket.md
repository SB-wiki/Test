Adding custom domain to s3 bucket involves below steps


1.  Grant public read access to S3 bucket


1. Create ssl certs for the custom domain using ACM


1. Create CDN and map dns endpoint to custom domain




## Grant public read access to S3 Bucket

* Log in to AWS COnsole and open your S3 Management Console


* choose the bucket name from the  **S3 buckets**  list.


* The  **Access**  column beside the Bucket name tells you the access status of your buckets. The default value is ‘Buckets and objects not public


* head over to the  **Permissions**  tab and edit the  **On**  mode of the ‘Block all public access’ option. Uncheck that box and save your changes


* In the permission tab, move to the Bucket Policy section. There is a  **Bucket Policy Editor** area, enter the code shown below and configure the bucket access permission.




```
{"Version": "2008-10-17",
"Statement": [{"Sid": "AllowPublicRead",
"Effect": "Allow",
"Principal": {
"AWS": "*"
},
"Action": "s3:GetObject",
"Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
}]}
```
Replace ‘YOUR-BUCKET-NAME’ in the code with your real bucket name.




## Create ssl certs for the custom domain using ACM

* Sign in to the AWS Certificate Manager console


* Choose  **Request a certificate** .


* Enter a custom domain name for your API, for example, api.example.com, in  **Domain name** .


* Choose Review and request


* Choose Confirm and request


* Update cname record for the domian






## Create CDN and map dns endpoint to custom domain

* Sign in to the AWS Management Console and open the CloudFront console


* Choose  **Create Distribution** .


* On the first page of the  **Create Distribution Wizard** , in the  **Web**  section, choose  **Get Started** .


* Specify settings for the distribution as shown below. For more information, see [Values that you specify when you create or update a distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/distribution-web-values-specify.html).


* Origin domain - The DNS domain name of the Amazon S3 bucket


* Name - unique name for the distribution


* In the settings, select add item in Alternate domain name (CNAME) and enter your cutom domain url


* In Custom SSL certificate, select the ssl cert created in the previous step, from the dropdown list.


* Click on Create distribution


* After CloudFront creates your distribution, the value of the  **Status**  column for your distribution will change from  **InProgress**  to  **Deployed** . 


* When your distribution is deployed, confirm that you can access your content using your new CloudFront URL or CNAME.





*****

[[category.storage-team]] 
[[category.confluence]] 
