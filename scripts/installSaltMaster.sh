wget -O - https://repo.saltstack.com/apt/ubuntu/ubuntu14/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/ubuntu14/latest trusty main" >> /etc/apt/sources.list

sudo apt-get -y update

apt-get install -y salt-master
apt-get install -y salt-minion
apt-get install -y salt-ssh
apt-get install -y salt-syndic

service salt-master restart