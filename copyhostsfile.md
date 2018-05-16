# Copy hosts file

```cat /etc/hosts | ssh -i centos.pem p3 "sudo sh -c 'cat >/etc/hosts'"```

