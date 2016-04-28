wget -O - https://repo.saltstack.com/apt/ubuntu/ubuntu14/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/ubuntu14/latest trusty main" >> /etc/apt/sources.list

sudo apt-get -y update

apt-get install -y salt-master
apt-get install -y salt-minion
apt-get install -y salt-ssh

echo "192.168.17.80 salt" >> /etc/hosts
sudo cp /vagrant/conf/minion /etc/salt
sudo cp /vagrant/conf/master /etc/salt
sudo cp /vagrant/conf/reactor.conf /etc/salt/master.d
sudo mkdir -p /srv/formulas 
sudo mkdir -p /srv/salt
sudo mkdir -p /srv/pillars

service salt-master restart
service salt-minion restart
