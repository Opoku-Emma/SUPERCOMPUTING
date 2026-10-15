
## Task 1. Setup assignment_6/ directory
TODO: Make all contents readable for group
```bash
# start working from there
cd ~/SUPERCOMPUTING/assignments/assignment_06
mkdir -p data scripts assemblies/{assembly_conda,assembly_local,assembly_module}

#
touch pipeline.sh
chmod a+x pipeline.sh
```

## Task 2. Download raw ONT data

```bash
touch scripts/01_download_data.sh

# paste the code below and save
#!/bin/bash
set -euo pipefail

# download and save to ./data directory
wget -O ./data/SRR33939694.fastq.gz "https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1"

# make executable and run script
chmod +x scripts/01_download_data.sh
bash scripts/01_download_data.sh

```

## Task 3. Get Flye v2.9.6 (local build)

```bash
touch scripts/02_flye_2.9.6_manual_build.sh
chmod +x scripts/02_flye_2.9.6_manual_build.sh

# paste this into the file
#!/bin/bash

# go to programs directory
mkdir -p ~/programs & cd ~/programs

git clone https://github.com/fenderglass/Flye
cd Flye
make

# add flye to $PATH
FLYE_PATH=$(realpath bin/)
echo "export PATH=\$PATH:${FLYE_PATH}" >> ~/.bashrc

exec bash

# build flye program
bash scripts/02_flye_2.9.6_manual_build.sh

# get back to working assignment directory
cd ~/SUPERCOMPUTING/assignments/assignment_06

```

## Task 4. Get Flye v2.9.6 (conda build)

```bash
touch scripts/02_flye_2.9.6_conda_install.sh
chmod a+x scripts/02_flye_2.9.6_conda_install.sh

nano scripts/02_flye_2.9.6_conda_install.sh
## --- paste this code and save
#!/bin/bash

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# create conda environment and install flye
mamba create -y -n flye-env flye

conda activate flye-env

# test it out
flye -v

conda env export --no-builds > flye-env.yml

conda deactivate

## --- run this after saving
bash scripts/02_flye_2.9.6_conda_install.sh
```

## Task 5. Decipher how to use Flye

```bash
flye --nano-hq data/SRR33939694.fastq.gz \
    --out-dir assemblies/
```

Coliphage genomes range in size from 3.39 kb to 386.44 kb [Genome Sequence and Characterization of Coliphage vB_Eco_SLUR29](https://pmc.ncbi.nlm.nih.gov/articles/PMC9041448/)

## Task 6. Run Flye, 3 ways

### 6A. Write a script to run Flye using conda

```bash
touch scripts/03_run_flye_conda.sh
chmod a+x scripts/03_run_flye_conda.sh
```

### 6B. Same as 6A, but using the module environment

```bash
touch scripts/03_run_flye_module.sh
chmod a+x scripts/03_run_flye_module.sh
```

### 6C. Same as 6A, but pointing flye to your local build

```bash
touch scripts/03_run_flye_local.sh
chmod a+x scripts/03_run_flye_local.sh
```

### Task 7. Compare the results in the log files

```bash
LOGS=$(find assemblies -name '*.log')

for log in ${LOGS}; do
    echo
    tail -10 ${log}
done
```

## Task 8. Build a `pipeline.sh` script

