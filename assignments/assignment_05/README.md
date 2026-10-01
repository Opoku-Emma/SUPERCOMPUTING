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

```bash
## ----------------------------------------
# download file
wget -P data/raw https://gzahn.github.io/data/fastq_examples.tar

# extract content
tar -xvf data/raw/*.tar

mv *.fastq.gz data/raw/.

rm data/raw/*.tar

nano ./scripts/01_download_data.sh
## -----------------------------------------
#paste the code above, save, and exit
chmod a+x ./scripts/01_download_data.sh
```

## Task 3. Install and explore the fastp tool

fastp version 1.3.7

```bash
# installing fastp
mkdir -p ~/programs

cd ~/programs

# download the latest build
wget http://opengene.org/fastp/fastp
chmod a+x ./fastp

echo "Done installing"
echo $(fastp --version)

echo "fastp added to PATH"

echo 'export PATH=$PATH:$HOME/programs/fastp' >> ~/.bashrc
```


## Task 4. Script to run fastp

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

FWD_OUT=${FWD_IN/.fastq.gz/.trimmed.fastq.gz}
REV_OUT=$(REV_IN/.fastq.gz/.trimmed.fastq.gz)

LOG=log/$(basename ${FWD_IN/_R1*.fastq.gz/.out})

echo "Forward Read:" $FWD_IN "Reverse Read:" $REV_IN

fastp --in1 $FWD_IN --in2 $REV_IN --out1 $FWD_OUT --out2 $REV_OUT \
    --json /dev/null \
    --html $LOG \
    --trim_front1 8 \
    --trim_front2 8 \
    --trim_tail1 20 \
    --trim_tail2 20 \
    --n_base_limit 0 \
    --length_required 100 \
    --average_qual 20

## ----------------------------------------------------
```

## Task 5. `pipeline.sh` script


## Task 6. Delete all the data files and start over

```bash
rm data/raw/*.fastq.gz
./pipeline.sh
```