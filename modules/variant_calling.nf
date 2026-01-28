process VARIANT_CALLING {
    tag "variant_calling"
    publishDir "../results/variantcalling",mode:'symlink'

    input:
    path bam
    path bai
    path ref

    output:
    path "variants.vcf" , emit :vcf

    script:
    """

    bcftools mpileup -f ${ref} ${bam} | bcftools call -mv -o variants.vcf
    """

}