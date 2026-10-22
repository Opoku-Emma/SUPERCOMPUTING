#!/bin/bash
#SBATCH --job-name=download_data
#SBATCH --partition=gz
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=04:00:00
#SBATCH -o logs/download_%j.out
#SBATCH -e logs/download_%j.err

set -euo pipefail

# set up environment
module load miniforge3
conda activate sra-env

METADATA="./data/SraRunTable.csv"
# take the last 12 entries, excluding 'run' from it
ACCESSIONS=$(cut -d"," -f1 ${METADATA} | tail -12)
OUT_DIR="./data/raw"

for ACC in ${ACCESSIONS}; do
    fasterq-dump $ACC --format fastq \
         --temp "${TMPDIR:-/local/scr/$USER}" \
        --progress \
        --split-files \
        --outdir $OUT_DIR
done

## --- Code for installing datasets --- ##

datasets download genome taxon 9615 \
    --reference \
    --include genome \
    --filename ./data/dog_reference/dog_genome.zip

unzip -o ./data/dog_reference/dog_genome.zip -d ./data/dog_reference/

