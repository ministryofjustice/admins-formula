{% from "admins/map.jinja" import admins with context %}

include:
  - bootstrap.groups
  - bootstrap.sudo


{% for user, data in admins.iteritems() %}

{% if 'absent' in data and data['absent'] %}
admin-{{ user }}:
  user.absent

{% else %}
admin-{{ user }}:
  user.present:
    - name: {{ user }}
    - home: /home/{{ user }}
    - shell: /bin/bash
    - order: 1
    - groups:
      - wheel
      - supervisor
      - adm
      - root
    - require:
      - group: supervisor
      - group: wheel
  {% for key in data.get("public_keys", []) %}

admin-{{ user}}-key-{{ loop.index0 }}:
  ssh_auth.present:
    - name: {{ key['key'] }}
    - comment: {{ key['comment'] | default('') }}
    - user: {{ user }}
    - enc: {{ key['enc'] | default('ssh-rsa') }}
    - config: .ssh/authorized_keys2
    - order: 1
    - require:
      - user: admin-{{ user }}
  {% else %}
  ssh_auth.present:
    - name: {{ data['key'] }}
    - comment: {{ data['comment'] | default('') }}
    - user: {{ user }}
    - enc: {{ data['enc'] | default('ssh-rsa') }}
    - config: .ssh/authorized_keys2
    - order: 1
    - require:
      - user: admin-{{ user }}
  {% endfor %}
{% endif %}

{% endfor %}


