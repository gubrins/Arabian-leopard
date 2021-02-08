samples="data.txt"
reference="/home/pristurus/Desktop/gabri/leopards/reference/African_Lion.scafSeq.FG.fasta"
picard="/home/pristurus/Desktop/gabri/softwares/picard/picard.jar"
gatk="/home/pristurus/Desktop/gabri/softwares/gatk/gatk-package-4.1.7.0-local.jar"

#to map the sample with the reference genome:
for i in $(cat $samples);
do
#bwa -t will fix number of threads. Be careful! Take into account number of samples that will proceed at the same time. 
#If you have 10 samples and -t 10, will need 100 cores!!!
(bwa mem -t 10 -M $reference "$i"_1.fastq.gz "$i"_2.fastq.gz -R "@RG\tID:"$i"\tSM:"$i"" | samtools sort -o "$i".bam) &
done
wait

#to mark duplicated reads, really important in WGS!:
for i in $(cat $samples);
do
(java -jar $picard MarkDuplicates INPUT="$i".bam OUTPUT="$i"_mkdup.bam METRICS_FILE="$i".txt ASSUME_SORT_ORDER=coordinate CREATE_INDEX=True TMP_DIR=/tmp) &
done
wait

#to do the SNP calling with GATK:
for i in $(cat $samples);
do
(java -jar $gatk HaplotypeCaller --reference $reference --input "$i"_mkdup.bam --output "$i".g.vcf -ERC GVCF) &
done
wait

#combine the gvcf files in one, this will be a massive file!!:
java -jar $gatk CombineGVCFs --reference $reference \
--variant $(ls *g.vcf | sed -n 1p) \ #this is a command that will look in our directory for all the files finishing in g.vcf and will select the first one
--variant $(ls *g.vcf | sed -n 2p) \ #here will select the second one
--variant $(ls *g.vcf | sed -n 3p) \ #here the third one and so on, so you'll have to create as many variant as number of samples you have, maybe we need to find a better solution for this step!
--output combined.g.vcf

#finally, we make the SNP calling on the combined file to obtain the VCF:
java -jar $gatk GenotypeGVCFs --reference $reference --variant combined.g.vcf --output final_dataset.vcf




