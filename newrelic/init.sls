include:
  - .repo
  {% if salt['pkg.list_pkgs']().get('php5', False) -%}
  - .daemon
  - .php
  {% endif %}
  - .nrsysmond
