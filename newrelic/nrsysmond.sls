newrelic-sysmond:
  pkg:
    - installed

  file.append:
    - name: /etc/newrelic/nrsysmond.cfg
    - text: "license_key: {{ salt['pillar.get']('newrelic:apikey', '') }}"
    - require:
        - pkg: newrelic-sysmond

  service.running:
    - reload: True
    - watch:
        - pkg: newrelic-sysmond
        - file: /etc/newrelic/nrsysmond.cfg
