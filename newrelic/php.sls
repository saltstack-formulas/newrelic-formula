newrelic-php:
  pkg.installed:
    - name: newrelic-php5

  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php5/apache2/conf.d/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.license = .*'
    - repl: newrelic.license = "{{ salt['pillar.get']('newrelic:apikey', '') }}"
    - makedirs: True
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php5
