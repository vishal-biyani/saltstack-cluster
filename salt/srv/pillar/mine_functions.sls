mine_functions:
  network.ip_addrs: [eth1]
  grains.item: [roles]
  test:
      - mine_function: grains.item
      - fqdn