for i in $(bcftools query -l max_missing1_all_leopards.vcf.gz);
do

(mkdir $i
bcftools view -s $i just_leopards_filtered_usnps_maf.vcf.gz |gzip -c > "$i"/"$i".vcf.gz
vcftools --gzvcf "$i"/"$i".vcf.gz --max-missing 1 --recode --stdout |gzip -c > "$i"/"$i"_complete.vcf.gz
zcat "$i"/"$i"_complete.vcf |grep -e "1/1" -e "1|1" > "$i"/"$i"_complete_1_1.vcf
zcat "$i"/"$i"_complete.vcf |grep -e "0/1" -e "0|0"> "$i"/"$i"_complete_0_1.vcf
zcat "$i"/"$i"_complete.vcf |grep -e "0/0" -e "0|0" > "$i"/"$i"_complete_0_0.vcf
zcat "$i"/"$i"_complete.vcf|grep "#" > "$i"/"$i"_comments.txt
cat "$i"/"$i"_comments.txt "$i"/"$i"_complete_1_1.vcf > "$i"/"$i"_united_sample_1_1.vcf
cat "$i"/"$i"_comments.txt "$i"/"$i"_complete_0_1.vcf > "$i"/"$i"_united_sample_0_1.vcf
cat "$i"/"$i"_comments.txt "$i"/"$i"_complete_0_0.vcf > "$i"/"$i"_united_sample_0_0.vcf
cd $i
java -jar ../../../../snpEff_v4_3t_core/snpEff/snpEff.jar -v cat3_final "$i"_united_sample_1_1.vcf > "$i"_results_1_1.vcf
java -jar ../../../../snpEff_v4_3t_core/snpEff/snpEff.jar -v cat3_final "$i"_united_sample_0_1.vcf > "$i"_results_0_1.vcf
java -jar ../../../../snpEff_v4_3t_core/snpEff/snpEff.jar -v cat3_final "$i"_united_sample_0_0.vcf > "$i"_results_0_0.vcf
mkdir high
mkdir missense
cat "$i"_results_0_0.vcf |grep "HIGH" |wc -l > high/"$i"_high_0_0.txt
cat "$i"_results_0_1.vcf |grep "HIGH" |wc -l > high/"$i"_high_0_1.txt
cat "$i"_results_1_1.vcf |grep "HIGH" |wc -l > high/"$i"_high_1_1.txt
cat "$i"_results_0_0.vcf |grep "missense" |wc -l > missense/"$i"_high_0_0.txt
cat "$i"_results_0_1.vcf |grep "missense" |wc -l > missense/"$i"_high_0_1.txt
cat "$i"_results_1_1.vcf |grep "missense" |wc -l > missense/"$i"_high_1_1.txt
cd ..) &
done
wait
