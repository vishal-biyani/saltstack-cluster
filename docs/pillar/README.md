
|Home          |Previous          | Next                                      |
|--------------|------------------|-------------------------------------------|
|[Home](../../)|[YAML](../yaml)   |[Directory Structure](../dir_structure)    |


# Pillar

Assuming you have already covered the grains module, grains is the information about the node which Salt discovers and provides you. There is another type of data - configuration data which is set by engineer/user on the Salt master and exposed to various nodes. This condiguration data is used during the execution of runbooks on nodes.

For example if you want to customize the 

## Defining Pillars

Pillars are defined in [YAML](../yaml) format in [state files](../sls) in pillar_roots directory (We will look at direction structure in next module). For example look at the pillar configuration for Redis below. We are using the YAML syntax to define the configuration data which is needed while installing Redis on a certain node.


```
/vagrant/salt/srv/pillar$ cat redis.sls 
redis:
  root_dir: /var/lib/redis
  user: redis
  port: 6379
  bind: 127.0.0.1
  snapshots:
    - '900 1'
    - '300 10'
    - '60  10000'
  lookup:
    svc_state: running
    cfg_name: /etc/redis.conf
    pkg_name: redis-server
    svc_name: redis-server
    overcommit_memory: True
```    

## Assign

The pillar data should be exposed to the nodes that need it. This way the data is available only on to nodes that need it and also is much more managable. To achieve this, we can use role based grain filter and only expose the desired pillar data to a set of nodes. For example:

```
  'G@roles:redis':
    - redis
```    

## Playing with Pillar

Show pillar items
Select a particular pillar item and subitem (apache:greetings)
How is pillar configured?
Change pillar value, refresh and validate new value




|Home          |Previous          | Next                                      |
|--------------|------------------|-------------------------------------------|
|[Home](../../)|[YAML](../yaml)   |[Directory Structure](../dir_structure)    |