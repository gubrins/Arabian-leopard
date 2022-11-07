#you need to count the number of Ns per sliding windows per individual:

/home/panthera/software/UCSC/faCount sliding_windows.txt |perl -ane 'next if(/\#/); print "$F[0]\t$F[1]\t$F[6]\t".($F[6]/($F[1]-$F[6]))."\n";' | tee -a all.txt

#and then, you open this with R and you just keep the ones with a proportion of missingness higher than 0.49:

data = read.table("all.txt")
windows_wHighMiss = data[data$V4>0.49,]

#again in linux, to keep unique windows without sample names:

sed 's/^.*sliding_//g' windows_wHighMiss.txt > windows_wHighMiss_nosamplenames.txt
sort windows_wHighMiss_nosamplenames.txt | uniq -w 20 | tee -a uniq_windows.txt
cat uniq_windows.txt | wc -l #to know how many do not pass the threshold

#we remove those windows before concatenating the trees

for undesired_window in $(cat uniq_windows.txt);
do
rm new_iqtree_vipera_:"$undesired_window".txt.treefile
done





