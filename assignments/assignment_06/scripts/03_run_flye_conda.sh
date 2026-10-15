#!/bin/bash

set -ueo pipefail

# load module
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# activate environment
conda activate flye-env

# run assembly
flye --nano-hq data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_conda/ --threads 20 

cd ./assemblies/assembly_conda/

# cleanup: list all items in assembly_conda; find all files that
# neither end in .fasta or .log and remove them

echo "### --- Cleaning up --- ###"
ls | grep -vE '\.(fasta|log)$' | xargs -I {} rm -fr {}

# rename files
echo "### --- Renaming Files --- ###"
mv assembly.fasta conda_assembly.fasta
mv flye.log conda_flye.log

# go to previous directory (SUPERCOMPUTING/assignments/assignment_06)
cd -

conda deactivate
echo "### --- Done --- ###"