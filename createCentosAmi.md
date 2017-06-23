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
