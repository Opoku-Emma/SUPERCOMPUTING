#!/bin/bash
set -ueo pipefail

# go to programs directory
cd ~/programs

## --- Instructions from seqtk github repo
git clone https://github.com/lh3/seqtk.git

cd seqtk

make

echo 'export PATH=$PATH:/sciclone/home/eopoku/programs/seqtk/' >> ~/.bashrc
