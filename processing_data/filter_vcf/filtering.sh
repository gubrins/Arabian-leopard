#we need to observe the distribution of several values in our data. For that, we create the .table file, which will be observed in R:
gatk="/home/panthera/software/gatk4.1.3/gatk-4.1.3.0/gatk" 
$gatk VariantsToTable -V just_leopards.vcf.gz -F QD -F FS -F SOR -F MQ -FMQRankSum -F ReadPosRankSum -O output_just_leopards.table

#we filter with hard filtering gatk parameters after observing the distributions of those values in your data:
$gatk SelectVariants -R /home/panthera/gabri/leopards/cat_reference_genome/GCF_000181335.3_Felis_catus_9.0_genomic.fna \
-V just_leopards.vcf.gz -select "QD < 10.0 && MQ < 50.0 && FS > 10.0 && SOR > 4.0 && MQRankSum < -5.0 && MQRankSum > 5.0 
&& ReadPosRankSum < -5.0 && ReadPosRankSum > 5.0" -O just_leopards_gatk.vcf.gz



#First of all filter the vcf file with vcftools, keeping only biallelic snps, removing indels, quality, coverage and missing data:
vcftools --gzvcf file.vcf.gz --min-alleles 2 --max-alleles 2 --remove-indels --minQ 30 --min-meanDP 4 --max-meanDP 150 --minDP 4 --maxDP 150 --max-missing 0.8 --recode --stdout |gzip -c > file_filtered.vcf.gz


#Then, select only unlinked snps:
bcftools +prune file_filtered.vcf.gz -l 0.5 -O z -o file_filtered_usnps.vcf.gz
#The -l indicates the maximum LD value accepted. I think it is a correlation value, so higher values means higher correlation. 
#Usually people uses 0.1, but for me it was super restrictive and I did not have enough SNPs, so I changed it to 0.5, a value that I also observed in some
#papers (e.g. Gomez-Sanchez et al. 2018).


#Finally, filter per allele frequency:
vcftools --gzvcf file_filtered_usnps.vcf.gz --maf 0.01 --recode --stdout |gzip -c > file_filtered_usnps_maf.vcf.gz
#Here it depends if you want to keep singletons or not. If you do 1/2*number_individuals you will get the frequency for one allele for one individual.
#If you want to keep singletons, you must put a maf below the number you get, if you want to remove singletons, the maf number must be above. 


#Remove repetitive regions:
#First of all, we need to identify those regions:
cat GCF_000181335.3_Felis_catus_9.0_genomic.fna| python scan_characters.py actg | bedtools merge -i - > lower_case_positions.bed

bedtools intersect -v -a file.vcf -b lower_case_positions.bed |bgzip -c > filtered_file.vcf.gz
