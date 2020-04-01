process Index {
    tag {"Salmon Index ${transcripts_fasta.baseName}"}
    label 'Salmon_0_13_1'
    label 'Salmon_0_13_1_Index'
    container = 'quay.io/biocontainers/salmon:0.13.1--h86b0361_0'
    shell = ['/bin/bash', '-euo', 'pipefail']
    
    input:
    file(transcripts_fasta)
    
   
    output:
    file("${transcripts_fasta.baseName}/")

    script:
    """
    salmon index -t ${transcripts_fasta} -i ${transcripts_fasta.baseName}       
    """
}

