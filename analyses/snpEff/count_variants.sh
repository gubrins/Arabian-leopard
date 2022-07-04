#before they were looking for the field EFF, now, from version 4.1, we need to look for the ANN field:

cat output.ann.vcf \
| cut -f 8 \
| tr ";" "\n" \
| grep ^ANN= \
| cut -f 2 -d = \
| tr "," "\n" \
| grep MODIFIER \
| wc -l



for i in $(bcftools query -l max_missing1_all_leopards.vcf.gz); 
do
cd $i
echo $i 
#zcat $i.vcf.gz |grep -v "#" |wc -lecho "0_0"
zcat "$i"_results_0_0.vcf.gz\
    | cut -f 8 \
    | grep -v "#" \
    | tr ";" "\n" \
    | grep ^ANN= \
    | cut -f 2 -d = \
    | tr "," "\n" \
    | grep MODERATE \
    | wc -l
echo ""

echo "1_1"
zcat "$i"_results_1_1.vcf.gz\
    | cut -f 8 \
    | grep -v "#" \
    | tr ";" "\n" \
    | grep ^ANN= \
    | cut -f 2 -d = \
    | tr "," "\n" \
    | grep MODERATE \
    | wc -l
echo ""
echo "0_1"
zcat "$i"_results_0_1.vcf.gz\
    | cut -f 8 \
    | grep -v "#" \
    | tr ";" "\n" \
    | grep ^ANN= \
    | cut -f 2 -d = \
    | tr "," "\n" \
    | grep MODERATE \
    | wc -l
echo ""
echo ""

cd ..
done
