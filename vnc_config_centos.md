# Enable VNC on CentOS Node

## Create a DC/OS Cluster 

Create cluster
- 3 Masters
- 5 agents
- 1 public agent

Then installed DC/OS with 1 5 1 leaving m2 and m3 as test nodes. 

## SSH to Server

Install nodes as Public Agents; then stop and disable. This is just an easy way to configure the nodes so they have Mesos-DNS.

<pre>
sudo curl boot/install.sh
sudo bash install.sh slave_public

systemctl stop dcos-mesos-slave
systemctl disable dcos-mesos-slave
</pre>

## Install GNOME

<pre>
$ sudo su - 
# yum -y groupinstall "GNOME Desktop"
</pre>

Takes a couple of mins (818 packages)

## Create VNC User

<pre>
# useradd -G wheel david
# passwd david
</pre>

Optional: Add line /etc/sudoers wheel group can sudo without a password


## Install and Configure vncserver

<pre>
# yum -y install tigervnc-server
# cd /lib/systemd/system
# cp vncserver@.service vncserver@:1.service
# vi vncserver@:1.service
</pre>

Change <USER> to david 

## Configure VNC first time

<pre>
# su - david
$ vncserver 
</pre>

Create a passowrd for VNC access (can/should be different thant user password)

Stop vnc.

<pre>
$ vncserver -kill :1
</pre>

Configure vnc

<pre>
$ cd .vnc
$ vi xstartup 
</pre>

After exec line add gnome-session line
<pre>
exec /etc/X11/xinit/xinitrc
gnome-session -session=gnome-classic &
</pre>

$ exit

## Configure Service

<pre>
# systemctl start vncserver@:1.service
# systemctl status vncserver@:1.service
</pre>

You could "enable"; however, I just start it when I want to work.  Less of a security risk.

## Configure Firewalls

On Azure 

Change NSG rule for master to allow connections to port 5901.

## Configure vnc on Different Port(s) (OPTIONAL)

Edit /usr/bin/vncserver to change default ports from 5901 to something else.

### Connect 
- Linux: vncviewer (e.g. 52.175.215.224:1) or remmina with vnc-plugin (52.175.215.224:5901)
- MAC: Screen Sharing (vnc://52.175.215.224:5901)
- Windows: Example Client - http://tigervnc.org/ Download Page: https://github.com/TigerVNC/tigervnc/releases (TigerVNC)
