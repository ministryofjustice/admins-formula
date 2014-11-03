admins-formula
==============

Default Behaviour
=================

By default this state will create admin users as determined by admin users defined in the 'admins' pillar. 

for each user defined in the ``admins`` pillar dict:

 - create the user account
 - create entires in .ssh/authorized_keys2
 - add user to wheel group (to sudo w/o password)

*or*:

 - remove the account if ``absent`` is in the pillar structure


example::

    admins:
      username:
        # Old format with just a single ssh public key
        key: your_key
        comment: your key_name, comment
        enc: ssh-rsa
      jobloggs:
        # New format with multiple keys
        public_keys:
          - key: AAAAB3n....=
            enc: ssh-rsa
            comment: oncall-laptop-1.local
          - key: AAAAB3n....=
            enc: ssh-rsa
            comment: dekstop2.jo.local
      rogue:
        absent: True

Ad-hoc admin groups
===================

Additional groups of admins may be specified and applied ad-hoc.

for example, for each user defined in the ``my_adhoc_admins`` pillar dict:

example::

    my_adhoc_admins:
      username:
        # Old format with just a single ssh public key
        key: your_key
        comment: your key_name, comment
        enc: ssh-rsa
      jobloggs:
        # New format with multiple keys
        public_keys:
          - key: AAAAB3n....=
            enc: ssh-rsa
            comment: oncall-laptop-1.local
          - key: AAAAB3n....=
            enc: ssh-rsa
            comment: dekstop2.jo.local
      rogue:
        absent: True

The above can be applied by invoking the following state.sls call:

> salt-call state.sls admins pillar='{ alternate_admins: \"my_adhoc_admins\" }'"

