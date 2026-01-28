Variant Calling Pipeline using Nextflow

This repository contains a modular **single-end variant calling pipeline** implemented using **Nextflow**. The pipeline processes raw sequencing reads to identify **SNPs and small INDELs** by aligning reads to a reference genome and performing variant calling using standard bioinformatics tools.

The workflow is designed using **Nextflow DSL2**, with each analysis step implemented as a separate reusable module.

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

All tools are expected to be available in the system PATH or through containerization (Docker/Singularity if configured).

---

## Pipeline Steps (Detailed)

### 1. Raw Read Quality Control

* Tool: **FastQC**
* Module: `fastqc_raw.nf`
* Generates quality metrics for raw FASTQ files.

### 2. Adapter Trimming

* Tool: **Cutadapt**
* Module: `trim_reads.nf`
* Removes Illumina adapter sequences from raw reads.

### 3. Quality Control After Trimming

* Tool: **FastQC**
* Module: `fastqc_trimmed.nf`
* Evaluates quality of trimmed reads.

### 4. Read Alignment

* Tool: **BWA-MEM**
* Module: `align_reads.nf`
* Aligns trimmed reads to the reference genome.

### 5. SAM to BAM Conversion

* Tool: **Samtools**
* Module: `sam_to_bam.nf`
* Converts alignment output from SAM to BAM format.

### 6. BAM Sorting and Indexing

* Tool: **Samtools**
* Module: `sort_index_bam.nf`
* Sorts and indexes BAM files for downstream analysis.

### 7. Variant Calling

* Tool: **BCFtools**
* Module: `variant_calling.nf`
* Identifies SNPs and small INDELs and produces a VCF file.

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

## Cloning the Repository

Clone the repository using Git:

```bash
git clone <repository_url>
cd <repository_name>
```

---

## Configuration

Key parameters are defined in `main.nf`:

```nextflow
params.fastq  = "data/exom.fastq"
params.ref    = "reference/reference.fa"
params.outdir = "results"
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

## Notes

* The `work/` directory contains intermediate execution files managed by Nextflow.
* The `results/` directory is excluded from version control using `.gitignore`.
* The pipeline currently supports **single-end sequencing data**.

---

If you want, I can also:

* Make this **shorter / more academic**
* Add a **workflow diagram**
* Rewrite it to match **GitHub bioinformatics repo standards**
* Or align it exactly with a **thesis / MSc project format**

Just tell me 😄
