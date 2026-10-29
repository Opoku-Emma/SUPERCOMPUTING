# Assignment 07

This pipeline performs these tasks in order:
- Downloads metagenomic sequence data from SRA
- Downloads dog reference genome (*Canis familiaris*)
- Cleans the metagenomic reads
- Aligns the cleaned reads to the dog reference genome and
- Provides summary statistics on the alignment

The only data file needed to run this pipeline is: [SraRunTable.csv](./data/SraRunTable.csv). 
This can be updated later on when needed.

To run this pipeline: 
```bash
bash assignment_7_pipeline.slurm
```
Logs are stored in `./logs`.
The script automatically cleans up non-essential files
## Task 1. Setup assignment_7/ directory
This step sets up the project directory. The subdirectories are needed for the other steps
```bash
# just make sure I am in the right directory
cd /sciclone/scr10/eopoku/SUPERCOMPUTING/assignments/assignment_07/

mkdir -p data/{raw,clean,dog_reference} output scripts logs
```

## Task 2. Download Sequence Data

The [SraRunTable.csv](./data/SraRunTable.csv) file was created using the keywords below to search for genomic data on SRA
`(((((metagenome) AND shotgun metagenome) AND paired end) AND illumina)) AND genome`

Metadata for the first 12 results were downloaded.
The accessions listed in the sra file are downloaded automatically and stored in `data/raw`

## Task 3. Clean up raw reads

## Task 4. Map clean reads to dog genome

## Task 5. Extract reads that matched dog genome

## Task 6. Submit your job to SLURM

## Task 7. Inspect your stdout and stderr

## Task 8. Inspect your results

so instead of having one controller script ([assignment_7_pipeline](./assignment_7_pipeline.slurm)), I made all three scripts that perform different tasks slurm batch scripts. To circumvent the second and third jobs failing since they will need outputs from the previous job, I set a dependency argument.
 Initially, the second and third jobs for cleaning and mapping would have failed since the  runs immediately and the lines in that code are executed instantaneously.