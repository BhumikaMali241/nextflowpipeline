process MULTIQC {
     tag "multiqc"
    publishDir "${params.outdir}/multiqc",mode:'copy'

    input :
    path '*'

    output :
    path "multiqc_report.html"

    script:
    """

    ${params.multiqc} .
    """
}
