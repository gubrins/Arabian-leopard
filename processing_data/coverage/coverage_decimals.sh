samtools depth -a file.bam |  awk '{sum+=$3} END { print "Average = ",sum/NR}' > coverage.txt
