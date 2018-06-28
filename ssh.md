# ssh

## Keeping Session Alive

AWS default timeout for ssh session is 60 seconds. After 60 seconds the session is terminated.

Addint this to your local environment will keep the session alive.

Create ~/.ssh/config

```
ServerAliveInterval 50
```

This will cause the client to send a signal to the server every 50 seconds avoiding the timeout.

