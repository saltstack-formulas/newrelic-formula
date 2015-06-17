newrelic-php:
  pkg.installed:
    - name: newrelic-php5

  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php5/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.license = .*'
    - repl: newrelic.license = "{{ salt['pillar.get']('newrelic:apikey', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php5

newrelic-files-folder:
  file.directory:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php5/mods-available
  {% endif %}
    - makedirs: True

newrelic-appname:
  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php5/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.appname = "PHP Application"'
    - repl: newrelic.appname = "{{ salt['pillar.get']('newrelic:appname', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php5

