samtools depth file.bam |  awk '{sum+=$3} END { print "Average = ",sum/NR}'
