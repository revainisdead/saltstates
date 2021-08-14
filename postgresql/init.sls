# Replace /etc/postgresql/* with version name (ex. 9.3, 12) to target
# and install specific version and config file, otherwise install latest

postgresql:
    pkg.installed:
        - name:
            postgresql

postgresql_up:
    service:
        - name: postgresql
        - running
        #- reload: True
        - require:
            - pkg: postgresql
        #    - file: '/etc/postgresql/*/main/postgresql.conf'
        #- watch:
        #    - file: '/etc/postgresql/*/main/postgresql.conf'

pg_user-gtpaper:
    postgres_user.present:
        - name: gtpaper
        - password: gtpaper
        - superuser: True # Assuming this is the same as "GRANT ALL PRIVILEGES ON DATABASE ..."
        - user: postgres # Utilize default postgres user as the acting user for creation

# vim: set ft=yaml:
