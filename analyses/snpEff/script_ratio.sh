#You get the vcf with the samples from the same population.
bcftools view -S samples.txt vcf.file > samples.vcf 
#it is important that the vcf file has no missing data!

#Then, you run the snpEFF on those samples:
java -jar /home/panthera/gabri/leopards/new_gvcf/analyses/snpEff_v4_3t_core/snpEff/snpEff.jar -v cat3_final vcf.file |bgzip -c > out.vcf

#then, you select the category you want:
zcat out.vcf |grep "HIGH" >out_high.vcf


#then, you need to join all the comments from the previos vcf file:
cat out.vcf |grep "#" > comments.txt
cat comments.txt out_high.vcf > comments_out_high.vcf

#We run the vcf2eigenstrat script:
bash vcf2eigenstrat.sh comments_out_high.vcf

#we get the frequency:
cut -f1 eigenstrat.geno | sort| uniq -c |sort -nr |sed 's/    //g'> uniq.txt
#ATTENTION, you should check if there is any space between the start of the line and the first number, if so, remove it!
#Run this in this order to remove spaces:
sed -i 's/  //g' uniq.txt
sed -i 's/^ //g' uniq.txt
#if there are more, increase the number of spaces within the sed command


#we select the second column, 
cat uniq.txt |cut -f 2 -d " " > final_uniq.txt

#and we count the number of 1 that appear:
for i in $(cat final_uniq.txt); do echo $i |tr -cd '1' |wc -c; done
#this print needs to be saved in a different file, which I call total_counts_high_africans.txt in the R script

#get the frequency:
cut -f1 -d" " uniq.txt > frequency.txt
