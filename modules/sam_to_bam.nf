process SAM_TO_BAM {
    tag "sam_to_bam"
    publishDir "../results/bam", mode: 'symlink'

    input:
    path sam

    output:
    path "sample.bam"

    script:
    """
    samtools view -Sb ${sam} > sample.bam
    """
}