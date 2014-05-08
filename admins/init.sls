{% from "admins/map.jinja" import admins with context %}

include:
  - bootstrap.groups
  - bootstrap.sudo


{% for user, data in admins.iteritems() %}

{% if 'absent' in data and data['absent'] %}
admin-{{ user }}:
  user:
    - absent

{% else %}
admin-{{ user }}:
  user:
    - present
    - name: {{ user }}
    - home: /home/{{ user }}
    - shell: /bin/bash
    - order: 1
    - groups:
      - wheel
      - supervisor
    - require:
      - group: supervisor
      - group: wheel
  ssh_auth:
    - present
    - name: {{ data['key'] }}
    - comment: {{ data['comment'] }}
    - user: {{ user }}
    - enc: {{ data['enc'] }}
    - config: .ssh/authorized_keys2
    - order: 1
    - require:
      - user: admin-{{ user }}
{% endif %}

{% endfor %}


