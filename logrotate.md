# Rotate and Compress Logs


/etc/logrotate.d/syslog

```
/var/log/cron
/var/log/maillog
/var/log/messages
/var/log/secure
/var/log/spooler
{
    compress
    daily
    delaycompress
    dateext
    rotate 7
    missingok
    sharedscripts
    postrotate
        /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
    endscript
}
```
