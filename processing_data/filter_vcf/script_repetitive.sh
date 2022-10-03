cat $fasta | python scan_characters.py actg | bedtools merge -i - > lower_case_positions.bed
