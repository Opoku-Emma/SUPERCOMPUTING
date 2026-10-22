#!/bin/bash

cd ~/SUPERCOMPUTING/assignments/assignment_07/

touch assignment_7_pipeline.slurm

mkdir -p data/{raw,clean,dog_reference} output scripts

# Task 2
# set up environment
module load miniforge3

mamba create -y -n sra-env -c bioconda sra-tools
conda activate sratoolkit-env