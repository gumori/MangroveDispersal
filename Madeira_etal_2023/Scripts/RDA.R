library(vegan)
library(vcfR)
library(SoDA)
library(adespatial)
library(ggplot2)
library(kableExtra)
library(reshape2)

allele_frequencies <- read.table("Rmangle.recode.frq.strat", header=T, sep="\t", dec=".")

allele_frequencies2 <- allele_frequencies[,2:3]
allele_frequencies3 <- cbind(allele_frequencies2, allele_frequencies$MAF)
colnames(allele_frequencies3)=c("SNP","POP","MAF")

allele_frequencies4 <- dcast(allele_frequencies3, POP~SNP)
write.table(allele_frequencies4, "Rmangle-freq-sites.txt", quote=F, sep="\t")

geno <- read.table("Rmangle-freq-sites.txt", header=TRUE)

geno <- geno[,-1]
geno.h <- decostand(geno, "hellinger")
geno.h <- geno.h[, colSums(geno.h != 0) > 0]
geno.pca <- prcomp(geno.h, scale = T)
summary(geno.pca)

#this gave us 11 components
#now choosing how many to keep
screeplot(geno.pca, npcs = 20, type = "lines", bstick = T) #this suggests 4PCs
ev <- geno.pca$sdev^2
ev
ev[ev > mean(ev)]  #this also suggests 4PCs

geno.pca.axes <- geno.pca$x[,1:4] # select 4 PC axes
head(geno.pca.axes)

write.table(geno.pca.axes, "Rmangle-PCA-axes.txt", quote=F, sep="\t")

###RDA###
#1) euclidian

dbMEM.vectors <- read.table("dbMEM_straight_all_vectors.txt", header=TRUE)
geno.pca.axes <- read.table("Rmangle-PCA-axes.txt", header=TRUE)

dbmem.mod0 <- rda(geno.pca.axes ~1, dbMEM.vectors)
dbmem.mod1 <- rda(geno.pca.axes ~., dbMEM.vectors)

dbmem.all.ord <- ordistep(dbmem.mod0, scope = formula(dbmem.mod1), direction = "both", permutations = 10000)
dbmem.all.ord
dbmem.all.ord$anova
#Df    AIC      F Pr(>F)  
#+ MEM1  1 88.105 1.7157  0.049 *
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

dbmem.sub <- dbMEM.vectors[,c(1)] # the dbMEM vectors selected by ordistep

dbmem.mod.sel <- rda(geno.pca.axes ~., as.data.frame(dbmem.sub))
summary(dbmem.mod.sel)
RsquareAdj(dbmem.mod.sel) 
anova(dbmem.mod.sel, permutations = 999)
anova(dbmem.mod.sel, by = "margin", permutations = 999)
anova(dbmem.mod.sel, by = "axis", permutations = 999)

plot(dbmem.mod.sel)

summary(dbmem.mod.sel)

#2) In-water

dbmem.water.mod0 <- rda(geno.pca.axes ~1, dbMEM.vectors.inwater)
dbmem.water.mod1 <- rda(geno.pca.axes ~., dbMEM.vectors.inwater)
summary(dbmem.water.mod1)

dbmem.water.all.ord <- ordistep(dbmem.water.mod0, scope = formula(dbmem.water.mod1), direction = "forward", permutations = 999)
dbmem.water.all.ord

dbmem.water.all.ord$anova
#Df    AIC      F Pr(>F)  
#+ MEM1   1 88.100 1.7200  0.044 *
#  + MEM10  1 87.069 2.5386  0.049 *
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

dbmem.water.sub <- dbMEM.vectors.inwater[,c(1,10)] # the dbMEM vectors selected by ordistep

dbmem.water.mod.sel <- rda(geno.pca.axes ~., as.data.frame(dbmem.water.sub))
summary(dbmem.water.mod.sel)

RsquareAdj(dbmem.water.mod.sel)
anova(dbmem.water.mod.sel, permutations = 999)
anova(dbmem.water.mod.sel, by = "margin", permutations = 999)
anova(dbmem.water.mod.sel, by = "axis", permutations = 999)

summary(dbmem.water.mod.sel)

#3) AEM

AEM.vectors.wt <- read.table("AEM_weight_all_vectors_opendrift.txt", header=TRUE)
AEM.vectors.wt.fsc <- read.table("AEM_weight_all_vectors_fsc.txt", header=TRUE)

aem.mod0 <- rda(AEM.vectors.wt.fsc~1, AEM.vectors.wt)
aem.mod1 <- rda(AEM.vectors.wt.fsc ~., AEM.vectors.wt)
summary(aem.mod1)

aem.sel.ord <- ordistep(aem.mod0, scope = formula(aem.mod1), direction = "forward", permutations = 999)
aem.sel.ord
aem.sel.ord$anova
#Df    AIC      F Pr(>F)  
#+ V1  1 87.935 1.8822  0.038 *
#  ---
#  Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

aem.sub <- AEM.vectors.wt[,c(1)]

mod.sel <- rda(AEM.vectors.wt.fsc ~., as.data.frame(aem.sub))
summary(mod.sel)
anova(mod.sel, permuations = 999)  
anova(mod.sel, by = "margin", permutations = 999) 
anova(mod.sel, by = "axis", permutations = 999)
RsquareAdj(mod.sel)