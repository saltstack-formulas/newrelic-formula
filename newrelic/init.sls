include:
  - .repo
  {% if salt['pkg.list_pkgs']().get('php', False) -%}
  - .daemon
  - .php
  {% endif %}
  - .nrsysmond
