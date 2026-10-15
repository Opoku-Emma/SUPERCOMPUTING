#!/bin/bash
#SBATCH --job-name=pipeline
#SBATCH --nodes=1 # how many physical machines in the cluster
#SBATCH --ntasks=1 # how many separate 'tasks' (stick to 1)
#SBATCH --cpus-per-task=10 # how many cores (bora max is 20)
#SBATCH --time=120 # d-hh:mm:ss or just No. of minutes
#SBATCH --mem=20 # how much physical memory (all by default)
#SBATCH -o pipeline_%j.out #STDOUT to file (%j is jobID)
#SBATCH -e pipeline_%j.err #STDERR to file (%j is jobID)

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