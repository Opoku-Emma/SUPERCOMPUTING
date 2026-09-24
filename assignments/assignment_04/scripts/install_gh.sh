#!/bin/bash

# make folder if not already present
mkdir -p ~/programs

cd ~/programs

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

tar -xzvf gh_2.74*.tar.gz

# clean-up
rm gh_2.74*.tar.gz
