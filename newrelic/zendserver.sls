# This extends the NewRelic formula with support for Zend Server's alternative setup
include:
  - newrelic.daemon
  - newrelic.php

# Copy the library library file
/usr/local/zend/lib/php_extensions/newrelic.so:
  file.copy:
    - source: /usr/lib/newrelic-php5/agent/x64/newrelic-{{ salt['pillar.get']('newrelic:php_api_version', '20121212')}}.so
    - mode: 755
    - require:
      - pkg: newrelic-php5
    - watch_in:
      - service: php5-fpm

# Copy template to new location since it hasn't been installed by the installer
/usr/local/zend/etc/conf.d/newrelic.ini:
  file.copy:
    - source: /usr/lib/newrelic-php5/scripts/newrelic.ini.template
    - require:
      - pkg: newrelic-php5

# Make sure the name/key is set written to the correct file
extend:
  newrelic-php:
    file.replace:
      - name: /usr/local/zend/etc/conf.d/newrelic.ini
      - watch_in:
        - service: php5-fpm
  newrelic-appname:
    file.replace:
      - name: /usr/local/zend/etc/conf.d/newrelic.ini
      - watch_in:
        - service: php5-fpm
