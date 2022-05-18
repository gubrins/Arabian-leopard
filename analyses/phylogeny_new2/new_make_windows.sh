#create a file with the total genome length:
whole	2329000000

bedtools makewindows -g trial.txt -w 100000 > asd.txt

cut -f2 asd.txt > 2.txt
cut -f3 asd.txt > 3.txt

paste -d- 2.txt 3.txt > 23.txt

