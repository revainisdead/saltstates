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
