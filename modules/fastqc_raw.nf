process FASTQC_RAW {
   
   publishDir "${params.outdir}/fastqc/raw",mode:'copy'

   input:
   path fastq

   output:
   path "*_fastqc.*"

   script:
   """
   ${params.fastqc} ${fastq}
   """
} 
