#!/bin/bash

# Description
# ---
# When pulling down on a master for the first time, move files
# from the git repo to the proper location.
# (Or, for developing in repo, and moving updated files to salt master)

exclude_on_copy="install.sh collect.sh"

# Gives the ability to call the script from another directory, this
# will move the current directory aka the location of the script
pushd $(dirname $0)
SCRIPT_PATH=$(pwd -P)

# Path because could be file or directory
for path in $SCRIPT_PATH/*
do
    pathbase=`basename $path`
    if [[ ! $exclude_on_copy =~ $pathbase ]]; then
        echo $pathbase
        # What if original path changed? It will create new, duplicate file
        # at the new name
        sudo cp -r $pathbase /srv/salt/
    fi
done
