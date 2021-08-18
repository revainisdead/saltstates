#!/bin/bash

# Description
# ---
# When pulling down on a master for the first time, move files
# from the git repo to the proper location.
# (Or, for developing in repo, and moving updated files to salt master)

set -e
# Code that will STOP script on a non-zero (non-successful) exit code
set +e
# Code that will NOT stop script on a non-zero exit code

set -e

exclude_on_copy="install.sh collect.sh"

# Gives the ability to call the script from another directory, this
# will move the current directory
pushd $(dirname $0) > /dev/null
SCRIPT_PATH=$(pwd -P)
popd > /dev/null # return to original directory calling script from

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
