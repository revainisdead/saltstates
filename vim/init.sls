vim:
    pkg.installed:
        - pkgs:
{% if grains['os'] == 'Ubuntu' %}
            #- vim-gnome     # for vim with clipboard support (old)
            - vim-gtk3      # for vim with clipboard support (new)
{% else %}
            - vim
{% endif %}

mkdir /home/christian/.vim/undo:
    cmd.run:
        - creates: /home/christian/.vim/undo
        - runas: christian
        - require:
            - pkg: vim

###
# Pathogen Setup
###

/home/christian/.vim/autoload:
    file.directory:
        - user: christian
        - group: christian
        - dir_mode: 755
        - makedirs: False # Don't auto create .vim (parent) folder, install vim for that
        - require:
            - pkg: vim

# Download pathogen.vim into autoload
curl -LSso /home/christian/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim:
    cmd.run:
        - creates: /home/christian/.vim/autoload/pathogen.vim
        - require:
            - pkg: vim

###
# Vim Plugins
###

plugin-vim-coffee-script-repo:
    git.latest:
        - name: git@github.com:kchmck/vim-coffee-script
        - rev: master
        - target: /home/christian/.vim/bundle/vim-coffee-script
        - user: christian

plugin-vim-stylus-repo:
    git.latest:
        - name: git@github.com:wavded/vim-stylus
        - rev: master
        - target: /home/christian/.vim/bundle/vim-stylus
        - user: christian

plugin-supertab-repo:
    git.latest:
        - name: git@github.com:ervandew/supertab
        - rev: master
        - target: /home/christian/.vim/bundle/supertab
        - user: christian

plugin-vim-commentary-repo:
    git.latest:
        - name: git@github.com:tpope/vim-commentary.git
        - rev: master
        - target: /home/christian/.vim/bundle/vim-commentary
        - user: christian

# vim: set ft=yaml:
