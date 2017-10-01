Ansible Role for BIND DNS
=========================

This role can be used to install and manage [BIND](https://www.isc.org/downloads/bind/), a DNS server. Unlike the other BIND roles for Ansible out there, this one allows the use of Jinja templates for the zone DB files, rather than just copying the files over without allowing any modification. This is useful in a number of cases, but particularly in tests.

[![Build Status](https://travis-ci.org/karlmdavis/ansible-bind-dns.svg?branch=master)](https://travis-ci.org/karlmdavis/ansible-bind-dns)

Requirements
------------

This role supports Ansible 2.4.0.0 and later on the development system, and requires Ubuntu Server 14.04 or 16.04 on systems that the role is applied to.

Role Variables
--------------

This role can be configured by altering the variables listed in this section. See [defaults/main.yml](defaults/main.yml) for information on what the default vaules for these are.

The primary configuration variable is the `zones` list. It specifies the zones that will be served by BIND, as well as the source [template files](http://docs.ansible.com/ansible/template_module.html) that will be used to create the zone DB files.

```
zones:
  - {name: 'example.com', template_source: 'templates/db.example.com.j2'}
  - {name: 'example.net', template_source: 'templates/db.example.net.j2'}
```

The `forwarders` variable specifies which servers (if any) will be used to resolve queries for which the server is not authoritative.

```
forwarders:
  - 192.0.2.1
  - 203.0.113.1
```

The `zone_transfer_peers` variable specifies which other DNS servers (if any) will be allowed to perform zone transfers against this. This should be set to include any secondary name servers for the domains that are included.

```
zone_transfer_peers:
  - 192.0.2.2
  - 203.0.113.2
```

Dependencies
------------

This role does not have dependencies on other Ansible roles.

Example Playbook
----------------

This role can be included as follows:

```
    - hosts: somebox
      tasks:
        - import_role:
            name: karlmdavis.bind-dns
          vars:
            zones:
              - {name: 'example.com', template_source: 'templates/db.example.com.j2'}
            forwarders:
              - 192.0.2.1
              - 203.0.113.1 
            zone_transfer_peers:
              - 192.0.2.2
              - 203.0.113.2
```

License
-------

[GPL v3](./LICENSE)

Author Information
------------------

This plugin was authored by Karl M. Davis (https://justdavis.com/karl/).

