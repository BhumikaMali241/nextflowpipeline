include { FASTQC_RAW }      from '../modules/fastqc_raw'
include { TRIM_READS }      from '../modules/trim_reads'
include { FASTQC_TRIMMED }  from '../modules/fastqc_trimmed'
include { ALIGN_READS }     from '../modules/align_reads'
include { SAM_TO_BAM }      from '../modules/sam_to_bam'
include { SORT_INDEX_BAM }  from '../modules/sort_index_bam'
include { VARIANT_CALLING } from '../modules/variant_calling'
include { MULTIQC }         from '../modules/multiqc'


workflow MY_PIPELINE {
    take:
        fastq_input
        ref_input

    main:
        raw_qc = FASTQC_RAW(fastq_input)
        trimmed_fq = TRIM_READS(fastq_input)
        trimmed_qc = FASTQC_TRIMMED(trimmed_fq)
        aligned = ALIGN_READS(trimmed_fq, ref_input)
        bam = SAM_TO_BAM(aligned)
        sorted_outputs = SORT_INDEX_BAM(bam)
        VARIANT_CALLING(sorted_outputs.sorted_bam,sorted_outputs.bai, ref_input)

        all_qc_logs = raw_qc.mix(trimmed_qc).collect()
        MULTIQC(all_qc_logs)
}

