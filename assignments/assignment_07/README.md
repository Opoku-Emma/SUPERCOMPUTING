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
I cleaned each of the downloaded metagenomes using`fastp`. The resulting  cleaned/trimmed files are stored in `data/clean`.

## Task 4. Map clean reads to dog genome
Before mapping each of the cleaned reads to the dog reference genome, an index file had to be created using `bbmap.sh ref=/path/to/reference_genome/ path=/path/to/save/reference_index_files`. Then I mapped all trimmed/cleaned reads to the dog reference. For a pair of forward and reverse read, the final mapping file is stored in `output/<sample_name>.sam`

## Task 5. Extract reads that matched dog genome
The mapped reads are extracted using `samtools view -h -F 4 <sample.sam>`. The resulting files are also stored at `output/<sample_dog-matches.sam`.

## Task 6. Submit your job to SLURM

## Task 7. Inspect your stdout and stderr

## Task 8. Inspect your results
Finally, I count all dog genome-matched reads and saved the statistics to [read_counts](output/read_counts.tsv).

## Reflection
so instead of having one controller script ([assignment_7_pipeline](./assignment_7_pipeline.slurm)), I made all three scripts that perform different tasks slurm batch scripts. To circumvent the second and third jobs failing since they will need outputs from the previous job, I set a dependency argument.
 Initially, the second and third jobs for cleaning and mapping would have failed since the  runs immediately and the lines in that code are executed instantaneously.