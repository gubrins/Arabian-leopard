for i in $(bcftools query -l $1);
do
(cd $i

bgzip "$i"_results_1_1.vcf
bgzip "$i"_results_0_1.vcf
bgzip "$i"_results_0_0.vcf

bcftools index "$i"_results_1_1.vcf.gz
bcftools index "$i"_results_0_1.vcf.gz
bcftools index "$i"_results_0_0.vcf.gz



cat coordinates.txt |cut -f 3,4,5 > coordinates2.txt
bcftools view -R coordinates2.txt "$i"_results_1_1.vcf.gz | grep HIGH |wc -l > high/"$i"_high_in_roh_1_1.txt
bcftools view -R coordinates2.txt "$i"_results_0_1.vcf.gz | grep HIGH |wc -l > high/"$i"_high_in_roh_0_1.txt
bcftools view -R coordinates2.txt "$i"_results_0_0.vcf.gz | grep HIGH |wc -l > high/"$i"_high_in_roh_0_0.txt

bcftools view -R coordinates2.txt "$i"_results_1_1.vcf.gz | grep missense |wc -l > missense/"$i"_missense_in_roh_1_1.txt
bcftools view -R coordinates2.txt "$i"_results_0_1.vcf.gz | grep missense |wc -l > missense/"$i"_missense_in_roh_0_1.txt
bcftools view -R coordinates2.txt "$i"_results_0_0.vcf.gz | grep missense |wc -l > missense/"$i"_missense_in_roh_0_0.txt


cd ..) & 
done
wait
