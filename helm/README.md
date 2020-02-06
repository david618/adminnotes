## Upgrade to Latest Versions of Helm

Using helm 2.16.1 as of 6 Feb 2020.

#### Helm on Mac 

Using brew.

```
brew install helm@2
```

or

```
brew upgrade helm@2
```

Be sure to include the @2; this will install helm version 2.  The helm charts we are using currently don't work in helm 3.

You'll need to add it to your Path.

```
echo 'export PATH="/usr/local/opt/helm@2/bin:$PATH"' >> ~/.bash_profile
```

Then either open a new Terminal or source your .bash_profile.  

```
source ~/.bash_profile
``` 


#### Helm on Ubuntu

```
helm version
Client: &version.Version{SemVer:"v2.16.1", GitCommit:"bbdfe5e7803a12bbdf97e94cd847859890cf4050", GitTreeState:"clean"}
Error: the server could not find the requested resource (get pods)  
```

You'll get an Error from server; if you currently don't have context set for kubectl.


```
curl -s https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.g

sha256sum helm-v2.16.1-linux-amd64.tar.gz

Should be: 7eebaaa2da4734242bbcdced62cc32ba8c7164a18792c8acdf16c77abffce202

tar xvzf helm-v2.16.1-linux-amd64.tar.gz

sudo cp linux-amd64/helm /usr/local/bin
sudo cp linux-amd64/tiller /usr/local/bin
```

