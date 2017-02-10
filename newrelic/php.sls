include:
  - newrelic.repo

newrelic-php:
  pkg.installed:
    - name: newrelic-php5
    - require:
      - sls: newrelic.repo

/etc/newrelic/newrelic.cfg:
  file.copy:
    - source: /etc/newrelic/newrelic.cfg.template
    - user: root
    - group: root
    - mode: 0640
    - require:
        - pkg: newrelic-php

newrelic-daemon:
  service.running:
    - enable: True
    - full_restart: True
    - require:
        - file: /etc/newrelic/newrelic.cfg

{% for file in salt['cmd.run']('find /etc/php* | grep newrelic.ini').splitlines() %}

{{ file }}:
  file.replace:
    - pattern: 'newrelic.license = .*'
    - repl: newrelic.license = "{{ salt['pillar.get']('newrelic:apikey', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

{{ file }}:
  file.replace:
    - pattern: 'newrelic.appname = "PHP Application"'
    - repl: newrelic.appname = "{{ salt['pillar.get']('newrelic:appname', '') }}"
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

{{ file }}:
  file.uncomment:
    - regex: ^newrelic.transaction_tracer.explain_enabled
    - char : ;

{{ file }}:
  file.replace:
    - pattern: 'newrelic.transaction_tracer.explain_enabled = .*'
    - repl: newrelic.transaction_tracer.explain_enabled = {{ salt['pillar.get']('newrelic:explain_enable', 'true') }}
    - watch_in:
        - service: newrelic-daemon
    - require:
        - pkg: newrelic-php

{% endfor %}