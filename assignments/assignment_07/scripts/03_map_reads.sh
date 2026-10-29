#!/bin/bash
#SBATCH --job-name=map_reads
#SBATCH --partition=gz
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=30
#SBATCH --mem=64G
#SBATCH --time=24:00:00
#SBATCH -o logs/assignment_7.out
#SBATCH -e logs/assignment_7.err

set -ueo pipefail

# activate environment
module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate bbmap-env

CLEAN_DIR="data/clean"
REF_GENOME="data/dog_reference/dog_reference_genome.fna"
INDEX_REF="data/ref/"
OUTPUT="output"
THREADS=${SLURM_CPUS_PER_TASK:-10}
JAVA_MEM="-Xmx48g"  

SUMMARY="${OUTPUT}/read_counts.tsv"

mkdir -p ${OUTPUT} logs

# summary table header (tab-separated)
echo -e "SampleID\tTotal Reads\tDog-Mapped Reads" > ${SUMMARY}

## --- Index Reference Genome --- ##
bbmap.sh ref=${REF_GENOME} path=${INDEX_REF} threads=${THREADS} ${JAVA_MEM}

for FWD_IN in $(ls ${CLEAN_DIR}/*_1.trimmed.fastq); do

    REV_IN=${FWD_IN/_1.trimmed/_2.trimmed}
    echo "Forward Read:" ${FWD_IN}
    echo "Reverse Read:" ${REV_IN}

    OUT=${OUTPUT}/$(basename ${FWD_IN/_1.trimmed.fastq/.sam})

    echo "Out File:" ${OUT}

    LOG=logs/$(basename ${FWD_IN/_1.trimmed.fastq/.log})
    echo $LOG

    bbmap.sh in=${FWD_IN} in2=${REV_IN} path=${INDEX_REF} out=${OUT}.tmp.sam \
        minid=0.95 threads=${THREADS} ${JAVA_MEM} \
        > ${LOG} 2>&1
    mv ${OUT}.tmp.sam ${OUT}

    ## --- Extract reads that mapped to the dog genome --- ##
    # -F 4 excludes unmapped reads (flag 4), keeping only mapped reads
    # -h keeps the SAM header
    MAPPED=${OUT/.sam/_dog-matches.sam}
    echo "Mapped Reads Out:" ${MAPPED}
    samtools view -h -F 4 -@ ${THREADS} ${OUT} > ${MAPPED}

    ## --- Count total and dog-mapped reads, add to summary table --- ##
    # -c counts instead of printing; -F 0x900 skips secondary/supplementary
    # alignments so each read is counted once; -F 0x904 also skips unmapped
    SAMPLE=$(basename ${OUT} .sam)
    TOTAL=$(samtools view -c -F 0x900 -@ ${THREADS} ${OUT})

    MAPPED_COUNT=$(samtools view -c -F 0x904 -@ ${THREADS} ${MAPPED})
    echo -e "${SAMPLE}\t${TOTAL}\t${MAPPED_COUNT}" >> ${SUMMARY}

done

conda deactivate bbmap-env

rm -fr data/ref
echo "Done done!!"
