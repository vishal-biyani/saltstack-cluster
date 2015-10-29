# saltstack-cluster

A simple multi Vagrant box setup to play around with Saltstack. You need working Vagrant on your machine to use this demo.

Before you run Vagrant up - change following parameters in Vagrantfile as per your need/taste:
```
MASTER_MEMORY=2048
AGENT_MEMORY=256
MASTER_INSTANCES=1
AGENT_INSTANCES=2
```
Also if you face issue with network or getting box up, try changing the subnet in Vagrantfile 

```
SALT_SUBNET="192.168.17"
SALT_MASTER_ADDRESS="192.168.17.99"
```
Once `vagrant up` runs successfully, you should see one master and multiple agents based on your configuration. With default configuration here is what I see:

```
Current machine states:

salt_master               running (virtualbox)
salt_agent_0              running (virtualbox)
salt_agent_1              running (virtualbox)
```

