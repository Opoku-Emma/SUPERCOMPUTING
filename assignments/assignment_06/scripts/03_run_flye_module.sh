#!/bin/bash

set -ueo pipefail

# load module
module load Flye/gcc-11.4.1/2.9.6

# run assembly
flye --nano-hq data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_module/ --threads 2

cd ./assemblies/assembly_module/

# cleanup: list all items in assembly_local; find all files that
# neither end in .fasta or .log and remove them

echo "### --- Cleaning up --- ###"
ls | grep -vE '\.(fasta|log)$' | xargs -I {} rm -fr {}

# rename files
echo "### --- Renaming Files --- ###"
mv assembly.fasta module_assembly.fasta
mv flye.log module_flye.log

# go to previous directory (SUPERCOMPUTING/assignments/assignment_06)
cd -

echo "### --- Done --- ###"