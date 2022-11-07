#you need to count the number of Ns per sliding windows per individual:

/home/panthera/software/UCSC/faCount sliding_windows.txt |perl -ane 'next if(/\#/); print "$F[0]\t$F[1]\t$F[6]\t".($F[6]/($F[1]-$F[6]))."\n";'

#and then, you open this with R and you just keep the ones with a proportion of missingness higher than 0.49:

data = read.table("all.txt")
data = data[data$V4>0.49,]
