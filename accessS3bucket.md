# Providing Access to a ReadOnly user to S3 bucket

**NOTE:** I'm not proficient at policies. I found this process worked.

Goal is to provide access to an S3 bucket without giving access to any other AWS capabilities. 

## Create Read Only User 
The user should have limited read-only access

For example: ViewOnlyAccess 

## Create Access Key 

From AWS IAM for the Read Only user. Go to Security Credentials and create an Access Key.

This will generate the Access ID and Key.  You can save these as CSV file.

## Create S3 Bucket

- Go To Bucket Permission
- Click Bucket Policy
- Click Policy Generator (at Bottom)

From Policy Generator
- Type: S3 Bucket Policy
- Effect: Allow
- Principal: (ARN of ReadOnlyUser)  (e.g. arn:aws:iam::123456789012:user/ReadOnlyUser)
- AWS Service: Amazon S3
- Actions: All Actions checkbox (I have tried to select individual actions; but couldn't get it to work)
- ARN: (ARN of the S3 Bucket)  (e.g. arn:aws:s3:::somebucketname/*

Click Add; then Generate.  

This will create a Policy JSON

<pre>
{
  "Id": "Policy1498057737309",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1498057734194",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::somebucketname/*",
      "Principal": {
        "AWS": [
          "arn:aws:iam::123456789012:user/ReadOnlyUser"
        ]
      }
    }
  ]
}
</pre>

Cut and paste this JSON into the Bucket Policy and Save.

## Access the S3 Bucket

You can now use AWS cli tools to access the S3 Bucket.
