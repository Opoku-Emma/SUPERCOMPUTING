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
bash scripts/03_run_flye_module.sh
echo

echo "## --- checking if all match --- ##"

LOGS=$(find assemblies -name '*.log')

for log in ${LOGS}; do
    echo ${log}
    tail -10 ${log}
    echo 
done

echo "### --- Pipeline Complete --- ###"