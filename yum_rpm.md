# yum and rpm

## Download rpm 

<pre>
yum -y install yum-utils
yumdownloader selinux-policy-targeted-3.13.1-166.el7_4.4.noarch
</pre>

## Extract rpm without installing

This command will extract files from the rpm into the local directory.

<pre>
rpm2cpio selinux-policy-targeted-3.13.1-60.el7_2.9.noarch.rpm | cpio -idmv
</pre>

