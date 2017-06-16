# AWS CLI


## Install AWS CLI on CentOS
<pre>
sudo yum -y install epel-release
sudo yum -y install python-pip
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



