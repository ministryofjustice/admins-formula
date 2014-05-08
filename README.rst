admins-formula
==============
for each user defined in pillars:
 - create his account
 - upload his ssh key
 - add him to wheel (to sudo w/o password)
 - or remove him


example::

    admins:
      username:
        key: your_key
        comment: your key_name, comment
        enc: ssh-rsa
      rogue:
        absent: True
