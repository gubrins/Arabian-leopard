samples="/home/panthera/gabri/leopards/analisis/autosomes/phylogeny/samples.txt"
location_bams="/mnt/DiscoB/leopards/bams/"
windows="1MB_bed.txt"

for sample in $(cat $samples);
do
for window in $(cat $windows);
do
samtools view -b "$location_bams""$sample" $window > results/windows_bams/"$sample"_"$window".bam
done
done
