{rm(list=ls())
library(ggplot2)
}

data = read.table("coverage.txt")
data$V2 = as.integer(data$V2)
data$V3 = as.integer(data$V3)
data = data[complete.cases(data),]

ggplot(data2, aes(V2,V3)) + geom_line(size=1.5) + theme_classic() + xlim(c(0,26)) + geom_point(size=4)
