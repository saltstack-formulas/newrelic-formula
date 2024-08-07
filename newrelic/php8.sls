

newrelic-php:
  pkg.installed:
    - name: newrelic-php5

  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.license = .*'
    - repl: newrelic.license = "{{ salt['pillar.get']('newrelic:apikey', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

newrelic-files-folder:
  file.directory:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available
  {% endif %}
    - makedirs: True

newrelic-appname:
  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.appname = "PHP Application"'
    - repl: newrelic.appname = "{{ salt['pillar.get']('newrelic:appname', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

newrelic-explain_uncomment:
  file.uncomment:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - regex: ^newrelic.transaction_tracer.explain_enabled
    - char : ;

newrelic-explain_enabled:
  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.transaction_tracer.explain_enabled = .*'
    - repl: newrelic.transaction_tracer.explain_enabled = {{ salt['pillar.get']('newrelic:explain_enable', 'true') }}
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

newrelic-span_events_uncomment:
  file.uncomment:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - regex: ^newrelic.span_events_enabled
    - char : ;

newrelic-newrelic.span_events_enabled:
  file.replace:
  {% if grains['os_family'] == 'RedHat' %}
    - name: /etc/php.d/newrelic.ini
  {% elif grains['os_family'] == 'Debian' %}
    - name: /etc/php/8.2/mods-available/newrelic.ini
  {% endif %}
    - pattern: 'newrelic.span_events_enabled = .*'
    - repl: newrelic.span_events_enabled = {{ salt['pillar.get']('newrelic:span_events_enabled', 'true') }}
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

