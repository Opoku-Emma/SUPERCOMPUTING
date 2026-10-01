#!/bin/bash
set -ueo pipefail

FWD_IN=$1
REV_IN=${FWD_IN/_R1_/_R2_}

FWD_OUT=data/trimmed/$(basename ${FWD_IN/.fastq.gz/.trimmed.fastq.gz})
REV_OUT=data/trimmed/$(basename ${REV_IN/.fastq.gz/.trimmed.fastq.gz})

echo "Forward Read:" $FWD_IN 
echo "Reverse Read:" $REV_IN
echo "Forward Read Out:" $FWD_OUT 
echo "Reverse Read Out:" $REV_OUT

LOG=log/$(basename ${FWD_IN/_R1*.fastq.gz/})
HTML_LOG=${LOG}.html
echo $LOG

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
    > "$LOG.out" 2>&1

