process MULTIQC {
     tag "multiqc"
    publishDir "../results/multiqc",mode:'symlink'

    input :
    path '*'

    output :
    path "multiqc_report.html"

    script:
    """

    multiqc .
    """
}