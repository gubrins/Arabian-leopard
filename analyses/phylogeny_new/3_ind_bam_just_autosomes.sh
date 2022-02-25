location="/mnt/DiscoB/leopards/bams/"
samples="samples.txt"
autosomes="autosomes.txt"
out="/home/panthera/gabri/leopards/analisis/autosomes/phylogeny/results/alternativa_just_autosomes"

for sample in $(cat $samples);
do
id=$(echo $sample |cut -d. -f1)
(samtools view -b "$location""$sample" NC_0187{23..40}.3 > "$out"/"$id"_autosomes.bam) &
done
wait
