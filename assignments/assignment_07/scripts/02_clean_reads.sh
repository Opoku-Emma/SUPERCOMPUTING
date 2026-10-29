#!/bin/bash
#SBATCH --job-name=clean_reads
#SBATCH --partition=gz
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --time=04:00:00
#SBATCH -o logs/clean_reads_%j.out
#SBATCH -e logs/clean_reads_%j.err

set -ueo pipefail

# set up environment
module load miniforge3/
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate fastp-env

RAW_DIR="./data/raw"

for R1 in $(ls ${RAW_DIR}/*_1.fastq); do 

    FWD_IN=$R1
    REV_IN=${FWD_IN/_1/_2}

    FWD_OUT=data/clean/$(basename ${FWD_IN/.fastq/.trimmed.fastq})
    REV_OUT=data/clean/$(basename ${REV_IN/.fastq/.trimmed.fastq})

    echo "Forward Read:" $FWD_IN 
    echo "Reverse Read:" $REV_IN
    echo "Forward Read Out:" $FWD_OUT 
    echo "Reverse Read Out:" $REV_OUT
    echo "## --- Processing --- ##"

    LOG=logs/$(basename ${FWD_IN/_1*.fastq//})
    echo $LOG

    ## --- Reused from previous assignment --- ##########################
    fastp --in1 "$FWD_IN" --in2 "$REV_IN" --out1 "$FWD_OUT" --out2 "$REV_OUT" \
        --json /dev/null \
        --html /dev/null \
        --trim_front1 8 \
        --trim_front2 8 \
        --trim_tail1 20 \
        --trim_tail2 20 \
        --n_base_limit 0 \
        --length_required 100 \
        --average_qual 20 \
        --thread $SLURM_CPUS_PER_TASK \
        > "$LOG.out" 2>&1
done


