# Install docker from docker repositories
# ---
# https://docs.docker.com/engine/install/ubuntu

# "python-software-properties" Note
# ---
# https://docs.saltproject.io/en/latest/ref/states/all/salt.states.pkgrepo.html

# Example to create docker repository source manually (without pkgrepo.managed)
#echo \
#  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#    cmd.run:
#        - creates: /etc/apt/sources.list.d/docker.list
#        - user: root
#        - group: root
#        - mode: 644
#        - require:
#            - name:
#                - lsb_release

# Another example: But create the file first and put it on the salt master (salt://some_folder/docker.list)
#/etc/apt/sources.list.d/docker.list
#    file.managed:
#        - source: salt://sources/docker.list
#        - user: root
#        - group: root
#        - mode: 644

docker-prerequisites:
    pkg.installed:
        - names:
            # Repository, gpg, and https stuff
            - apt-transport-https
            - ca-certificates
            - gnupg
            - lsb-release
{% if grains['os'] == 'Ubuntu' %}
            - software-properties-common # Work with PPA repositories better on Ubuntu
{% endif %}

docker:
    pkgrepo.managed:
        - name: deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu {{salt['grains.get']('oscodename', 'focal')}} stable
        - file: /etc/apt/sources.list.d/docker.list
        - key_url: https://download.docker.com/linux/ubuntu/gpg

    # Need to install these packages first
    pkg.installed:
        - names:
            # Docker packages
            - docker-ce
            - docker-ce-cli
            - containerd.io
        #- require:
        #    - pkg: docker-prerequisites
        #    - pkgrepo: docker

# vim: set ft=yaml:
