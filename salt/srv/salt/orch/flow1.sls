redis_setup:
  salt.state:
    - tgt: 'roles:redis'
    - tgt_type: grain
    - highstate: True

redis_check_key:
  salt.state:
    - tgt: 'roles:redis'
    - tgt_type: grain
    - sls: redis_key_check

redis_insert_key:
  salt.function:
    - name: cmd.run
    - tgt: 'roles:redis'
    - tgt_type: grain
    - arg: 
        - 'redis-cli set key11 value11'
    - require:
      - salt: redis_check_key
