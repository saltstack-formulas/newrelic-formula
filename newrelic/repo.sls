newrelic-repo:
  {% if grains['os_family'] == 'RedHat' %}
  pkg.installed:
    - sources: 
      - newrelic-repo: http://yum.newrelic.com/pub/newrelic/el5/i386/newrelic-repo-5-3.noarch.rpm
  {% elif grains['os_family'] == 'Debian' %}
  pkgrepo.managed:
    - humanname: newrelic-repo
    - name: deb http://apt.newrelic.com/debian/ newrelic non-free
    - keyid: 548C16BF
    - keyserver: keyserver.ubuntu.com
    - dist: {{ grains['oscodename'] }}
  {% endif %}
    - require_in:
        - pkg: newrelic-php5
        - pkg: newrelic-sysmond
