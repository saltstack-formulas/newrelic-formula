include:
  - .repo
  {%- set pkgs = salt['pkg.list_pkgs']() -%}
  {% if pkgs.php5 or pkgs.php5-fpm or pkgs.php5-common or pkgs.php56-common -%}
  - .php
  {% endif %}
  - .nrsysmond
