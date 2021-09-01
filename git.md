# git

## Create Branch

```
git branch newbranchname
git checkout newbranchname
git add .
git commit -m "First commit of new branch"
git push --set-upstream origin newbranchname
```

## Copy Change on DEVELOP branch to RELEASE Branch

```
# From branch in DEVELOP folder
# git diff --name-only origin/DEVELOP > ~/files-changes.txt

# In RELEASE folder pulled latest RELEASE (e.g RELEASE/v2.3.0)

DEVELOP_FOLDER="/Users/davi5017/devtopia/DEVELOP/real-time-gis-devops/"
RELEASE_FOLDER="/Users/davi5017/devtopia/RELEASE/real-time-gis-devops/"

for file in $(cat ~/files-changes.txt); do 
  echo ${file}
  if [ -f ${DEVELOP_FOLDER}${file} ]; then 
    echo "cp ${DEVELOP_FOLDER}${file} ${RELEASE_FOLDER}${file}"
    cp ${DEVELOP_FOLDER}${file} ${RELEASE_FOLDER}${file}
  else
    echo "rm ${RELEASE_FOLDER}${file}"
    rm ${RELEASE_FOLDER}${file}
  fi
done
```


## Merge Changes in Master to Branch

```
git fetch
git merge origin/master
```

Resolve conflicts if any by editing the files as needed. 


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
eval $(ssh-agent -s)
```

Add your private key

```
ssh-add -K my-github-key
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
