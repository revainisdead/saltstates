# Installing Opera https://linuxconfig.org/how-to-install-opera-web-browser-on-linux
#
# `sudo apt purge opera-stable` to test installing it again
opera:
    #cmd.run:
    #    - name: wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -

    pkgrepo.managed:
        - name: deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free
        - key_url: https://deb.opera.com/archive.key
        - require_in:
            - pkg: opera-stable

    pkg.installed:
        - name: opera-stable # package name
        - require:
            - pkgrepo: opera # refers to ID

# vim: set ft=yaml:
