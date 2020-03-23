
process VariantAnnotator {
    tag {"GATK_variantannotator ${run_id}"}
    label 'GATK_4_1_3_0'
    label 'GATK_4_1_3_0_variantannotator'
    clusterOptions = workflow.profile == "sge" ? "-l h_vmem=${params.mem}" : ""
    container = 'library://sawibo/default/bioinf-tools:gatk4.1.3.0'

    input:
      tuple run_id, file(vcf), file(vcfidx)

    output:
      tuple run_id, file("${vcf.baseName}_${db_name}.vcf"), file("${vcf.baseName}_${db_name}.vcf.idx")

    script:
    db_file = file(params.genome_variant_annotator_db).getBaseName()
    db_name = db_file.replaceFirst(~/\.[^\.]+$/, '')

    """
    gatk --java-options "-Xmx${task.memory.toGiga()-4}g -Djava.io.tmpdir=\$TMPDIR" \
    VariantAnnotator \
    -R ${params.genome_fasta} \
    -V $vcf \
    --output ${vcf.baseName}_${db_name}.vcf \
    --dbsnp ${params.genome_variant_annotator_db} \
    """
}
