#!/bin/bash
set -ueo pipefail

## --- Download data --- ##
./scripts/01_download_data.sh

RAW_DATA=data/raw

echo "## --- Start Processing File --- ##" 

for R1 in $(ls $RAW_DATA/*_R1_*.fastq.gz); do
    ./scripts/02_run_fastp.sh $R1
done

echo "Done!"