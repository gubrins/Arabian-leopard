
vcf="/home/panthera/gabri/leopards/new_gvcf/genotype/new_autosomes.vcf.gz"
sample="Leopards_2"
for region in $(cat complete_windows.txt);
do
callable=$(tabix -h $vcf $region | vcftools --gzvcf - --indv $sample --remove-indels --max-alleles 2 --minQ 30 --minDP 2 --maxDP 300 --stdout --recode --recode-INFO-all | grep -v '#' | wc -l ) 
	if [ $callable -gt 0 ];
	then
		value=${region#*:}
		start=$(echo "$value" |cut -d- -f1)
		chrom=$(echo "$region" |cut -d: -f1)
		tabix -h $vcf $region | vcftools --gzvcf - --indv $sample --remove-indels --max-alleles 2 --minQ 30 --minDP 2 --maxDP 300 --stdout --recode --recode-INFO-all | vcfhetcount | tail -n 1 | awk -v l="$callable" -v chrom="$chrom" -v start="$start" '{print chrom"\t"start+50000"\t"$1"\t"l"\t"$1/l}' | tee -a "$sample"_heterozygosity.txt
	else
		echo $line | awk -v l=0 -v het=NA '{print $1"\t"$2+50000"\t"l"\t"l"\t"het}' | tee -a "$sample"_heterozygosity.txt
	fi
done
