# Create CentOS 7.2 AMI

*WARNING: If you are using a AWS Free Tier you will probably overrun your snapshot allowance and may incur some charges if you import an AMI.*

## Create VirtualBox VM
- Start with minimum install of CentOS (Be sure to use CentOS 7.2; 7.3 is not supported)
- Install other packages needed for [DCOS Advanced Instllation](https://dcos.io/docs/1.8/administration/installing/custom/system-requirements/)

*WARNING: Do not do yum update. This will upgrade you to 7.3*

Install Packages

<pre>
$ sudo su -
# yum install ipset
# yum install bind-utils
# yum install bash-completion
# yum install vim
# yum install unzip
</pre>

### Configurations for DCOS

<pre>
# groupadd nogroup

# vi /etc/sysctl.conf
</pre>

Add these lines.

<pre>
vm.max_map_count=262144
vm.swappiness = 1
</pre>

The default install of CentOS 7.2 has tuned configured

<pre>
# systemctl status tuned
# vi  /usr/lib/tuned/virtual-guest/tuned.conf
</pre>

Change swappiness in tuned.conf to 1.

Disable Firewall
<pre>
# systemctl disable firewalld.service
# systemctl stop firewalld.service
</pre>

Disable Selinux
<pre>
# vi /etc/selinux/config
</pre>
Change enforcing to disabled and save. 

### Install Docker

<pre>
# vi /etc/yum.repos.d/docker.repo
</pre>

<pre>
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/\$releasever/
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
</pre>

<pre>
# vi /etc/modules-load.d/overlay.conf
</pre>

<pre>
overlay
</pre>

<pre>
# mkdir /etc/systemd/system/docker.service.d
# vi /etc/systemd/system/docker.service.d/override.conf
</pre>

<pre>
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --storage-driver=overlay
</pre>

<pre>
# yum install -y docker-engine

# systemctl start docker
# systemctl enable docker
</pre>


### Create and configure "centos" user

<pre>
# useradd centos
</pre>

Modify /etc/sudoers. Comment out default wheel line and uncommented the NOPASSWD line.

<pre>
## Allows people in group wheel to run all commands

#%wheel ALL=(ALL)       ALL

## Same thing without a password

%wheel  ALL=(ALL)       NOPASSWD: ALL
</pre>

Add centos user to the wheel group

<pre>
# usermod -aG wheel centos
</pre>

### Use Cloud-init

Install cloud-init service.

<pre>
# yum install cloud-init
</pre>

The configuration file is here: /etc/cloud/cloud.cfg

However, with no changes this configuration file worked for Amazon Web Services.  It automatically disabled SSH access using passwords and the user centos was configured as the login user.


Stop and Disable NetworkManager; otherwise, the instance will not pick up AWS DNS entries.

<pre>
# systemctl stop NetworkManager
# systemctl disable NetworkManager
</pre>


*** Note *** When starting the image in Virutal Box cloud-init will try to start and you'll see a lot of errors. You can stop them using the systemctl stop cloud-init command. 

You can skip the next section.


### Create a startup script to import the AWS pki (*** Skip if using Cloud-init ***)

<pre>
# vi /usr/local/bin/config_centos_aws_pki.sh
</pre>

<pre>
#!/usr/bin/env bash

# exit if  /home/centos/.ssh/authorized_keys already exists
test -f /home/centos/.ssh/authorized_keys && logger "/home/centos/.ssh/authorized_keys already exists" && exit 0

# get public key from aws meta data service and add to authorized_keys; time out after 3 seconds
KEY=$(curl -m 3 http://169.254.169.254/1.0/meta-data/public-keys/0/openssh-key)

# if KEY is empty then exit
if [ -z "$KEY" ]; then
        logger "curl to 169.254.169.254 did not return a key"
        exit 0
fi

# create .ssh directory if needed and set permissions
test -d /home/centos/.ssh || mkdir -m 750 /home/centos/.ssh

# Copy the key to .ssh folder as authorized_keys
echo "$KEY" > /home/centos/.ssh/authorized_keys

# Set permission of authorized_keys
chmod 640 /home/centos/.ssh/authorized_keys
chown -R centos. /home/centos/.ssh

# Disable password access
sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config
systemctl restart sshd.service


</pre>

Change permissions on the file to make it executable.

<pre>
# chmod a+x /usr/local/bin/config_centos_aws_pki.sh
</pre>

Create a systemd file to execute the script each time the VM is started.

<pre>
# vi /etc/systemd/system/config_centos_aws_pki.service
</pre>

<pre>
[Unit]
After=default.target

[Service]
ExecStart=/usr/local/bin/config_centos_aws_pki.sh

[Install]
WantedBy=default.target
</pre>

**NOTE: For some reason if you enable the startup script on the import; the script doesn't work correctly and you will not be able to login using PKI key.or Password **

<pre>
# systemctl daemon-reload
# systemctl disable config_centos_aws_pki.service
</pre>

### Create OVA  
Stop the VM 
<pre>
# systemctl shutdown
</pre>

From VirtualBox menu export the VM. 


## Install and Configure AWS CLI

Follow [AWS instructions for install the CLI](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

After installed you'll need to [configure access](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-set-up.html)

### Create S3 Bucket

You can use an existing bucket if you have one

### Copy the OVA to S3

<pre>
$ aws s3 cp c72.ova s3://geoevent-ova-files
</pre>

Upload took about 10 minutes. Limited by 7Mbps upload speed.

### Create trust-policy.json

<pre>
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Principal": { "Service": "vmie.amazonaws.com" },
         "Action": "sts:AssumeRole",
         "Condition": {
            "StringEquals":{
               "sts:Externalid": "vmimport"
            }
         }
      }
   ]
}
</pre>

<pre>
$ aws iam create-role --role-name vmimport --assume-role-policy-document file://trust-policy.json
</pre>

### Create role-policy.json

<pre>
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Effect": "Allow",
         "Action": [
            "s3:ListBucket",
            "s3:GetBucketLocation"
         ],
         "Resource": [
            "arn:aws:s3:::geoevent-ova-files"
         ]
      },
      {
         "Effect": "Allow",
         "Action": [
            "s3:GetObject"
         ],
         "Resource": [
            "arn:aws:s3:::geoevent-ova-files/*"
         ]
      },
      {
         "Effect": "Allow",
         "Action":[
            "ec2:ModifySnapshotAttribute",
            "ec2:CopySnapshot",
            "ec2:RegisterImage",
            "ec2:Describe*"
         ],
         "Resource": "*"
      }
   ]
}
</pre>

<pre>
$ aws iam put-role-policy --role-name vmimport --policy-name vmimport --policy-document file://role-policy.json
</pre>

### Create containers.json

<pre>
[
  {
    "Description": "CentOS 7.2 OVA",
    "Format": "ova",
    "UserBucket": {
        "S3Bucket": "geoevent-ova-files",
        "S3Key": "c72.ova"
    }
}]
</pre>

### Start the import

<pre>
$ aws ec2 import-image --description "CentOS 7.2 OVA" --disk-containers file://containers.json
</pre>

The response will be something like.

<pre>
{
    "ImportImageTasks": [
        {
            "Status": "active", 
            "Description": "CentOS 7.2 OVA", 
            "Progress": "2", 
            "SnapshotDetails": [
                {
                    "UserBucket": {
                        "S3Bucket": "geoevent-ova-files", 
                        "S3Key": "c72.ova"
                    }, 
                    "DiskImageSize": 0.0, 
                    "Format": "OVA"
                }
            ], 
            "StatusMessage": "pending", 
            "ImportTaskId": "import-ami-ffjn6tdg"
        }
    ]
}
</pre>

### Check Progress

<pre>
$ aws ec2 describe-import-image-tasks --import-task-ids import-ami-ffjn6tdg
</pre>

The response will be something like this. The "Progress" value of 28 indicates that the import is 28% complete.

<pre>
{
    "ImportImageTasks": [
        {
            "Status": "active", 
            "Description": "CentOS 7.2 OVA", 
            "Progress": "28",    
            "SnapshotDetails": [
                {
                    "UserBucket": {
                        "S3Bucket": "geoevent-ova-files", 
                        "S3Key": "c72.ova"
                    }, 
                    "DiskImageSize": 550958080.0, 
                    "Format": "VMDK"
                }
            ], 
            "StatusMessage": "converting", 
            "ImportTaskId": "import-ami-ffjn6tdg"
        }
    ]
}
</pre>

The import took a few minutes.  ** Time for coffee.**

Note the "Status" is now completed.

<pre>
{
    "ImportImageTasks": [
        {
            "Status": "completed", 
            "LicenseType": "BYOL", 
            "Description": "CentOS 7.2 OVA", 
            "ImageId": "ami-ca19d8dc", 
            "Platform": "Linux", 
            "Architecture": "x86_64", 
            "SnapshotDetails": [
                {
                    "UserBucket": {
                        "S3Bucket": "geoevent-ova-files", 
                        "S3Key": "c72.ova"
                    }, 
                    "SnapshotId": "snap-07f9f7f7b7153dafd", 
                    "DiskImageSize": 551022592.0, 
                    "DeviceName": "/dev/sda1", 
                    "Format": "VMDK"
                }
            ], 
            "ImportTaskId": "import-ami-ffjn6tdg"
        }
    ]
}
</pre>

After some time the import completed; the AMI shows up as available under EC2 -&gt; Images -&gt; AMI's.   

### Modify the Instance to Disable Password Access  (*** Skip if using Cloud-init ***)

Create Instance from this imported AMI with a t2.micro instance type.

On "Add Storage" page check the box for "Delete on Termination"

Launch the instance.

Limit access only from your IP  (x.x.x.x/32).  You can do a Google search on "my ip" to see what your IP is.

Login to the new EC2 instance using root password.

<pre>
$ ssh root@ec2-52-14-165-244.us-east-2.compute.amazonaws.com
</pre>

Enable the startup script.

<pre>
# systemctl disable config_centos_aws_pki.service
</pre>

After status checks are Green.  Create an new Image (AMI) from the modified instance.  It'll take a minute or two for the image to be "available" under AMIs.

Terminate the temp instance and the deregister AMI that was imported. 

### Use the AMI

Create instances as needed from the new modified AMI.  You should not be able to login with Password as root or centos.  You will need to use the AWS PKI Pair. 

<pre>
$ ssh -i "centos.pem" centos@ec2-54-163-177-117.compute-1.amazonaws.com
</pre>

