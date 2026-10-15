#!/bin/bash

mkdir -p data/{raw,clean} output/
wget https://biglogurl/example_fastqs.tar.gz

mv example_fastqs.tar.gz data/raw/
tar -xzf data/raw/example_fastq.tar.gz

