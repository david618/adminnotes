# rsync

## Copy Folder to Remove Computer

```
rsync -avz -e "ssh -i centos.pem" installers/ geo1:./installers/
```

