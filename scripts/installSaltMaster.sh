wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" >> /etc/apt/sources.list.d/saltstack.list

sudo apt-get -y update

sudo apt-get install -y salt-master
sudo apt-get install -y salt-minion
sudo apt-get install -y salt-ssh

echo "192.168.17.80 salt" >> /etc/hosts
sudo cp /vagrant/conf/minion /etc/salt
sudo cp /vagrant/conf/master /etc/salt
sudo cp /vagrant/conf/reactor.conf /etc/salt/master.d
sudo mkdir -p /srv/formulas 
sudo mkdir -p /srv/salt
sudo mkdir -p /srv/pillars

sudo service salt-master restart
sudo service salt-minion restart
