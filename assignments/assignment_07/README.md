dewedffd# Assignment 07

## Task 1. Setup assignment_7/ directory

```bash
# just make sure I am in the right directory
cd /sciclone/scr10/eopoku/SUPERCOMPUTING/assignments/assignment_07/

touch assignment_7_pipeline.slurm
chmod a+x assignment_7_pipeline.slurm

mkdir -p data/{raw,clean,dog_reference} output scripts logs

touch scripts/01_download_data.sh
touch scripts/02_clean_reads.sh
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

```


## Task 3. Clean up raw reads

this is the loop that processes each of the raw reads we downloaded

```bash
# Task 3
## --- clean reads --- ####
# loop through all files in data/raw that are forward reads,
# pass them to the clean_reads script
# clean_reads script finds the matching reverse read and cleans both
for R1 in $(ls ./data/raw/*_1.fastq); do 
    echo "## --- Processing ${R1} --- ##"
    sbatch ./scripts/02_clean_reads.sh ${R1}
done

echo "## --- Processing Done --- ##
```

```bash
#!/bin/bash
#SBATCH --job-name=clean_reads
#SBATCH --partition=gz
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --time=04:00:00
#SBATCH -o logs/clean_reads_%j.out
#SBATCH -e logs/clean_reads_%j.err

set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_1/_2}

FWD_OUT=data/clean/$(basename ${FWD_IN/.fastq/.trimmed.fastq})
REV_OUT=data/clean/$(basename ${REV_IN/.fastq/.trimmed.fastq})

echo "Forward Read:" $FWD_IN 
echo "Reverse Read:" $REV_IN
echo "Forward Read Out:" $FWD_OUT 
echo "Reverse Read Out:" $REV_OUT

LOG=logs/$(basename ${FWD_IN/_R1*.fastq/})
HTML_LOG=${LOG}.html
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
    --thread 20 \
    > "$LOG.out" 2>&1
```

## Task 4. Map clean reads to dog genome

```bash
touch scripts/03_map_reads.sh
chmod a+x scripts/03_map_reads.sh
```

## Task 5. Extract reads that matched dog genome

## Task 6. Submit your job to SLURM

## Task 7. Inspect your stdout and stderr

## Task 8. Inspect your results

I had to look up again setting up dependencies for submitting jobs. Initially, the second and third jobs for cleaning and mapping would have failed since the controller script ([assignment_7_pipeline](./assignment_7_pipeline.slurm)) runs immediately and the lines in that code are executed instantaneously.