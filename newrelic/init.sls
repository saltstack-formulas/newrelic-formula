include:
  - .repo
  {%- set pkgs = salt['pkg.list_pkgs']() -%}
  {%- if 'php5' in pkgs or 'php5-fpm' in pkgs or 'php5-common' in pkgs or 'php56-common' in pkgs %}
  - .php
  {%- endif %}
  - .nrsysmond
