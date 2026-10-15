#!/bin/bash

set -ueo pipefail

# I have already added the local build of flye to $PATH
export PATH=\$PATH:${FLYE_PATH} >> ~/.bashrc
# run assembly
flye --nano-hq data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_local/ --threads 20 

cd ./assemblies/assembly_local/

# cleanup: list all items in assembly_local; find all files that
# neither end in .fasta or .log and remove them

echo "### --- Cleaning up --- ###"
ls | grep -vE '\.(fasta|log)$' | xargs -I {} rm -fr {}

# rename files
echo "### --- Renaming Files --- ###"
mv assembly.fasta local_assembly.fasta
mv flye.log local_flye.log

# go to previous directory (SUPERCOMPUTING/assignments/assignment_06)
cd -

echo "### --- Done --- ###"