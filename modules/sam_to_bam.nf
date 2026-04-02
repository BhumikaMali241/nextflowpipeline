process SAM_TO_BAM {
    tag "sam_to_bam"
    publishDir "${params.outdir}/bam", mode: 'copy'

    input:
    path sam

    output:
    path "sample.bam"

    script:
    """
    ${params.samtools} view -Sb ${sam} > sample.bam
    """
}
