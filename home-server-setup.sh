
#!/bin/bash
yum -y update && yum -y upgrade

# Install EPEL repo
sudo su -c 'rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'

# Install necessary tools
yum -y install htop iotop nethogs

# Install monit
yum -y install monit
chkconfig monit on

# Configure monit
mv /etc/monit.conf /etc/monit.conf.old
wget -c <URL> --output-document=/etc/monit.conf
monit reload

# Configure service to be monitored by monit
mv /etc/monit.d/service /etc/monit.d/service.old
wget -c <URL> --output-document=/etc/monit.d/service

monit start all

# Install NFS & RPCbind
yum -y install nfs* 
yum -y install rpcbind* 
chkconfig nfs on
chkconfig rpcbind on

# Configure NFS
mkdir /cpanel
echo "/cpanel 10.99.0.10(rw,sync,fsid=0)" >> /etc/exports

service rpcbind restart
service nfs restart

exit
