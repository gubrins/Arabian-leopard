#Once you have your heterozigosity file, in R, you open it and create two columns:

df = read.table("nepal.txt", sep ="\t")
df_noNA = na.omit(df)

df$ini = df$V2-50000  
df$end = df$V2+49999
df[1,7] = 99999

df$ini = as.integer(df$ini)
df$end = as.integer(df$end)

write.table(df,"in_out_roh.txt",col.names = F,row.names = F,quote = F)


#after that, in bash:

cat in_out_roh.txt|cut -f 1,6,7 -d" "> 1.txt
cat in_out_roh.txt|cut -f 3,4,5 -d" "> 2.txt
pr -mts " " 1.txt 2.txt > 3.txt
cat 3.txt |sed 's/ /\t/g' > 3_tabs.txt

#and finally:

bedtools intersect -a 3_tabs.txt -b coordinates2.txt -wa > in_roh.txt
bedtools intersect -v -a 3_tabs.txt -b coordinates2.txt -wa > out_roh.txt

#where coordinates is a file like this:
#chrom start  end
NC_018723.3	203270	441160
NC_018723.3	624960	695520
NC_018723.3	756696	977820
NC_018723.3	1005429	1221086
