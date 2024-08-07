include:
  - .repo
  {% if salt['pkg.list_pkgs']().get('php5', False) -%}
  - .daemon
  - .php
  {% elif salt['pkg.list_pkgs']().get('php7.0', False) -%}
  - .daemon
  - .php7
  {% elif salt['pkg.list_pkgs']().get('php8.2-common', False) -%}
  - .daemon
  - .php8
  {% endif %}
