#!/bin/bash

cd ~/SUPERCOMPUTING/assignments/assignment_07/

mkdir -p data/{raw,clean,dog_reference} output scripts logs

# Task 2
# set up environment
module load miniforge3
# mamba create -y -n sra-env -c bioconda sra-tools
# conda activate sratoolkit-env

# https://docs.ncsa.illinois.edu/en/latest/common/slurm/dependencies-constraints.html
# JOB_01=`sbatch jobscript1.sbatch |cut -f 4 -d " "`
# JOB_02=`sbatch --dependency=afterany:$JOB_01 jobscript2.sbatch |cut -f 4 -d " "`
# JOB_03=`sbatch --dependency=afterany:$JOB_02 jobscript3.sbatch |cut -f 4 -d " "`

## download data
JOB_01=$(sbatch ./scripts/01_download_data.sh | cut -f 4 -d " ")

# Task 3
# set up fastp environment
# mamba create -y -n fastp-env -c bioconda fastp
## --- clean reads --- ####
JOB_02=$(sbatch --dependency=afterok:$JOB_01 ./scripts/02_clean_reads.sh | cut -f 4 -d " ")

echo "## --- Processing Done --- ##"

# Install bbmap for this step
# mamba create -y -n bbmap-env -c bioconda bbmap

## --- Map reads and count them
JOB_03=$(sbatch --dependenvy=afterok:$JOB_02 ./scripts/03_map_reads.sh  | cut -f 4 -d " ")