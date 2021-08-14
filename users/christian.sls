# If extra configuration in init file that needs to be applied first
include:
    - users

christian-settings:
    git.latest:
        - name: https://github.com/revainisdead/settings.git
        - rev: master
        - target: /home/christian/bin/settings
        - user: christian
    cmd.wait:
        - name: /home/christian/bin/settings/init.sh
        - runas: christian
        #- watch:
            #- git: christian-settings

/home/christian/bin:
    file.directory:
        - user: christian
        - group: christian
        - dir_mode: 755
        - makedirs: False # Assume user (parent) directory exists, don't try to create
