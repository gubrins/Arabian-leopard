awk '{$1=0;print $0}' output_name.bim > output_name.bim.tmp
mv output_name.bim.tmp output_name.bim
