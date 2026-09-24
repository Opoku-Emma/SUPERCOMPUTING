#!/bin/bash
set -ueo pipefail

FASTA_FILE=$1
echo -e "Input file $FASTA_FILE"
BASE=$(basename $FASTA_FILE)

SUMMARY_FASTA=$(seqtk size $FASTA_FILE)

NUM_SEQS=$(echo $SUMMARY_FASTA | cut -d " " -f1)

NUM_BASES=$(echo $SUMMARY_FASTA | cut -d " " -f2)

# Output format: chr, length, #A, #C, #G, #T, #2, #3, #4, #CpG, #tv, #ts, #CpG-ts
SUMMARY_TBL=$(seqtk comp $FASTA_FILE | cut -f 1,3)

echo -e "Total sequences in $BASE: \t$NUM_SEQS"
echo -e "Total bases (ACGT) in $BASE: \t$NUM_BASES"
echo -e "Sequence names\tlengths"
echo -e "$SUMMARY_TBL\n"
