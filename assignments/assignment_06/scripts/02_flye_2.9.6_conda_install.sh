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