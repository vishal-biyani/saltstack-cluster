yum install wget

wget https://repo.saltstack.com/yum/rhel7/SALTSTACK-GPG-KEY.pub
rpm --import SALTSTACK-GPG-KEY.pub
rm -f SALTSTACK-GPG-KEY.pub

sudo cp /vagrant/conf/saltstack.repo /etc/yum.repos.d/saltstack.repo

sudo yum clean expire-cache
sudo yum update

yum install salt-minion

sed -i '/master/\cmaster: salt' /etc/salt/minion
echo "192.168.17.99 salt" > /etc/hosts

chkconfig salt-minion on
service salt-minion start