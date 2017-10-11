

|Previous       | Next              |
|---------------|-------------------|
|[Home](../../) |[Targetting](../target) |

# Setup

The setup uses a simple multi Vagrant box setup to play around with Saltstack. You need working Vagrant on your machine to use this demo. If you don't have Vagrant, you can install Vagrant and Virtualbox from links below:

## Prerequisites

- [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

**Please note that the Vgarant command need to be run from root directory of this project as Vagrantfile is in root dirrectory**

Before you run Vagrant up - change following parameters in Vagrantfile as per your need/taste. I typically start 1 master and 2/3 node cluster with 2GB for Master and 512MB/1GB for nodes based on what I need to build.

## Configure

```
MASTER_MEMORY=2048
AGENT_MEMORY=512
MASTER_INSTANCES=1
AGENT_INSTANCES=2
```
Also if you face issue with network or getting box up, try changing the subnet in Vagrantfile 

```
SALT_SUBNET="192.168.17"
SALT_MASTER_ADDRESS="192.168.17.99"
```
## Run

Now run ```vagrant up``` which will download the base boxes and then setup the cluster. If you don't have the base boxes, the download can take some time based on connection speed.

Once `vagrant up` runs successfully, you should see one master and multiple agents based on your configuration. With default configuration here is what I see:

```
Current machine states:

salt_master               running (virtualbox)
salt_agent_0              running (virtualbox)
salt_agent_1              running (virtualbox)
```

You can get into any box by using ```vagrant ssh``` command (Works better with Git bash/Cygwin on Windows)

```
vagrant ssh salt_master
vagrant@smaster:~$

```
## Salt Verification


Once you are in the master box, you should see the incoming key requests for two boxes for approval. What this means is that the minions are pointing to this master and asking for one time approval for them to be part of under this master's management.

```
$ sudo salt-key
Accepted Keys:
Denied Keys:
Unaccepted Keys:
0.sagent.learn.com
1.sagent.learn.com
smaster.learn.com
Rejected Keys:
```

Let's accept all the incoming keys because we trust all these boxes:

```
$ sudo salt-key -A
The following keys are going to be accepted:
Unaccepted Keys:
0.sagent.learn.com
1.sagent.learn.com
smaster.learn.com
Proceed? [n/Y] Y
Key for minion 0.sagent.learn.com accepted.
Key for minion 1.sagent.learn.com accepted.
Key for minion smaster.learn.com accepted.
```

Once you have accepted the keys, you will see them in accepted section:

```
$ sudo salt-key
Accepted Keys:
0.sagent.learn.com
1.sagent.learn.com
smaster.learn.com
Denied Keys:
Unaccepted Keys:
Rejected Keys:
```

In a typical production setup where you might be managing hunderds or thousands of nodes, accepting the key can be tricky. You don't want to by default accept all keys but also want some sane way to validate that you are getting requests from authentic machines. There are multiple ways to handle this, for example some organizations might decide that all machines which have a DOMAIN name of organization can be considered legitimate and auto accept be enabled for them - but you will have to write a Salt formula for doing this logical decision.

If you want by default that all minions be accepted, then you can change the following setting in ```/etc/salt/master``` file on the master server and restart salt-master process for it to take effect:

```
# Enable auto_accept, this setting will automatically accept all incoming
# public keys from the minions. Note that this is insecure.
#auto_accept: False
```

Now having accepted all the minions's certificate request, it's time to do a quick verification that all nodes are reachable, let's run the command:

```
$ sudo salt '*' test.ping
smaster.learn.com:
    True
1.sagent.learn.com:
    True
0.sagent.learn.com:
    True
```

In essense what we are doing in above statement is checking if all nodes are reachable. But let's deconstruct some technical details:

``` '*' ``` : This is called targetting, here by using asterisk we are targetting all nodes that are part of this master's infrastructure. We will look at targetting a bit more in detail soon.

```test.ping```: We are calling the ping method on test module here. Salt has many kinds of modules and test is an execution module. There can be state modules for executing states, grains modules related to grains and so on. But overall the structure is same - module_name.method_name and what happens depends on module implementation.

Finally we used the Salt CLI for first time from master and executed a simple command. We will be use a lot of the CLI from master as well as minion (From minion you have to call salt-call) eventually but this is a good start

|Previous       | Next              |
|---------------|-------------------|
|[Home](../../) |[Targetting](../target) |