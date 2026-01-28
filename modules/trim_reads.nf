process TRIM_READS{
    tag "trimming"
    publishDir "${params.outdir}/trimmed",mode: 'symlink'

    input:
    path fastq

    output:
    path "sample_trimmed.fastq"

    script:
    """
    cutadapt -a AGATCGGAAGAGC -o sample_trimmed.fastq $fastq
    """

}