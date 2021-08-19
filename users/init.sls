wheel:
    group.present

{% if grains['os'] == 'Ubuntu' %}
sudo:
    group.present
{% endif %}

# Alternate option requiring no password for sudo '%wheel ALL=(ALL) NOPASSWD:ALL'
/etc/sudoers:
    file.append:
        - text: |
            %wheel ALL=(ALL) ALL

# Linux Users
{% for username, user in salt['pillar.get']('users-data', {}).items() %}
user-{{ username }}:
    user.present:
        - name: {{ username }}
        - fullname: {{ user.fullname }}
        - password: {{ user.password }}
        - shell: /bin/bash
        - groups:
            - {{ user.default_group }}
            - wheel
            {% if grains['os'] == 'Ubuntu' %}
            - sudo
            {% endif %}
            - adm
            - lpadmin
            #- docker

{% if user.get('ssh_keys', []) %}
# Sets up .ssh/authorized-keys file for servers (ssh incoming to machine)
authorized-keys-christian:
    ssh_auth:
        - present
        - user: christian
        - names:
            {% for key in user.ssh_keys %}
            - {{ key }}
            {% endfor %}
{% endif %}

{% endfor %}

include:
    - users.christian

# vim: set ft=yaml:
