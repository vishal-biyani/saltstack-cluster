# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

MASTER_MEMORY=3072
AGENT_MEMORY=256
MASTER_INSTANCES=1
AGENT_INSTANCES=2

SALT_SUBNET="192.168.17"
SALT_MASTER_ADDRESS="192.168.17.99"

DOMAIN_NAME="sagent.vb.com"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	MASTER_INSTANCES.times do |i|
		config.vm.define "SALT_master" do |smaster|
			smaster.vm.box = "centos/7"
			smaster.vm.network "private_network", ip: "#{SALT_MASTER_ADDRESS}"
			smaster.vm.hostname = "SALT.learn.com"
			smaster.vm.provider :virtualbox do |vb|
				vb.customize ["modifyvm", :id, "--memory", MASTER_MEMORY]
			end
			smaster.vm.provision "shell", path: "scripts/installSALTMaster.sh"
		end
	end

	AGENT_INSTANCES.times do |i|
		config.vm.define "SALT_agent_#{i}" do |sagent|
			sagent.vm.box = "centos/7"
			sagent.vm.network "private_network", ip: "#{SALT_SUBNET}.#{i+10}"
			sagent.vm.hostname = "#{i}.#{DOMAIN_NAME}"
			sagent.vm.provider :virtualbox do |vba|
				vba.customize ["modifyvm", :id, "--memory", AGENT_MEMORY]
			end
			sagent.vm.provision "shell", path: "scripts/installSALTAgent.sh"
		end
	end	
end