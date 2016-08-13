Role Name
=========

This role can be used to install and manage [BIND](https://www.isc.org/downloads/bind/), a DNS server. Unlike the other BIND roles for Ansible out there, this one allows the use of Jinja templates for the zone DB files, rather than just copying the files over without allowing any modification. This is useful in a number of cases, but particularly in tests.

![Travis CI Build Status](https://travis-ci.org/karlmdavis/ansible-tested-bind.svg)

Requirements
------------

This role supports Ansible 2 and later on the development system, and requires Ubuntu Server 16.04 on systems that the role is applied to.

Role Variables
--------------

This role can be configured by altering the variables listed in this section. See [defaults/main.yml](defaults/main.yml) for information on what the default vaules for these are.

The primary configuration variable is the `zones` list. It specifies the zones that will be served by BIND, as well as the source [template files](http://docs.ansible.com/ansible/template_module.html) that will be used to create the zone DB files.

```
zones:
  - {name: 'foo.com', template_source: 'db.foo.com.j2'}
  - {name: 'bar.com', template_source: 'db.bar.com.j2'}
```

Dependencies
------------

This role does not have dependencies on other Ansible roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

[GPL v3](./LICENSE)

Author Information
------------------

This plugin was authored by Karl M. Davis (https://justdavis.com/karl/).

