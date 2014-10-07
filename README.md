Riemann Cookbook
================

Installs a Riemann server or dashboard

Requirements
------------

### Platform:

* Centos (>= 6.4)

### Cookbooks:

* java
* yum-epel

Attributes
----------

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['riemann']['server']['version']</code></td>
    <td>Riemann server version to install</td>
    <td><code>0.2.6</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['server']['user']</code></td>
    <td>Name of the riemann server system user</td>
    <td><code>riemann</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['server']['home']</code></td>
    <td>Home directory for the riemann server user</td>
    <td><code>/var/lib/riemann</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['server']['config_directory']</code></td>
    <td>Where to put riemann.config. Should not be modified but can be useful for external cookbook to put a custom riemann.config</td>
    <td><code>/etc/riemann</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['server']['bind_ip']</code></td>
    <td>The IP address to bind riemann server on</td>
    <td><code>0.0.0.0</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['dashboard']['port']</code></td>
    <td></td>
    <td><code>4567</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['dashboard']['bind_ip']</code></td>
    <td></td>
    <td><code>0.0.0.0</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['dashboard']['user']</code></td>
    <td>Riemann dashboard system user name</td>
    <td><code>riemann-dash</code></td>
  </tr>
  <tr>
    <td><code>node['riemann']['dashboard']['home']</code></td>
    <td>The place where the riemann-dash bundle and configuration will be installed.</td>
    <td><code>/var/lib/riemann-dash</code></td>
  </tr>
</table>

Recipes
-------

### riemann::server

Riemann server

### riemann::dashboard

Riemann dashboard


License and Author
------------------

Author:: criteo (<f.visconte@criteo.com>)

Copyright:: 2014, criteo

License:: Apache v2.0

