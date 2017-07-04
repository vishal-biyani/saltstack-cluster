wget -O - https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" >> /etc/apt/sources.list.d/saltstack.list

echo "192.168.17.80 salt" >> /etc/hosts
echo "127.0.0.1 $1" >> /etc/hosts
sudo hostnamectl set-hostname $1

sudo apt-get -y update
sudo apt-get install -y --force-yes salt-minion
sudo cp /vagrant/conf/minion /etc/salt
sudo cp /vagrant/conf/_schedule.conf /etc/salt/minion.d

sudo service salt-minion restart
