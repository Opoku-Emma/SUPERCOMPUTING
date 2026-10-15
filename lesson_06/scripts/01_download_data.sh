#!/bin/bash
set -ueo pipefail

wget https://zenodo.org/records/15733378/files/ecoli_and_lambda.tar

tar -xf *.tar

rm *tar
