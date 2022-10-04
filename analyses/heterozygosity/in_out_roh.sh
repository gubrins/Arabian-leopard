#Once you have your heterozigosity file, in R, you open it and create two columns:

df = read.table("nepal.txt", sep ="\t")
df_noNA = na.omit(df)

df$ini = df$V2-50000  
df$end = df$V2+49999
df[1,7] = 99999

df$ini = as.integer(df$ini)
df$end = as.integer(df$end)

write.table(df,"in_out_roh.txt",col.names = F,row.names = F,quote = F)

#You also have to edit the rohs file in R:

roh_raw = read.table("nepal.txt")
roh_filtered = roh_raw[roh_raw$V8>70,]
write.table(roh_filtered,"roh_filtered.txt",sep=" ",row.names=F,col.names=F,quote=F)

#and in bash:
cat roh_filtered.txt |cut -f 3,4,5 -d" " > coordinates.txt

#after that, in bash:

cat in_out_roh.txt|cut -f 1,6,7 -d" "> 1.txt
cat in_out_roh.txt|cut -f 3,4,5 -d" "> 2.txt
paste 1.txt 2.txt > 3.txt
cat 3.txt |sed 's/ /\t/g' > 3_tabs.txt

#and finally:

bedtools intersect -a 3_tabs.txt -b coordinates.txt -wa > in_roh.txt
bedtools intersect -v -a 3_tabs.txt -b coordinates.txt -wa > out_roh.txt


