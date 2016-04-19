newrelic-sysmond:
  pkg:
    - installed

  # comment out the default
  Non Target sudo:
  file.comment:
    - name: /etc/newrelic/nrsysmond.cfg
    - regex: ^license_key=REPLACE_WITH_REAL_KEY
    
  file.blockreplace:
    - name: /etc/newrelic/nrsysmond.cfg
    - marker_start: '#-- salt managed license key zone --'
    - marker_end: '#-- end salt managed license key --'
    - content: license_key={{ salt['pillar.get']('newrelic:apikey', '') }}
    - require:
        - pkg: newrelic-sysmond

  service.running:
    - reload: True
    - watch:
        - pkg: newrelic-sysmond
        - file: /etc/newrelic/nrsysmond.cfg
