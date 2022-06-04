cat output.ann.vcf \
| cut -f 8 \
| tr ";" "\n" \
| grep ^EFF= \
| cut -f 2 -d = \
| tr "," "\n" \
| grep MODIFIER \
| wc -l
