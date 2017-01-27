wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" >> /etc/apt/sources.list.d/saltstack.list

sudo apt-get -y update

apt-get install -y salt-minion
sudo cp /vagrant/conf/minion /etc/salt
sudo cp /vagrant/conf/_schedule.conf /etc/salt/minion.d
echo "192.168.17.80 salt" >> /etc/hosts

service salt-minion restart
