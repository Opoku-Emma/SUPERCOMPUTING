#!/bin/bash
set -ueo pipeline

# run first script
./scripts/01_prep_data.sh

# run script 2
./scripts/02_get_stats.sh

# run script 3
./scripts/03_cleanup.sh
