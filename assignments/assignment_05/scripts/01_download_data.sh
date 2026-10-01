#!/bin/bash
set -ueo pipefail

## --- Setting up project directory --- ##
cd ~/SUPERCOMPUTING/assignments/assignment_05/

mkdir -p scripts data/{raw,trimmed} log

## --- Downloading and extracting ---
# download file
wget -P data/raw https://gzahn.github.io/data/fastq_examples.tar

tar -xvf data/raw/*.tar

mv *.fastq.gz data/raw/.

rm data/raw/*.tar
