#you need to have the size for each chromosome of your genome:
bedtools makewindows -g sizes.genome -w 1000000 > 1MB.txt 

# First sed command changes the first 'tab' to ':', the second one changes the subsequent one to '-' and stores it to bed file.
sed 's/\t/:/1' 1MB.txt | sed 's/\t/-/1' > 1MB_bed.txt



#then you need to put them in bed format: (maybe there is a better way)
#cut -f 1 1MB.txt > 1.txt
#cut -f 2 1MB.txt > 2.txt
#cut -f 3 1MB.txt > 3.txt

#paste -d: 1.txt 2.txt > 12.txt
#paste -d- 12.txt 3.txt > 1MB_bed.txt
