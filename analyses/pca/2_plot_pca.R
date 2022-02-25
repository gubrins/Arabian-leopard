{rm(list=ls())
library(tidyverse)
library(ggplot2)
library(plotly)
library(dplyr)
setwd("~/Dropbox/gabriel/projectes/leopards/autosomes/DECEMBER/pca/as_before_biallelics_january")
}

pca <- read_table2("pca.eigenvec", col_names = FALSE)
eigenval <- scan("pca.eigenval")
pca <- pca[,-1]

names(pca)[1] <- "ind"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))
pca[,2:20] = pca[,2:20] * -1
col <- read.table("col.txt", header=T)
pca <- as.tibble(data.frame(pca, col$species))
names(pca)[22] <- "Leopards"

pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + theme_classic() + xlab("") + ylab("") + xlim(c(0,15)) + theme(axis.text.x = element_blank(),axis.ticks.x = element_blank(),axis.text.y = element_blank())

b <- ggplot(pca, aes(PC1, PC2, label=ind, colour=Leopards,fill=Leopards)) + geom_point(color="black",size = 5,shape=21)+ 
   theme_light()+ xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)"))+
  ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)")) +
  theme_classic() + theme(panel.border = element_rect(colour = "black", fill=NA, size=2), 
  panel.grid.major = element_blank(), 
  panel.grid.minor = element_blank(), 
  axis.line = element_line(colour = "black"),plot.title = element_text(hjust = 0.5)) + ggtitle("PCA for all leopards (2.06M SNPs)") +
  scale_fill_manual(values = c("light blue", "#EACE6A", "light green", "red", "violet","black")) #+ geom_mark_ellipse(aes(fill=Leopards,filter = Leopards == "African leopard"))

ggplotly(b)
