# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

MASTER_MEMORY=1024
AGENT_MEMORY=512
MASTER_INSTANCES=1
AGENT_INSTANCES=2

SALT_SUBNET="192.168.17"
SALT_MASTER_ADDRESS="192.168.17.80"

DOMAIN_NAME="sagent.learn.com"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	MASTER_INSTANCES.times do |i|
		config.vm.define "salt_master" do |smaster|
			smaster.vm.box = "ubuntu/trusty64"
			smaster.vm.network "private_network", ip: "#{SALT_MASTER_ADDRESS}"
			smaster.vm.hostname = "smaster.learn.com"
			smaster.vm.provider :virtualbox do |vb|
				vb.customize ["modifyvm", :id, "--memory", MASTER_MEMORY]
			end
			smaster.vm.provision "shell", path: "scripts/installSaltMaster.sh"
		end
	end

	AGENT_INSTANCES.times do |i|
		config.vm.define "salt_agent_#{i}" do |sagent|
			sagent.vm.box = "ubuntu/trusty64"
			sagent.vm.network "private_network", ip: "#{SALT_SUBNET}.#{i+50}"
			sagent.vm.hostname = "#{i}.#{DOMAIN_NAME}"
			sagent.vm.provider :virtualbox do |vba|
				vba.customize ["modifyvm", :id, "--memory", AGENT_MEMORY]
			end
			sagent.vm.provision "shell" do |ss|
			    ss.path = "scripts/installSaltAgent.sh"
			    ss.args = ["#{i}.#{DOMAIN_NAME}"]
			end
		end
	end	
end
