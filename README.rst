=====
newrelic
=====

Formula to configure newrelic via pillar.


.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``newrelic``
---------

Configure newrelic-sysmond and newrelic-php5 packages to work with your php
application.

``newrelic.zendserver``
---------

This optional state **supplements** the ``newrelic`` state which makes it
possible to use NewRelic together with Zend Server and (optionally) the `ZendServer Formula
<https://github.com/saltstack-formulas/zendserver-formula>`_.

To use this, both the `newrelic` and the `newrelic.zendserver` states must be
included.

If you have a different "PHP API" version you can add this to the NewRelic
pillar (key: php_api_version). This defaults to `20121212`.
