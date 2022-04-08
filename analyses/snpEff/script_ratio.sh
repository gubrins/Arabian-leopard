#You get the vcf with the samples from the same population.
bcftools view -S samples.txt vcf.file > samples.vcf

#Then, you run the snpEFF on those samples:
java -jar snpEff_v4_3t_core/snpEff/snpEff.jar -v cat3_final vcf.file > out.vcf

#then, you select the category you want:
cat out.vcf |grep HIGH > out_high.vcf

#then, you need to join all the comments from the previos vcf file:
cat out.vcf |grep "#" > comments.txt
cat comments.txt out_high.vcf > comments_out_high.vcf

#We run the vcf2eigenstrat script:
bash vcf2eigenstrat.sh comments_out_high.vcf

#we get the frequency:
cut -f1 eigenstrat.geno | sort| uniq -c |sort -nr |sed 's/    //g'> uniq.txt

#we select the second column, ATTENTION, you should check if there is any space between the start of the line and the first number, if so, remove it!
cat uniq.txt |cut -f 2 -d " " > final_uniq.txt

#and we count the number of 1 that appear:
for i in $(cat final_uniq.txt); do echo $i |tr -cd '1' |wc -c; done

#get the frequency:
cut -f1 -d" " uniq.txt > frequency.txt
