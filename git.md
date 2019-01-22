# git

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
