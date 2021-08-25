git:
    pkgrepo.managed:
        - ppa: git-core/ppa
        - file: /etc/apt/sources.list.d/git-core-ubuntu-ppa-focal.list

    pkg.installed:
        - pkgs:
            - git           # Ensures git installs
        - require:
            - pkgrepo: git  # Ensures git install after repo is set up

# vim: set ft=yaml:
