|Home          |Previous          | Next              |
|--------------|------------------|-------------------|
|[Home](../../)|[Setup](../setup) |[Grains](../grains)|

# Targetting

In the very first module when we fired command like ```sudo salt '*' ``` - the asterisk mark there meant run the salt command on all nodes. The star represented all the nodes but in real world we need to target a set of nodes which have certain attributes. Think of following scenarios that you might encounter as someone who is handling 100s of machines:

* I want to find out the status of Nginx service on all webservers
* I want to replace a small string in a config file on all the database servers

It is also usual to classify things on multiple conditions:

2 conditions: 
* I want to find out all machines which are Ubuntu OS in North America Region

3 conditions:
* Which all machines of CentOS7 OS which are deployed as "application servers" are running on Java version 7 or Java version 6 - so that I can upgrade them all to Java 8


Or even worst, if there is a vulnaribility that has been exposed on a certain platform, your intentions will be like:

* I want to query all Windows boxes which have XYZ version of a certain patch installed so I can fix these machines before attacker reaches them :)


## Targetting strategies

There are multiple ways you can target the nodes in Salt. Let's look at them with practical examples which work in our setup so we can make sense out of them.

To find out all nodes which have OS as Ubuntu, we use Grain called OS (We will look at grains in next module - for now simply note that Grain is a piece of system information). -G signifies that we want to filter based on a grain named "os" and value should match to Ubuntu

```
$sudo salt -G 'os:Ubuntu' test.ping

1.sagent.learn.com:
    True
0.sagent.learn.com:
    True
smaster.learn.com:
    True

```


We can also filter based on Subnet using the -S flag
```
$sudo salt -S '192.168.17.80' test.ping

smaster.learn.com:
    True
```

If you have more than one condition then you can use the compound matcher (-C) and then in the condition use the flags to signify the filtering. In following example we check if the Subnet matches and also that the OS Grain is Ubuntu

```
$sudo salt -C 'S@192.168.17.80 and G@os:Ubuntu' test.ping

smaster.learn.com:
    True
```

You can also use glob matching - for example in below example we are listing all nodes that have 0-9 in their name
```
$sudo salt '*[0-9]*' test.ping

0.sagent.learn.com:
    True
1.sagent.learn.com:
    True
```

If you want a specific list of nodes, you can use -L flag.
```
$sudo salt -L '0.sagent.learn.com,1.sagent.learn.com' test.ping

1.sagent.learn.com:
    True
0.sagent.learn.com:
    True

```

Finally we use regex matching of name to find out some nodes. 
```
$sudo salt '*smaster*' test.ping

smaster.learn.com:
    True
```

# Quiz

TBD


|Home          |Previous          | Next              |
|--------------|------------------|-------------------|
|[Home](../../)|[Setup](../setup) |[Grains](../grains)|