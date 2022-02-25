#First of all you need to create a fam, a bed and a bim file for your vcf:
plink --vcf file.vcf.gz --allow-extra-chr --double-id --make-bed --out output_name

#With plink, you create the .eigenvec and .eigenval files that you will use for the PCA:
plink --bfile output_name --double-id --allow-extra-chr --set-missing-var-ids @:# --make-bed --pca --out output_name_pca
