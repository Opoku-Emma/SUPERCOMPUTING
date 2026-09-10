# Assignment 02

Name: Emmanuel Opoku
Date: September 09, 2026
Assignment: 02

Make a couple of folders for project setup inside the 
`SUPERCOMPUTING/assignments/assignment_02` github folder on the HPC

```bash
mkdir ./{data,results,logs,scripts}
```

I ran this in my local computer home directory. For reasons unknown,
I was getting write permission denied error when I attempted
to download the files into my `assignment_02` or `SUPERCOMPUTING`
folder. So instead, I changed directory to my home directory and
ran the following code.

```bash
cd ~
ftp
connect
ftp.ncbi.nlm.nih.gov
anonymous
eopoku@wm.edu

pwd
cd genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/

get GCF_000005845.2_ASM584v2_genomic.fna.gz
get GCF_000005845.2_ASM584v2_genomic.gff.gz
```

I still wasn't able to figure out the globalprotect setup so I used the cli method

```bash
sftp bora-offcampus
cd
cd SUPERCOMPUTING/assignments/assignment_02/data/

put GCF_* .
exit
```

From here, I switched back to the terminal where I had already
logged into the HPC

```bash
cd ~/SUPERCOMPUTING/assignments/assignment_02/data

ll # check for file permissions on the data uploaded

chmod g+r GCF* # make files readab
```

## Task 4 
On my local machine, I ran this code

```bash
cd ~
md5sum GCF*
```

```
emmanuel@emmanuel:~$ md5sum GCF*
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz
0f52ffc94af5ddf544ff89cc6f546b0c  GCF_000005845.2_ASM584v2_genomic.gff.gz
```


On the HPC
```bash
md5sum GCF*
```

```
c13d459b5caa702ff7e1f26fe44b8ad7  GCF_000005845.2_ASM584v2_genomic.fna.gz
0f52ffc94af5ddf544ff89cc6f546b0c  GCF_000005845.2_ASM584v2_genomic.gff.gz
```

## Task 5

```bash
nano ~/.bashrc
#pasted aliases
#saved and exited
#ctrl + shift + v
#ctrl + o
#enter
#ctrl + x

source ~/.bashrc
```

`alias u`: Move one level up the directory; clear every text on the terminal; print working directory; list all items in the current directory (including hidden items) in long form with directories appearing first

`alias d`: Move to the previous directory; clear every text on the terminal; print the current directory; list all items in the current directory (including hidden items) in long form with directories appaering first

`alias ll`: List all items in the currrent directory in long form with directories appearing first

