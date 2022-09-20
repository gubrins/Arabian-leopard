for i in $(bcftools query -l just_leopards_gatk.vcf.gz_09.vcf.gz);
do

(VCF=just_leopards_gatk.vcf.gz_09.vcf.gz
vcftools --gzvcf $VCF --indv $i --recode --stdout |bcftools roh --AF-dflt 0.4 > 09/results_"$i".txt) &
done
wait
