#First of all, you convert the bam file into fq. IMPORTANT, set -d and -D to a third and double the averaged coverage of your sample!
samtools mpileup -C50 -uf reference_genome.fna file.bam |bcftools call -c -  |vcfutils.pl vcf2fq -d 3 -D 30 |gzip > diploid.fq.gz

#if samtools mpileup deprecated, use:
bcftools mpileup -C50 -f ...
