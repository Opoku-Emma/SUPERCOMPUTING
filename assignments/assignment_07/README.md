# Assignment 07

## Task 1. Setup assignment_7/ directory

```bash
# just make sure I am in the right directory
cd /sciclone/scr10/eopoku/SUPERCOMPUTING/assignments/assignment_07/

touch assignment_7_pipeline.slurm

mkdir -p data/{raw,clean,dog_reference} output scripts logs
```

## Task 2. Download Sequence Data


Keywords used to search for genomic data on SRA
(((((metagenome) AND shotgun metagenome) AND paired end) AND illumina)) AND genome 

Metadata for the first 12 results were downloaded

Write a script that loops through the first column ("Run") and uses `fasterq-dump` to download the raw data from those accessions


I am hitting download errors because my home directory storage quota is being used up. I will switch to data10 or scr10
```bash
# !/bin/bash
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


```touch scripts/01_download_data.sh
