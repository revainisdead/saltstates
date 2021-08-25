peek:
    pkgrepo.managed:
        - name: ppa:peek-developers/stable
        - dist: stable
        - file: /etc/apt/sources.list.d/peek-developers-ubuntu-stable-{{salt['grains.get']('oscodename', 'focal')}}.list

    pkg.installed:
        - fromrepo: ppa:peek-developers/stable

# vim: set ft=yaml:
