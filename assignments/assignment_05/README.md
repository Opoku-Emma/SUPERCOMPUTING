# Assignment 05

## Task 1. Setup assignment_05/ directory

```bash
## --- Setting up project directory --- ##
cd ~/SUPERCOMPUTING/assignments/assignment_05/

mkdir -p scripts data/{raw,trimmed} log

touch pipeline.sh
chmod a+x pipeline.sh 
```

## Task 2. Script to download and prepare fastq data

This runf from inside the `~/SUPERCOMPUTING/assignments/assignment_05` directory.

```bash
## ----------------------------------------
#!/bin/bash
set -ueo pipefail

## --- Setting up project directory --- ##
cd ~/SUPERCOMPUTING/assignments/assignment_05/

mkdir -p scripts data/{raw,trimmed} log

## --- Downloading and extracting ---
# download file
wget -P data/raw https://gzahn.github.io/data/fastq_examples.tar

# Extracts the contents
tar -xvf data/raw/*.tar

# Puts all the fastq files into ./data/raw/
mv *.fastq.gz data/raw/.

# Cleans up the `fastq_examples.tar` file
rm data/raw/*.tar
## -----------------------------------------
#paste the code above, save, and exit
chmod a+x ./scripts/01_download_data.sh
```

## Task 3. Install and explore the fastp tool

The code below demonstrates how I downloaded and installed fastp.

`fastp version 1.3.7`
```bash
# installing fastp
mkdir -p ~/programs

cd ~/programs

# download the latest build
wget http://opengene.org/fastp/fastp
chmod a+x ./fastp

echo "Done installing"
echo $(fastp --version)

# Add fastp to PATH directory
echo 'export PATH=$PATH:$HOME/programs/fastp' >> ~/.bashrc
echo "fastp added to PATH"
```


## Task 4. Script to run fastp

This is the script that runs fastp: [Second Script](scripts/02_run_fastp.sh)

```bash
cd ~/SUPERCOMPUTING/assignments/assignment_05/

touch ./scripts/02_run_fastp.sh

chmod a+x ./scripts/02_run_fastp.sh

#paste code below and save
## ------------------------------------------------
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
## ----------------------------------------------------
```

## Task 5. `pipeline.sh` script

Paste the code below into [pipeline.sh](pipeline.sh) and save

```bash
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
```

## Task 6. Delete all the data files and start over

```bash
rm data/raw/*.fastq.gz

# make sure data folder structure is pushed
touch data/{raw/placeholder,trimmed/placeholder}
./pipeline.sh
```





## Task 7: Document Everything in README.md
 

Pipeline.sh downloads  a set of compressed sequence files as tar files and processes them with fastp using preconfigured paramters. It is responsible for running two scripts: 1) [01_ download_data.sh](scripts/01_download_data.sh) and 2) [run_fastp.sh](scripts/02_run_fastp.sh).

download_data.sh downloads the datasets, unzips them and deletes the raw tar files that were downloaded

run_fastp.sh takes one forward read as input argument, programmatically finds the reverse read, processes both files and saved the trimmed version to ./data/trimmed/.

pipeline.sh is the all-encompassing script that lists all forward reads in the ./data directory and passes each of them as input arguments to run_fastp.sh and processes them

This was pretty much straight-forward. The challenges I encountered were mostly syntax errors; for instance, I happened to use '\$()' which is command substitution for '\${}' when constructing the filenames for the forward and reverse reads.

I think we separated the two because each performs a specific task. This helps a lot because a user has to edit one short file instead of one big file if, say, there is an issue downloading the data or processing the fastq files. I believe writing modular scripts is particularly useful as you don't have to churn through large files trying to fix bugs later on in the future