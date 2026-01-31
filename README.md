## Variant Calling Pipeline using Nextflow

This repository contains a modular **single-end variant calling pipeline** implemented using **Nextflow**. The pipeline processes raw sequencing reads to identify **SNPs and small INDELs** by aligning reads to a reference genome and performing variant calling using standard bioinformatics tools.

The workflow is designed using **Nextflow DSL2**, with each analysis step implemented as a separate reusable module.

---

##  Quick Start

```bash
# Clone the repository
git clone <repository_url>
cd <repository_name>

# Create the Conda environment for pipeline tools
conda env create -f environment.yml

# Activate the Conda environment that runs Nextflow
conda activate bnf

# Run the pipeline
nextflow run main.nf
```

Resume a previous run:

```bash
nextflow run main.nf -resume
```

---

## Pipeline Overview

The pipeline performs the following major steps:

1. Quality control of raw reads
2. Adapter trimming
3. Quality control of trimmed reads
4. Read alignment to a reference genome
5. SAM to BAM conversion
6. BAM sorting and indexing
7. Variant calling
8. Aggregation of QC reports using MultiQC

---

## Repository Structure

```
README.md
├── data
│   └── exom.fastq
├── reference
│   └── reference.fa
├── main.nf
├── workflow.nf
├── nextflow.config
├── environment.yml
├── modules
│   ├── fastqc_raw.nf
│   ├── trim_reads.nf
│   ├── fastqc_trimmed.nf
│   ├── align_reads.nf
│   ├── sam_to_bam.nf
│   ├── sort_index_bam.nf
│   ├── variant_calling.nf
│   └── multiqc.nf
├── results
│   ├── fastqc
│   ├── trimmed
│   ├── alignment
│   ├── bam
│   └── variantcalling
├── work
└── .gitignore
```

---

## Input Files

* **Single-end FASTQ file**

  ```
  data/exom.fastq
  ```

* **Reference genome (FASTA format)**

  ```
  reference/reference.fa
  ```

---

## Tools and Software Used

* **Nextflow**
* **FastQC**
* **Cutadapt**
* **BWA**
* **Samtools**
* **BCFtools**
* **MultiQC**

All tools are installed reproducibly using **Conda** via the provided `environment.yml` file. Nextflow automatically manages tool availability during pipeline execution.

---

## 🔧 Environment Setup

### Prerequisites

* Conda / Miniconda
* Nextflow
* Git

---

### Create the Conda environment for pipeline tools

```bash
conda env create -f environment.yml
```

This command creates a Conda environment named:

```
nextflowpipeline
```

> This environment contains all bioinformatics tools required by the pipeline and is **activated automatically by Nextflow** for each process.

---

### Activate the environment that runs Nextflow

```bash
conda activate bnf
```

Verify Nextflow installation:

```bash
nextflow -version
```

---

## Pipeline Steps (Detailed)

### 1. Raw Read Quality Control

* Tool: **FastQC**
* Module: `fastqc_raw.nf`
* Generates quality metrics for raw FASTQ files.

---

### 2. Adapter Trimming

* Tool: **Cutadapt**
* Module: `trim_reads.nf`
* Removes Illumina adapter sequences from raw reads.

---

### 3. Quality Control After Trimming

* Tool: **FastQC**
* Module: `fastqc_trimmed.nf`
* Evaluates quality of trimmed reads.

---

### 4. Read Alignment

* Tool: **BWA-MEM**
* Module: `align_reads.nf`
* Aligns trimmed reads to the reference genome.

---

### 5. SAM to BAM Conversion

* Tool: **Samtools**
* Module: `sam_to_bam.nf`
* Converts alignment output from SAM to BAM format.

---

### 6. BAM Sorting and Indexing

* Tool: **Samtools**
* Module: `sort_index_bam.nf`
* Sorts and indexes BAM files for downstream analysis.

---

### 7. Variant Calling

* Tool: **BCFtools**
* Module: `variant_calling.nf`
* Identifies SNPs and small INDELs and produces a VCF file.

---

### 8. MultiQC Report

* Tool: **MultiQC**
* Module: `multiqc.nf`
* Aggregates FastQC reports into a single HTML summary.

---

## Output Files

* FastQC HTML and ZIP reports (raw and trimmed reads)
* Trimmed FASTQ file
* Aligned SAM file
* BAM file (sorted and indexed)
* Variant Call Format file (`variants.vcf`)
* MultiQC summary report

All outputs are stored in the `results/` directory, organized by analysis step.

---

## Configuration

Key parameters are defined in `main.nf`:

```nextflow
params.fastq   = "data/exom.fastq"
params.ref     = "reference/reference.fa"
params.outdir  = "results"
params.adapter = "AGATCGGAAGAGC"
```

Resource settings are configured in `nextflow.config`:

* CPUs: 2
* Memory: 4 GB
* Retry strategy enabled

---

## How to Run the Pipeline

From the project root directory, run:

```bash
nextflow run main.nf
```

### Resume Execution

If the pipeline stops or you want to resume from previous successful steps:

```bash
nextflow run main.nf -resume
```

---

##  Version Control and GitHub Usage

### Files tracked by Git

* Pipeline scripts (`*.nf`)
* Configuration files
* `environment.yml`
* `README.md`

### Files excluded from Git

The following are ignored via `.gitignore`:

* `work/`
* `.nextflow/`
* `results/`
* Log files (`*.log`, `nohup.out`)

---

##  How to Push the Pipeline to GitHub

```bash
# Initialize git
git init

# Stage files
git add .

# Commit changes
git commit -m "Add Nextflow variant calling pipeline with conda environment"

# Link to GitHub repository
git branch -M main
git remote add origin <repository_url>

# Push to GitHub
git push -u origin main
```

---

## Notes

* The `work/` directory contains intermediate execution files managed by Nextflow.
* The `results/` directory is excluded from version control using `.gitignore`.
* Conda environments are **not committed** to Git.
* The pipeline currently supports **single-end sequencing data**.

---
