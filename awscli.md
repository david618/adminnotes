# AWS CLI


## Install AWS CLI on CentOS
sudo yum -y install epel-release
sudo yum -y install python-pip

## Configure AWS CLI
aws configure
<< Provide you're ID, Key, azone (e.g. us-west-1), None is ok for default format

## List S3 Bucket
aws s3 ls s3://mobilephonedata

## Copy File From S3 Bucket to Local Folder
aws s3 cp s3://mobilephonedata/part_r_00499.csv /home/azureuser/

## Copy All Files in S3 Bucket to Local Folder
aws s3 sync s3://mobilephonedata/part_r_00499.csv /home/azureuser/mobilephonedata



