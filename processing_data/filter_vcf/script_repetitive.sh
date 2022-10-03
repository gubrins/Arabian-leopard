cat $fasta | python scan_characters.py actg | bedtools merge -i - > lower_case_positions.bed

bedtools intersect -v -a file.vcf -b lower_case_positions.bed |bgzip -c > filtered_file.vcf.gz
