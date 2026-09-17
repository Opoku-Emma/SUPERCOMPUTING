# Assignment 3
Name: Emmanuel Opoku
Date: September 17, 2026


## Task 1

```bash
cd ~/SUPERCOMPUTING/assignments/assignment_03

mkdir data
```

## Task 2
```bash
wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz 

mv *.fna.gz data/.

# unzip inside data folder
gunzip data/GCF_000001735.4_TAIR10.1_genomic.fna.gz 
```

## Task 3
```bash
cd data
# 1
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l

# 2
# tr -d deletes newline characters
grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna | tr -d "\n" | wc -c 

# 3
wc -l GCF_000001735.4_TAIR10.1_genomic.fna 

# 4
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "mitochondrion" | wc -l

# 5
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | grep "chromosome" | wc -l

# 6
head -10 GCF_000001735.4_TAIR10.1_genomic.fna | grep -v "^>" > tmp_Arabidopsis_thaliana.fna

head -1 tmp_Arabidopsis_thaliana.fna | wc -c
head -2 tmp_Arabidopsis_thaliana.fna | tail -1 |  wc -c
head -3 tmp_Arabidopsis_thaliana.fna | tail -1 | wc -c

# 7
tail -1 tmp_Arabidopsis_thaliana.fna | wc -c

# 8
grep "AAAAAAAAAAAAAAAA" GCF_000001735.4_TAIR10.1_genomic.fna | wc -l

# 9
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna | sort | head -1

#10
grep "^>" GCF_000001735.4_TAIR10.1_genomic.fna > headers
grep -v "^>" GCF_000001735.4_TAIR10.1_genomic.fna > tmp_sequences.fna
paste headers tmp_sequences.fna > tab_separated_genome.csv
```

## Task 5

Clean up
```bash
rm *.fna *.csv headers
wget https://gzahn.github.io/data/GCF_000001735.4_TAIR10.1_genomic.fna.gz 
```
Your approach and what you learned
Any command-line tools that surprised or frustrated you
Why these kinds of skills are essential in computational work
(Optional) How your solution could be automated in the future
