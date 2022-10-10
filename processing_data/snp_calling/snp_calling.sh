#!/bin/bash
samples="data.txt"
reference="/home/pristurus/Desktop/gabri/leopards/reference/African_Lion.scafSeq.FG.fasta"
picard="/home/panthera/software/picard/picard.jar"
gatk="/home/panthera/software/gatk4.1.3/gatk-4.1.3.0/gatk" 

#INDEX THE REFERENCE GENOME!
bwa index reference_genome
samtools faidx path_to_reference.fa
java -jar /home/panthera/software/picard/picard.jar CreateSequenceDictionary R=path_to_reference.fa

#to map the sample with the reference genome:
for i in $(cat $samples);
do
#bwa -t will fix number of threads. Be careful! Take into account number of samples that will proceed at the same time. 
#If you have 10 samples and -t 10, will need 100 cores!!!
bwa mem -t 10 -M $reference "$i"_1.fastq.gz "$i"_2.fastq.gz -R "@RG\tID:"$i"\tSM:"$i"" | samtools sort -o "$i".bam
done


#to mark duplicated reads, really important in WGS!:
for i in $(cat $samples);
do
java -jar $picard MarkDuplicates INPUT="$i".bam OUTPUT="$i"_mkdup.bam METRICS_FILE="$i".txt ASSUME_SORT_ORDER=coordinate REMOVE_DUPLICATES=TRUE CREATE_INDEX=True TMP_DIR=/tmp
done


#we filter for mapping quality of at least 30, we remove unmapped reads and secondary alignments:
samtools view -q 30 -F 260 -b bam.file -o file_30.bam


#to do the SNP calling with GATK:
for sample in $(cat $samples);
do
for i in $(cat $chrom)
do
$gatk HaplotypeCaller -R $ref -I "$dir""$sample".bam -O "$sample""$i".g.vcf.gz -ERC BP_RESOLUTION -L "$i"
done
wait

done



#combine the gvcf files in one, this will be a massive file!!:
chrom="/home/panthera/gabri/leopards/cat_reference_genome/chromosomes_1.txt"
list="/mnt/DiscoB/leopards/gvcf/"


for i in $(cat $chrom)
do

  #create a list with all the g.vcf for the chromosome within the loop
    gvcfLIST=$(ls ${list}*/*${i}.g.vcf) 
    
  # generate the line for gatk with the variant name. Actually, all gvcfLIST could 
  #  be passed in the for loop but it is better to have the list o be able to see what have you created
    varString=$(for gvcf in $gvcfLIST; do; echo "--variant ${gvcf} "; done) 

  # Run GATK 
    $gatk CombineGVCFs --reference $ref \
    $varString \ 
    --convert-to-base-pair-resolution \
    --output "$out""$i".g.vcf.gz
  done

#$gatk CombineGVCFs --reference $ref \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 1p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 2p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 3p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 4p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 5p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 6p) \
#--variant $(ls "$list"*/*"$i"*.g.vcf | sed -n 7p) \
#--convert-to-base-pair-resolution \
#--output "$out""$i".g.vcf.gz
#done

#this $(ls *g.vcf | sed -n 1p) command will look in our directory for all the files finishing in g.vcf and will select the first one, when is 2p will
#select the second one and so on. You'll have to create as many variant as number of samples you have, maybe we need to find a better solution for this step!

#finally, we make the SNP calling on the combined file to obtain the VCF:
for i in $(cat $chrom);
do
$gatk GenotypeGVCFs --reference $reference --variant $i.g.vcf.gz --include-non-variant-sites --output final_dataset_"$i".vcf.gz
done

#concatenar
bcftools concat final_dataset*.vcf.gz -o final_file.vcf.gz





