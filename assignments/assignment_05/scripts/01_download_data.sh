#!/bin/bash
set -ueo pipefail

## --- Setting up project directory --- ##
cd ~/SUPERCOMPUTING/assignments/assignment_05/

mkdir -p scripts data/{raw,trimmed} log

## --- Downloading and extracting ---
# download file
wget -P data/raw https://gzahn.github.io/data/fastq_examples.tar

# Extracts the contents
tar -xvf data/raw/*.tar

# Puts all the fastq files into ./data/raw/
mv *.fastq.gz data/raw/.

# Cleans up the `fastq_examples.tar` file
rm data/raw/*.tar