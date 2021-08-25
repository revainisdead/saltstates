git:
    pkgrepo.managed:
        - ppa: git-core/ppa
    pkg.installed:
        - pkgs:
            - git
        - require:
            - pkgrepo: git

# vim: set ft=yaml:
