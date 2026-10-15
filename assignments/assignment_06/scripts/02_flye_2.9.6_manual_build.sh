#!/bin/bash

# go to programs directory
mkdir -p ~/programs & cd ~/programs

git clone https://github.com/fenderglass/Flye
cd Flye
make

# add flye binaries to $PATH
FLYE_PATH=$(realpath bin/)
echo "export PATH=\$PATH:${FLYE_PATH}" >> ~/.bashrc

exec bash
