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

exclude_on_copy="install.sh collect.sh yaml_tag_add_all.sh salt"
#exclude_on_copy=$(git ls-files *.sh)

# Gives the ability to call the script from another directory, this
# will move the current directory
pushd $(dirname $0) > /dev/null
SCRIPT_PATH=$(pwd -P)
popd > /dev/null # return to original directory calling script from

for path in $SCRIPT_PATH/*
do
    pathbase=`basename $path`
    if [[ ! $exclude_on_copy =~ $pathbase ]]; then

        if [ $pathbase == "pillar-example" ]; then
            echo [Special case for pillar-example, move its data to /srv/pillar]
            echo Copied $pathbase to /srv/pillar

            if [ ! -d /srv/pillar ]; then
                sudo mkdir /srv/pillar/
            fi

            # Copy all files from inside pillar-example to /srv/pillar
            sudo cp -r $pathbase/* /srv/pillar/
        else
            # What if original path changed? It will create new, duplicate file
            # at the new name
            echo Copied $pathbase to /srv/salt
            sudo cp -r $pathbase /srv/salt/
        fi
    fi
done

# The files from pillar-example will already be in /srv/pillar, change data there
pillar_path=/srv/pillar
data_path="${pillar_path}/data.sls"
real_data_path="${pillar_path}/real-data.sls"

# After everything is moved, overwrite data.sls placeholder data
if [ -f $real_data_path ]; then
    # Overwrite data.sls with contents of real-data.sls, name as data.sls
    echo Success: Overwriting placeholder data.sls with real-data.sls.
    sudo mv $real_data_path $data_path
else
    echo Required file does not exist $real_data_path
fi
