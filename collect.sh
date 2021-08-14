#!/bin/bash

# Move all files from the current salt master location to
# the git repo so push up changes.
cp -r /srv/salt/* /home/ubuntu/saltstates/
