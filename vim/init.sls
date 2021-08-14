vim:
    pkg.installed:
        - pkgs:
{% if grains['os'] == 'Ubuntu' %}
            #- vim-gnome     # for vim with clipboard support (old)
            - vim-gtk3      # for vim with clipboard support (new)
{% else %}
            - vim
{% endif %}

# Problem: created as root
#mkdir /home/christian/.vim/undo:
#    cmd.run:
#        - creates: /home/christian/.vim/undo
#        - require:
#            - pkg: vim

/home/christian/.vim/undo:
    file.directory:
        - user: christian
        - group: christian
        - dir_mode: 755
        - makedirs: True # Will create .vim (parent) directory in the same manner if doesn't exist
        - require:
            - pkg: vim
