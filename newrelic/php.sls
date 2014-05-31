newrelic-php:
  pkg.installed:
    - name: newrelic-php5

  file.managed:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/10-newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php5/apache/conf.d/10-newrelic.ini
  {% endif %}
    - content: newrelic.license="{{ salt['pillar.get']('newrelic:apikey', '') }}"
    - makedirs: True
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php5
