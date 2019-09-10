# git

## Authentication

### No Authentication

If the repo has no Authentication you can just clone with git ```git clone http://github.com/david618/rttest```

### Regular Authentication 

Same as above; however, you'll be prompted for username and password.

### Two Factor Authentication

Regular commands do not work.  Two options one Personal Access Token or SSH Key.

#### Personal Access Token

From GitHub settings under develop settings.  Generate a access token.  Give the token repo and gist scopes. Now when you connect use your Github user; but instead of using your password enter your access token.  The token is a random 40+ character string of characters and numbers. 

#### SSH keys

Generate a key pair.

```
ssh-keygen
``` 

Give the key a name.  For example ```my-github-key```.  You can optionally set a password; however, everytime you use the key you'll need to enter that password.  

In Github Settings under SSH and GPG keys add new SSH key.  Give it a name and paste in the public key (e.g. Contents of my-github-key.pub)

Using the Key

Start ssh-agent

```
eval `ssh-agent -s`
```

Add your private key

```
ssh-add my-github-key
```

Now you can use git.

```
git clone git@github.com:david618/rttest.git
```


## Restore to Previous Check in

After a couple of checkin I figured out I had lost a bunch of code and messed up.  I used these command to restore the project to a previous point.

Found the number by clicking on Commit tab in the Web UI.  Clicked button to copy full SHA.

<pre>
git reset --hard  4690b6702646d9d77725c45a5da50fec6f435300

</pre>

Verified this the the point I wanted to restore to.

<pre>
git add . --all
git commit -m "restored"
push --force
</pre>


## Creating Web Page(s) for GitHub Repos

The [pages](https://pages.github.com/) explains how to create a repo with web content for your GitHub repo.

The web page is tied to your github username for example [https://david618.github.io/](https://david618.github.io/)

You make changes to web content in repo and they appear as web content. 
