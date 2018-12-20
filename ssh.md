# ssh

## Keeping Session Alive

AWS default timeout for ssh session is 60 seconds. After 60 seconds the session is terminated.

Addint this to your local environment will keep the session alive.

Create ~/.ssh/config

```
ServerAliveInterval 50
```

This will cause the client to send a signal to the server every 50 seconds avoiding the timeout.


## Define Host Configuration

In ~/.ssh/config add

```
Host dj1220
  User az
  HostName 52.247.236.251
  IdentityFile ~/az
```

Then you can connect using ```ssh dj1220```.

You can also define tunnels in the config.

```
Host dj1220
  User az
  HostName 52.247.236.251
  IdentityFile ~/az
  LocalForward 8081 10.10.32.11:8081
```
