process FASTQC_TRIMMED {
    tag "trimmed_qc"
    publishDir "${params.outdir}/fastqc/trimmed",mode : 'copy'

    input : 
    path trimmed 

    output:
    path "*_fastqc.{html,zip}"

    script:
    """

    ${params.fastqc} ${trimmed}
    """ 
}
