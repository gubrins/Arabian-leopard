location="/mnt/DiscoB/leopards/bams/"
samples="samples.txt"
autosomes="autosomes.txt"
out="/home/panthera/gabri/leopards/analisis/autosomes/phylogeny/results/bams_per_chromosome/"

for sample in $(cat $samples);
do
for chr in $(cat $autosomes);
do
(samtools view -b "$location""$sample" "$chr" > "$out""$chr"/"$sample"_"$chr".bam ) &
done
wait
done
