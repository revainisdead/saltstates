#!/bin/bash

# When pulling down on a master for the first time, move files
# from the git repo to the proper location.
cp /home/ubuntu/saltstates/* /srv/salt/
