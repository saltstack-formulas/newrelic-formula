newrelic-sysmond:
  pkg:
    - installed

  file.replace:
    - name: /etc/newrelic/nrsysmond.cfg
    - pattern: "license_key=REPLACE_WITH_REAL_KEY"
    - repl: "license_key={{ salt['pillar.get']('newrelic:apikey', '') }}"
    - require:
        - pkg: newrelic-sysmond

  service.running:
    - reload: True
    - watch:
        - pkg: newrelic-sysmond
        - file: /etc/newrelic/nrsysmond.cfg
