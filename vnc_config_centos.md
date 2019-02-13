# Enable VNC on CentOS Node

## Create a DC/OS Cluster 

Create cluster
- 3 Masters
- 5 agents
- 1 public agent

Then installed DC/OS with 1 5 1 leaving m2 and m3 as test nodes. 

## SSH to Server

Install nodes as Public Agents; then stop and disable. This is just an easy way to configure the nodes so they have Mesos-DNS.

```
sudo curl boot/install.sh
sudo bash install.sh slave_public

systemctl stop dcos-mesos-slave
systemctl disable dcos-mesos-slave
```

## Install GNOME

```
sudo su - 
yum update
yum -y groupinstall "GNOME Desktop"
```

Takes a couple of mins (818 packages)

## Create VNC User

```
useradd -G wheel david
passwd david
```

Optional: Add line /etc/sudoers wheel group can sudo without a password


## Install and Configure vncserver

```
yum -y install tigervnc-server
cd /lib/systemd/system
cp vncserver@.service vncserver@:1.service
vi vncserver@:1.service
```

Change <USER> to david 

## Configure VNC first time

```
su - david
vncserver 
```

Create a passowrd for VNC access (can/should be different thant user password)

Stop vnc.

```
$ vncserver -kill :1
```

Configure vnc

```
cd .vnc
vi xstartup 
```

After exec line add gnome-session line
```
gnome-session -session=gnome-classic &
```

Comment out 
```
#vncserver -kill $DISPLAY
```

$ exit

## Configure Service

```
systemctl start vncserver@:1.service
systemctl status vncserver@:1.service
```

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
