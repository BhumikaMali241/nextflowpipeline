process FASTQC_RAW {
   
   publishDir "../results/fastqc/raw",mode:'symlink'

   input:
   path fastq

   output:
   path "*_fastqc.*"

   script:
   """
   fastqc ${fastq}
   """
} 