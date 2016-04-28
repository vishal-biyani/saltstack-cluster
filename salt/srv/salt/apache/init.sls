install-apache:
  pkg.installed:
    - name: apache2

run apache:
  service.running:
    - name: apache2

/var/www/html/index.html:
  file.managed:
    - source: salt://{{ sls }}/files/index.html.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - watch_in:
        - service: apache2
