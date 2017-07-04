base:
  'G@roles:apache':
    - beacon
    - apache
  '0':
    - haproxy
  '*':
    - mine_functions
  'G@roles:redis':
    - redis
    - redis_beacon