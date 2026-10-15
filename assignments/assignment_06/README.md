
## Task 1. Setup assignment_6/ directory

We start from `~/SUPERCOMPUTING/assignments/assignment_06`. Here I create all the necessary subdirectories needed for our pipeline. Then I create a pipeline script which I will later return to. It's purpose to fully automate the assembly and analysis process. This script will be available to all users
```bash
# start working from there
cd ~/SUPERCOMPUTING/assignments/assignment_06
mkdir -p data scripts assemblies/{assembly_conda,assembly_local,assembly_module}

#
touch pipeline.sh
chmod a+rx pipeline.sh
```

## Task 2. Download raw ONT data

At this step, I wrote the script to download the genome we will be assembling. `-O` let's me specify both the directory the final download should go into and its name as well

```bash
touch scripts/01_download_data.sh

# paste the code below and save
#!/bin/bash
set -euo pipefail

# download and save to ./data directory
wget -O ./data/SRR33939694.fastq.gz "https://zenodo.org/records/15730819/files/SRR33939694.fastq.gz?download=1"

# make executable and run script
chmod g+rx scripts/01_download_data.sh
bash scripts/01_download_data.sh

```

## Task 3. Get Flye v2.9.6 (local build)

To make a local build of flye, I used the installation instructions from their github page. I also added the Flye binaries to the `$PATH` variable so that we can run the program from anywhere across the system

```bash
touch scripts/02_flye_2.9.6_manual_build.sh
chmod +x scripts/02_flye_2.9.6_manual_build.sh

# paste this into the file -------##
#!/bin/bash

# go to programs directory
mkdir -p ~/programs
cd ~/programs

git clone https://github.com/fenderglass/Flye
cd Flye
make

# add flye binaries to $PATH
FLYE_PATH=$(realpath bin/)
echo "export PATH=\$PATH:${FLYE_PATH}" >> ~/.bashrc
## ------------------------------##

# build flye program
bash scripts/02_flye_2.9.6_manual_build.sh

# get back to working assignment directory
cd ~/SUPERCOMPUTING/assignments/assignment_06

```

## Task 4. Get Flye v2.9.6 (conda build)

This time, I install the Flye program using conda

```bash
touch scripts/02_flye_2.9.6_conda_install.sh
chmod a+x scripts/02_flye_2.9.6_conda_install.sh

nano scripts/02_flye_2.9.6_conda_install.sh
## --- paste this code and save ----------##
#!/bin/bash

module load miniforge3
source "$(conda info --base)/etc/profile.d/conda.sh"

# create conda environment and install flye
mamba create -y -n flye-env flye=2.9.6

conda activate flye-env

# test it out
flye -v

conda env export --no-builds > flye-env.yml

conda deactivate

## --- run this after saving -------------##
bash scripts/02_flye_2.9.6_conda_install.sh
```

## Task 5. Decipher how to use Flye

```bash
flye --nano-hq data/SRR33939694.fastq.gz --out-dir ./assemblies/assembly_conda/ --threads 6 
```

Coliphage genomes range in size from 3.39 kb to 386.44 kb [Genome Sequence and Characterization of Coliphage vB_Eco_SLUR29](https://pmc.ncbi.nlm.nih.gov/articles/PMC9041448/)

## Task 6. Run Flye, 3 ways

### 6A. Write a script to run Flye using conda

```bash
touch scripts/03_run_flye_conda.sh
chmod a+x scripts/03_run_flye_conda.sh
bash scripts/03_run_flye_conda.sh
```

### 6B. Same as 6A, but using the module environment

```bash
touch scripts/03_run_flye_module.sh
chmod a+x scripts/03_run_flye_module.sh
bash scripts/03_run_flye_module.sh
```

### 6C. Same as 6A, but pointing flye to your local build

```bash
touch scripts/03_run_flye_local.sh
chmod a+x scripts/03_run_flye_local.sh
bash scripts/03_run_flye_local.sh
```

### Task 7. Compare the results in the log files

```bash
LOGS=$(find assemblies -name '*.log')

for log in ${LOGS}; do
    echo
    tail -10 ${log}
done
```

All of the different runs return the same results so far.

## Task 8. Build a `pipeline.sh` script

```bash
#!/bin/bash

set -euo pipefail

mkdir -p data scripts assemblies/{assembly_conda,assembly_local,assembly_module}

echo "## --- Downloading Data --- ##"
bash scripts/01_download_data.sh

echo "## --- Building local flye --- ##"
bash scripts/02_flye_2.9.6_manual_build.sh

echo "## --- Building flye with conda --- ##"
bash scripts/02_flye_2.9.6_conda_install.sh
echo

echo "## --- Assembling with Conda --- ##"
bash scripts/03_run_flye_conda.sh

echo "## --- Assembling with local build --- ##"
bash scripts/03_run_flye_local.sh
echo

echo "## --- Assembling with flye module version --- ##"
# bash scripts/03_run_flye_module.sh
echo

echo "## --- checking if all match --- ##"

LOGS=$(find assemblies -name '*.log')

for log in ${LOGS}; do
    echo ${log}
    tail -10 ${log}
    echo 
done

echo "### --- Pipeline Complete --- ###"
```

## Task 9. Delete everything (except scripts) and start over

## Task 10. Document Everything in README.md

The pipeline does the following:

- downloads a Colipage genome
- installs Flye, a software for assembling ONT long reads
- assembles the Coliphage genome using 3 methods:
  - a local build of Flye
  - conda environment with flye installed
  - flye available as a module on the HPC
- removes all clutter after assembly and keeps only the assembled contigs together with the log file. The results can be found in `./assemblies/`

To run the pipeline, first make sure you are in the root directory. Then run

```bash
bash pipeline.sh
```

### Challenges