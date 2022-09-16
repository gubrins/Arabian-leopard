#filtrar por calidad o lo que sea:
$gatk VariantFiltration -V small.vcf.gz -filter "QUAL < 80" --filter-name "QUAL80" -O asd.vcf.gz |bgzip -c > pass.vcf.gz


QD < 6.0 || MQ < 40.0 || FS > 10.0 || SOR > 4.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || ReadPosRankSum > 8.0



IndexFeatureFile



   gatk VariantsToTable \
     -V input.vcf \
     -F CHROM -F POS -F TYPE -GF AD \
     -O output.table
