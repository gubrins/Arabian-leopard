for i in $(seq 1 10);
do
/home/panthera/software/psmc/psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" -o round-"$i".psmc split.psmcfa
done


#then, we have to combine all these files called round (which will be the bootstrapping) with the original PSMC of the individual:

cat round* diploid.psmc > combined_bootstrap.psmc

#and then we plot it:

psmc_plot.pl -u 1.1e-8 -g 5 output combined_boostrap.psmc
