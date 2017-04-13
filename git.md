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
