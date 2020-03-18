
process MergeFastQs {
    tag {"bash mergefastqs ${sample_id} - ${read_nr}"}
    label 'bash_4_2_46'
    label 'bash_4_2_46_mergefastqs'
    // container = 'container_url'
    shell = ['/bin/bash', '-euo', 'pipefail']

    input:
    tuple sample_id, flowcell, file(fastq: "*")

    output:
    tuple sample_id, read_nr ,file("${sample_id}_${flowcell}_${read_nr}.fastq.gz")


    script:
    switch(fastq[0]){
      case ~/.*_R1_.*/:
        read_nr = 'R1';
        break;
      case ~/.*_R2_.*/:
        read_nr = 'R2';
        break;
      case ~/.*_I1_.*/:
        read_nr = 'I1';
        break;
      case ~/.*_I2_.*/:
        read_nr = 'I2';
        break;
    }

    """
    cat $fastq > "${sample_id}_${flowcell}_${read_nr}.fastq.gz"
    """

}