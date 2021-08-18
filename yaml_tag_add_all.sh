#!/bin/bash

# For every .sls file, add vim yaml filetype tag to end of file.
# (If it isn't already there.)

set -e

pushd $(dirname $0) > /dev/null
SCRIPT_PATH=$(pwd -P)
popd > /dev/null

for path in $(git ls-files -- "*.sls")
do
    vim_tag='# vim: set ft=yaml:' # string literal
    last_line=$(tail -1 $path)

    if [ "$last_line" != "$vim_tag" ]; then
        echo Added tag. $path
        echo -e "\n${vim_tag}" >> $path
    else
        echo "Tag already exists: ${path}"
    fi
done
