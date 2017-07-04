[Go back home](https://github.com/vishal-biyani/saltstack-cluster)

|Previous                | Next              |
|------------------------|-------------------|
|[Targetting](../target) |[YAML](../yaml)    |

# Grains

Grains are pieces of information about the Nodes in your cluster that Salt discovers when it installs Minion on the node. The grain attribute comprise of information about the OS, Kernel and other system information attributes.

In addition to the built in Grains, you can also add custom grains to a node which can be used for classification. For example some teams add a "roles" grain to the system and then assign roles such as "webserver", "dbserver" and so on to a node.

A grain can be a value or a list of values based on nature of the grain attribute. Let's get some practicals :) 

## Built In Grains
Built in grains are pieces of information which Salt itself discovers ands is typically related to kernel, system and any other available information based on OS.

To list grains that are present on a node, we can use ls command on grains module:

```
sudo salt '*1*' grains.ls
1.sagent.learn.com:
    - SSDs
    - biosreleasedate
    - biosversion
    - cpu_flags
    - cpu_model
    - cpuarch
    - disks
    - dns
    - domain
    - fqdn
    - fqdn_ip4
    - fqdn_ip6
    - gid
    - gpus
    - groupname
    - host
    - hwaddr_interfaces
    - id
    - init
    - ip4_interfaces
    - ip6_interfaces
    - ip_interfaces
    - ipv4
    - ipv6
    - kernel
    - kernelrelease
    - locale_info
    - localhost
    - lsb_distrib_codename
    - lsb_distrib_description
    - lsb_distrib_id
    - lsb_distrib_release
    - machine_id
    - manufacturer
    - master
    - mdadm
    - mem_total
    - nodename
    - num_cpus
    - num_gpus
    - os
    - os_family
    - osarch
    - oscodename
    - osfinger
    - osfullname
    - osmajorrelease
    - osrelease
    - osrelease_info
    - path
    - pid
    - productname
    - ps
    - pythonexecutable
    - pythonpath
    - pythonversion
    - saltpath
    - saltversion
    - saltversioninfo
    - server_id
    - shell
    - uid
    - username
    - uuid
    - virtual
    - zmqversion
 ```

If we want to see the values of the grains as well, we can use items command on the grains module. The output is fairly long and I have truncated it and pasted it here:


```
sudo salt '*1*' grains.items
1.sagent.learn.com:
    ----------
    SSDs:
    biosreleasedate:
        12/01/2006
    biosversion:
        VirtualBox
    cpu_flags:
        - fpu
        - vme
        - de
        - pse
        - tsc
        - msr
        - pae
        - mce
        - cx8
        - apic
        - sep
        - mtrr
        - pge
        - mca
        - cmov
        - pat
        - pse36
        - clflush
        - mmx
        - fxsr
        - sse
        - sse2
        - syscall
        - nx
        - rdtscp
        - lm
        - constant_tsc
        - rep_good
        - nopl
        - xtopology
        - nonstop_tsc
        - pni
        - pclmulqdq
        - monitor
        - ssse3
        - cx16
        - sse4_1
        - sse4_2
        - movbe
        - popcnt
        - aes
        - xsave
        - avx
        - rdrand
        - lahf_lm
        - abm
        - 3dnowprefetch
        - rdseed
    cpu_model:
        Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz
    cpuarch:
        x86_64
    disks:
        - sda
        - ram0
        - ram1
        - ram2
        - ram3
        - ram4
        - ram5
        - ram6
        - ram7
        - ram8
        - ram9
        - loop0
        - loop1
        - loop2
        - loop3
        - loop4
        - loop5
        - loop6
        - loop7
        - ram10
        - ram11
        - ram12
        - ram13
        - ram14
        - ram15
    dns:
        ----------
        domain:
        ip4_nameservers:
            - 10.0.2.3
        ip6_nameservers:
        nameservers:
            - 10.0.2.3
        options:
        search:
            - infracloud.com
        sortlist:
    domain:
        sagent.learn.com
    fqdn:
        1.sagent.learn.com
    fqdn_ip4:
        - 127.0.0.1
    fqdn_ip6:
        - ::1
    gid:
        0
    gpus:
        |_
          ----------
          model:
              VirtualBox Graphics Adapter
          vendor:
              unknown
    groupname:
        root
    host:
        1
    hwaddr_interfaces:
        ----------
        eth0:
            08:00:27:ce:e5:3b
        eth1:
            08:00:27:36:47:bd
        lo:
            00:00:00:00:00:00
    id:
        1.sagent.learn.com
    init:

 ```

Now to only list the grains and their values you need you can pass arguments to the item method as shown in example below:


 ```
 sudo salt '*1*' grains.item os_family osfinger
1.sagent.learn.com:
    ----------
    os_family:
        Debian
    osfinger:
        Ubuntu-14.04
```

## Grains Configuration

The grains for a node can be configured in two different ways. One way is to configure the minion file located at ```/etc/salt/minion``` and modify the grains section there. Following snippet shows the grains configuration example commented in the minion configuration file.

As you can notice, the roles grain is a list whereas the deployment and other grains have a single value. Let's uncomment these values and save the file. Please note that the 'grains' declaration should start with one space and each of others are separated by two spaces (This is a YAML syntax which we will cover shortly)


```
# Custom static grains for this minion can be specified here and used in SLS
# files just like all other grains. This exmple sets 4 custom grains, with
# the 'roles' grain having two values that can be matched against.
#grains:
#  roles:
#    - webserver
#    - memcache
#  deployment: datacenter4
#  cabinet: 13
#  cab_u: 14-15
#
```
After modification the grain section looks like:

```
# the 'roles' grain having two values that can be matched against.
 grains:
   roles:
     - webserver
     - memcache
   deployment: datacenter4
#  cabinet: 13
#  cab_u: 14-15
```
Now we will have to restart the minion for above changes to take effect.

```
sudo service salt-minion restart
```
Simikarly grains for a node can also be defined in a file at ```/etc/salt/minion.d/grains``` and the effect is the same. You will have to follow the YAML syntax neverthless.

## Custom Grain: Define and use

If you have followed the previous section then we have defined custom grain called roles and deployment on that node. We can validate the same on same node:

```$ sudo salt-call grains.item deployment roles
local:
    ----------
    deployment:
        datacenter4
    roles:
        - webserver
        - memcache
```

Now if we switch to master, we can use this custom grain for filtering etc. as we used built in grains:

```
$ sudo salt -G 'roles:webserver' test.ping
0.sagent.learn.com:
    True

$ sudo salt -G 'roles:memcache' test.ping
0.sagent.learn.com:
    True

$ sudo salt '0.sagent.learn.com' grains.item roles
0.sagent.learn.com:
    ----------
    roles:
        - webserver
        - memcache    
```
As you can note from above two commands, we queried on the grain which has a list of values and it matched even if one of the roles from the list matched the value we quried.


If a grain is set only on certain nodes, you will get blank value for other nodes for that grain:
```
$ sudo salt '*' grains.item deployment
0.sagent.learn.com:
    ----------
    deployment:
        datacenter4
1.sagent.learn.com:
    ----------
    deployment:
smaster.learn.com:
    ----------
    deployment:
```


# Quiz
TBD

|Previous                | Next              |
|------------------------|-------------------|
|[Targetting](../target) |[YAML](../yaml)    |