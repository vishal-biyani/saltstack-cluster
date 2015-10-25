yum install wget

wget https://repo.saltstack.com/yum/rhel7/SALTSTACK-GPG-KEY.pub
rpm --import SALTSTACK-GPG-KEY.pub
rm -f SALTSTACK-GPG-KEY.pub

sudo cp /vagrant/conf/saltstack.repo /etc/yum.repos.d/saltstack.repo

sudo yum clean expire-cache
sudo yum update

yum install salt-master
#yum install salt-minion
yum install salt-ssh
yum install salt-syndic
yum install salt-cloud

chkconfig salt-master on
service salt-master start