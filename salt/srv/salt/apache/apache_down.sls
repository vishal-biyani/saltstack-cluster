{% if data['apache2']['running'] == false %}
start_apache2:
  local.cmd.run:
    - tgt: "{{ data['id'] }}"
    - arg:
      - sudo service apache2 start
{% endif %}