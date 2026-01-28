
params.fastq = "$projectDir/data/exom.fastq"
params.ref = "$projectDir/reference/reference.fa"
params.outdir = "$projectDir/results"
params.adapter = "AGATCGGAAGAGC"
include {MY_PIPELINE} from './workflow'

workflow {

     fastq_ch = channel.fromPath(params.fastq, checkIfExists: true)
    ref_ch   = channel.fromPath(params.ref, checkIfExists: true)

    MY_PIPELINE(fastq_ch, ref_ch)

}

