
   
location="/home/panthera/gabri/leopards/analisis/autosomes/phylogeny/results/alternativa_just_autosomes/"

for i in $(ls "$location"*bam);
do
id=$(echo $i |cut -d/ -f11) 
id2=$(echo $id | cut -d. -f1 )
(angsd -i $i -doFasta 3 -out "$location"angsd/$id2) &
done
wait
