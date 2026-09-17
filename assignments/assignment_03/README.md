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
My go-to approach has always been to copy whatever code I run in the terminal into the README file once it works. This helps me keep track of the commands that answer the questions; I don’t have to search through my command history later to find out what worked and what didn’t. I never used the tr command because of the nature of work that I previously did. But I got to see that it can be used to delete newline characters; this was very useful when solving question 2 of task 3. Even with wc -c, newline characters were still being counted until I implemented tr -d and that solved it.

Any command-line tools that surprised or frustrated you
The command-line tools did not necessarily frustrate me, but working around the questions did. I was thinking of solving question 6 using some straightforward commands that we covered in class. Unfortunately after multiple unsuccessful trials, I just had to chain a bunch of head and tail commands to get it done.

Why these kinds of skills are essential in computational work
I think these skills are essential to facilitate reproducibility and speed. It takes large resources to load the uncompressed file into memory. Even when I wanted to view the .fna file with the less command, scrolling became slow. Subsequently, manually searching through it with normal text editors will not be worthwhile. However, given the speed of bash, simple operations on files can be executed with ease. Also, anyone starting with the same file I used and the exact same commands should obtain the same results I had.

(Optional) How your solution could be automated in the future
