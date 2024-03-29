## LIBRARIES

library(vegan)
library(reshape2)
library(dplyr)
library(SoDA)
library(adespatial)
library(ade4)
library(spdep)


#### SITE GEOGRAPHIC COORDINATES

sites <- read.table("coordinates.txt", header=TRUE)
geo <- sites[, c(2:3)]
geo

geo$CAR <- geoXY(geo$LAT, geo$LONG) # Tranform geographic coordinates into cartesian coordinates; order is Lat, Long
geo

#### (1a) dbMEM VARIABLES (straight-line)

euclidian_distances <- dist(geo$CAR, method="euclidean")
dbMEM <- dbmem(euclidian_distances, MEM.autocor = "non-null", store.listw = TRUE)
names(dbMEM)
dbMEM.vectors <- as.data.frame(dbMEM)
dbMEM.vectors

write.table(dbMEM.vectors, file = "dbMEM_straight_all_vectors.txt", col.names = T, row.names = F, quote = F, sep = "\t")


#### (1b) dbMEM VARIABLES (in-water)

in.sea <- read.table(file = "insea_matrix.txt", header = T)
rownames(in.sea) <- in.sea[,1]
in.sea <- in.sea[,-1]

names <- as.vector(sites$SITE)

in.sea.mat <- as.matrix(in.sea)
in.sea.mat <- in.sea.mat[names,names]
in.sea.dist <- as.dist(in.sea.mat)

dbMEM.inwater <- dbmem(in.sea.dist, MEM.autocor = 'non-null', store.listw = TRUE)
dbMEM.vectors.inwater <- as.data.frame(dbMEM.inwater)
dbMEM.vectors.inwater

write.table(dbMEM.vectors.inwater, file = "dbMEM_inwater_all_vectors.txt", col.names = T, row.names = F, quote = F, sep = "\t")

#### (2) AEM VARIABLES

# connectivity matrix: 
con_mat <- read.table("opendrift_data_prob.txt", header = TRUE) # connectivity matrix based on dispersal/connectivity probabilities 
head(con_mat)
dim(con_mat)

con_mat <- as.matrix(con_mat)
head(con_mat) 
con_mat <- con_mat[as.vector(sites$Abb), as.vector(sites$Abb)]
#View(con_mat)

# highest probability between two sites: 
upper <- con_mat[upper.tri(con_mat, diag = TRUE)]
lower <- con_mat[lower.tri(con_mat, diag = TRUE)]

highest <- vector()

for (i in 1 : length(upper)) {
  if (upper[i] < lower[i]) {
    highest[i] <- lower[i]
  } else {
    highest[i] <- upper[i]
  }
}


# Replace the uppper matrix of con_mat with the highest values; lower matrix with 0s
con_mat2 <- con_mat
con_mat2[upper.tri(con_mat2, diag = TRUE)] <- highest

con_mat2[upper.tri(con_mat2, diag = TRUE)] == highest
head(con_mat2)

con_mat2[lower.tri(con_mat2, diag = T)] <- 0
diag(con_mat2) <- diag(con_mat)
dim(con_mat2)

## coords object: 
xy <- sites[,4:6]
xy$Nb <- seq(1, 20, 1)
xy <- xy[,c(4,3,2)]  # order is long, lat
xy

## links object: 
con_mat_ex <- expand.grid(con_mat2)
con_mat_ex$POP1 <- rep(colnames(con_mat2), each = 20)
con_mat_ex$POP2 <- rep(colnames(con_mat2), 20)
con_mat_ex$POP1id <- rep(seq(1,20,1), each = 20)
con_mat_ex$POP2id <- rep(seq(1,20,1), 20)

con_mat_ex$POP_id <- paste(con_mat_ex$POP1, con_mat_ex$POP2, sep = "-")
con_mat_ex <- con_mat_ex[,-c(2,3)]
con_mat_ex
colnames(con_mat_ex) <- c("PROB", "POP1", "POP2", "PAIR")

con.mat.highest.prob.no0 <- filter(con_mat_ex, PROB > 0)
nrow(con.mat.highest.prob.no0)
head(con.mat.highest.prob.no0)

edges.highest.prob <- con.mat.highest.prob.no0[,c(2,3)]
edges.highest.prob
class(edges.highest.prob)

edges <- edges.highest.prob
edges
edges <- filter(edges, POP1 != POP2)
nrow(edges)

# create binary matrix:
bin.mat <- aem.build.binary(coords=xy,link=edges, plot.connexions = TRUE)
str(bin.mat)
bin.mat

# edge weights = dispersal probabilities:
weights <- filter(con.mat.highest.prob.no0, POP1 != POP2)
weight.vec <- as.vector(weights[,1])
length(weight.vec)

# calculate AEM variables: 
cuke.aem.wt <- adespatial::aem(aem.build.binary = bin.mat, weight = weight.vec, rm.link0 = TRUE)

AEM.vectors.wt <- as.data.frame(cuke.aem.wt$vectors)

write.table(AEM.vectors.wt, file = "AEM_weight_all_vectors.txt", sep = "\t", quote = F, col.names = T, row.names = F)