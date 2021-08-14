#!/bin/bash

# When pulling down on a master for the first time, move files
# from the git repo to the proper location.
# (Or, for developing in repo, and moving updated files to salt master)
cp /home/ubuntu/saltstates/* /srv/salt/
