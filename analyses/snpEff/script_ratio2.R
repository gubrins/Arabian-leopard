{rm(list=ls())
setwd("~/Dropbox/gabriel/projectes/leopards/autosomes/DECEMBER/final/mutational load/ratio/high")
}

af_total_counts = read.table("total_counts_high_africans.txt")
af_frequency = read.table("frequency_africans.txt")
af_frequency$asd = af_total_counts$V1 * af_frequency$V1
sum(af_frequency$asd)
derived_african = sum(af_frequency$asd) #7534

as_total_counts = read.table("total_counts_asian_high.txt")
as_frequency = read.table("frequency_asian_high.txt")
as_frequency$asd = as_total_counts$V1 * as_frequency$V1
sum(as_frequency$asd)
derived_asian = sum(as_frequency$asd) #9965


ar_total_counts = read.table("total_count_arab_high.txt")
ar_frequency = read.table("frequency_arab_high.txt")
ar_frequency$asd = ar_total_counts$V1 * ar_frequency$V1
sum(ar_frequency$asd)
derived_arabian = sum(ar_frequency$asd) #1812



ratio_arabics = derived_arabian/(10354160*4)
ratio_african = derived_african / (10354160*16)
ratio_asian = derived_asian / (10354160*20)

#Arabics and africans
F_arabics_africans = ratio_arabics * (1 - ratio_african)
F_africans_arabics = ratio_african * (1 - ratio_arabics)

R_arabics_africans = F_arabics_africans / F_africans_arabics
R_arabics_africans #0.96

#Arabics and asiatics
F_arabics_asiatics = ratio_arabics * (1 - ratio_asian)
F_asiatics_arabics = ratio_asian * (1 - ratio_arabics)

R_arabics_asiatics = F_arabics_asiatics / F_asiatics_arabics
R_arabics_asiatics #0.90

#Asiatics and africans
F_asiatics_africans = ratio_asian * (1 - ratio_african)
F_african_asiatics = ratio_african * (1 - ratio_asian)

R_asiatic_african = F_asiatics_africans / F_african_asiatics
R_asiatic_african #1.05
