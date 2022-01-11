for i in $(cat sample_names.txt)
do
fastp -i "$dir""$i"_1.fastq.gz -I "$dir""$i"_2.fastq.gz -o "$dir"fastp/"$i"_1_fastp30.fastq.gz -O "$dir"fastp/"$i"_2_fastp30.fastq.gz \
--detect_adapter_for_pe --correction --trim_poly_g --trim_poly_x -p --thread 2 --qualified_quality_phred 30 --adapter_sequence AGATCGGAAGAG \
--adapter_sequence_r2 AGATCGGAAGAG
done
