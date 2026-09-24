# Assignment 04

## Task 2: Download and unpack the gh "tarball" file

```bash
# start from here
cd ~/SUPERCOMPUTING/assignments/assignment_04/

# make folder if not already present
mkdir -p ~/programs

cd ~/programs

wget https://github.com/cli/cli/releases/download/v2.74.2/gh_2.74.2_linux_amd64.tar.gz

tar -xzvf gh_2.74*.tar.gz
```

## Task 3: Build a bash script from task 2

```bash
# clean-up
rm gh_2.74*.tar.gz

# still in ~/programs
nano install_gh.sh

#pasted code for downloading, unzipping, and cleaning up files

chmod +x install_gh.sh

./install_gh.sh

cp ./install_gh.sh ~/SUPERCOMPUTING/assignments/assignment_04/scripts/.

```

## Task 4. Add the location of the gh binary to your $PATH

```bash
# gh binaries path
realpath gh_2.74.2_linux_amd64/

echo 'export PATH=$PATH:$HOME/programs/gh_2.74.2_linux_amd64/bin/' >> ~/.bashrc

source ~/.bashrc
```

## Task 5. Run gh auth login to setup your GitHub username and password

```bash
gh auth login
```

## Task 6. Create another installation script (for seqtk)

```bash
#!/bin/bash
set -ueo pipefail

# go to programs directory
cd ~/programs

## --- Instructions from seqtk github repo
git clone https://github.com/lh3/seqtk.git

cd seqtk

make

echo 'export PATH=$PATH:$HOME/programs/seqtk/' >> ~/.bashrc
```

this was done in `~/programs`

```bash
nano install_seqtk.sh
# pasted the code block above

# Ctrl + o
# Ctrl + x

# make it executable
chmod +x install_seqtk.sh

./install_seqtk.sh

source ~/.bashrc

cp install_seqtk.sh ~/SUPERCOMPUTING/assignments/assignment_04/scripts/.
```

## Task 7. Figure out seqtk

```bash
cd ~/SUPERCOMPUTING/assignments/assignment_04

# count number of sequences and bases
seqtk size ../assignment_03/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz 

# identify high or low GC regions
seqtk gc ../assignment_03/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz > high_low_gc_regions_athaliana.txt
```

## Task 8. Write a `summarize_fasta.sh` script

Already in assignment_04 directory

```bash
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

```

```bash
nano summarize_fasta.sh

# paste the above lines of code in summarize_fasta.sh
# ctrl + o
# ctrl + x

chmod +x summarize_fasta.sh

# test it
./summarize_fasta.sh ../assignment_03/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz
```

## Task 9. Run `summarize_fasta.sh` in a loop on multiple files

```bash
mkdir -p data
cd data 

# download E. coli genome
datasets download genome accession PRJNA313
unzip ncbi_dataset.zip -d e_coli
mv e_coli/ncbi_dataset/data/GCF*/GCF*.fna .

# download S. cerevisiae
datasets download genome taxon 559292
unzip ncbi_dataset.zip -d s_cerevisiae
mv s_cerevisiae/ncbi_dataset/data/GCF*/GCF*.fna .

# download M. tuberculosis
datasets download genome accession GCF_000195955.2 --include genome
unzip ncbi_dataset.zip -d m_tuberculosis
mv m_tuberculosis/ncbi_dataset/data/GCF*/GCF*.fna .

# clean-up
rm -fr e_coli s_cerevisiae m_tuberculosis

# go back to assignment_04 directory
cd ../

# make scripts directory
mkdir -p scripts

mv summarize_fasta.sh scripts/.

for fasta in $(ls ./data/*.fna)
do
    bash ./scripts/summarize_fasta.sh $(realpath $fasta)

done

```

## Task 10: Document Everything in README.md

The most challenging part was pushing to github after installing `gh` and authenticating. I was running into issues because a different version of `gh` was installed and conflicts came up when I had to use git to push to the SUPERCOMPUTING repository.

## Task 11 Push to Github

```bash

git add ~/SUPERCOMPUTING/assignments/assignment_04/

git commit -m "Almost done here"

git push```
