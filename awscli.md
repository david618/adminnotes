# AWS CLI


## Install AWS CLI 

### CentOS
<pre>
sudo yum -y install epel-release
sudo yum -y install python-pip
pip install --upgrade --user awscli
</pre>

**Note:** For RHEL 6 you might need to add .local/bin to your PATH

**Note:** 15 Feb 18: botocore was updated 16 hours ago and now awscli won't install. Error `No matching distribution found for botocore==1.8.43 (from awscli)`.   Work around run this command first: `sudo pip install boto3`

### MacOS

<pre>
sudo easy_install awscli
</pre>

or

<pre>
brew install awscli
</pre>
 
## Configure AWS CLI
<pre>
aws configure
</pre>
<< Provide you're ID, Key, azone (e.g. us-west-1), None is ok for default format

## List S3 Bucket
<pre>
aws s3 ls s3://mobilephonedata
</pre>

## Copy File From S3 Bucket to Local Folder
<pre>
aws s3 cp s3://mobilephonedata/part_r_00499.csv /home/azureuser/
</pre>

## Copy All Files in S3 Bucket to Local Folder
<pre>
aws s3 sync s3://mobilephonedata/part_r_00499.csv /home/azureuser/mobilephonedata
</pre>

## Upload file in folder (Bash Script)

For example to upload files planes00001 to planes00012 to aws.

<pre>
#!/bin/bash

for i in {1..12}; do
  if [ "$i" -le 9 ]; then
     filename=planes0000${i}
  else
     filename=planes000${i}
  fi
  echo ${filename}
  aws s3 cp ${filename} s3://createroutedata
done
</pre>
