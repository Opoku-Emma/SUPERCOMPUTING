# Code for creating folder structure

I am assuming we are currently inside `SUPERCOMPUTING` directory
and `assignments` folder already exists as it was made in class
so, make  assignment_01 subdirectory

```bash
mkdir assignments/assignment_01
```

construct folder structure for assignment using brace expansion makes it easier

```bash
mkdir assignments/assignment_01/{data,scripts,results,docs,config,logs}
```

add subfolder for raw and clean data and create an empty essay.md file

```bash
mkdir assignments/assignment_01/data/{raw,clean}

cd assignments

cd assignment_01

touch assignment_01_essay.md
```

add placeholder files. this will make it possible to push to github since empty folders are ignored

```bash
touch config/config.txt

touch data/{raw/sample_01.csv,clean/sample_01_cleaned.csv}

touch scripts/01_script.sh results/sample_01_results.csv

touch docs/documentation.txt logs/logfile.log
```
