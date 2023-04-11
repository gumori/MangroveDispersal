# mantel test script adapted from Bergmann and McElroy 2014 for asymmetrical matrices
# -----------------------------------------------------------------------------------------------
# This function does a classical Mantel test, comparing the lower triangle of two matrices, a modified version of the Mantel test,
# where input is a symmetrical matrix and the diagonal is informative, a modified version similar to the previous, but where 
# the cells of the diagonal are randomized separately from those of the off-diagonal, and a modified mantel test where the 
# entire matrix is informative and can be square or rectangular. The test uses the lower triangle, lower triangle and 
# diagonal, or whole matrix to calculate a pearson correlation, then randomizes the first matrix s times to calculate a p-value.

# x_mat and y_mat are input matrices, s is number of randomizations, type is the type of mantel
# tri is just one triangle, diag is a triangle with an informative diagonal, d_s is when diagonal is informative 
# but randomized separately from the off diagonal, and whole is when the whole matrix is informative

mantel <- function(x_mat,y_mat,s,type=c("tri","diag","d_s","whole")) {
  
  # Calculate the number of rows and columns in your matrices
  nrow <- dim(x_mat)[1]
  ncol <- dim(x_mat)[2]
  
  # Linearize the two matrices into vectors, containing the appropriate parts of the matrices
  x_lin <- NULL
  y_lin <- NULL
  
  if (type=="tri") {
    for (i in (1:ncol-1)) {
      temp <- x_mat[(i+1):ncol,i]
      x_lin <- c(x_lin,temp)}
    x_lin_all <- x_lin
    for (i in (1:ncol-1)) {
      temp <- y_mat[(i+1):ncol,i]
      y_lin <- c(y_lin,temp)}
    y_lin_all <- y_lin
  }
  
  if (type=="diag"){
    for (i in 1:ncol) {
      temp <- x_mat[i:ncol,i]
      x_lin <- c(x_lin,temp)}
    x_lin_all <- x_lin
    for (i in 1:ncol) {
      temp <- y_mat[i:ncol,i]
      y_lin <- c(y_lin,temp)}
    y_lin_all <- y_lin
  }
  
  if (type=="d_s"){
    x_diag_lin <- rep(NA,ncol)
    y_diag_lin <- rep(NA,ncol)
    
    for (i in (1:ncol-1)) {
      temp <- x_mat[(i+1):ncol,i]
      x_lin <- c(x_lin,temp)}
    for (i in 1:ncol) {
      x_diag_lin[i] <- x_mat[i,i]}
    x_lin_all <- NULL
    x_lin_all <- c(x_lin,x_diag_lin)
    
    for (i in (1:ncol-1)) {
      temp <- y_mat[(i+1):ncol,i]
      y_lin <- c(y_lin,temp)}
    for (i in 1:ncol) {
      y_diag_lin[i] <- y_mat[i,i]}
    y_lin_all <- NULL
    y_lin_all <- c(y_lin,y_diag_lin)
  }
  
  
  if (type=="whole") {
    for (i in 1:ncol) {
      temp <- x_mat[,i]
      x_lin <- c(x_lin,temp)}
    x_lin_all <- x_lin
    for (i in 1:ncol) {
      temp <- y_mat[,i]
      y_lin <- c(y_lin,temp)}
    y_lin_all <- y_lin
  }
  
  # Calculate the Mantel test statistic as the pearson correlation between the two linearized matrices
  mantel_stat <- cor(x_lin_all,y_lin_all,method="pearson")
  
  # Permute the linearized x matrix s times to give randomized data pairs, if type is d_s, then the diagonals and off diagonals
  # are randomized separately. For all other types of test all entries are fully randomized.
  
  if (type=="d_s"){
    rnd_off_diags <- rep(NA,length(x_lin)*s)
    dim(rnd_off_diags) <- c(length(x_lin),s)
    rnd_diags <- rep(NA,length(x_diag_lin)*s)
    dim(rnd_diags) <- c(length(x_diag_lin),s)
    for (i in 1:s) {
      rnd_off_diags[,i] <- sample(x_lin,length(x_lin),replace=FALSE)
      rnd_diags[,i] <- sample(x_diag_lin,length(x_diag_lin),replace=FALSE)
    }
    rand_xlin <- rbind(rnd_off_diags,rnd_diags)
  }
  
  else {
    rand_xlin <- rep(NA,length(x_lin_all)*s)
    dim(rand_xlin) <- c(length(x_lin_all),s)
    for (i in 1:s) {
      rand_xlin[,i] <- sample(x_lin_all,length(x_lin_all),replace=FALSE)}
  }
  
  # Calculate pearson correlations for each randomized dataset and output into the null distribution vector
  null_dist <- NULL
  for (i in 1:s) {
    null_dist[i] <- cor(rand_xlin[,i],y_lin_all,method="pearson")}
  
  # Calculate the p-value of the mantel_stat given the null distribution using a 2-tailed test
  null_median <- median(null_dist)
  if (mantel_stat < null_median)
  {pval <- 2*(sum(null_dist < mantel_stat) / length(null_dist))} else
  {pval <- 2*(sum(null_dist > mantel_stat) / length(null_dist))}
  
  # Compile results
  results <- c(mantel_stat,pval,ncol,nrow,s)
  names(results) <- c("R","p","ncol","nrow","nreps")
  results
  
}

#from here onward, we run our analysis
library(globe)

fsc <- read.table('fsc_data.csv', header=T)
adrift <- read.table('adrift_data.csv', header=T)
opendrift <- read.table('opendrift_data_prob.txt', header=T)
inwater <- read.table('In-water_distance.txt', header=T)

sites <- read.table("coordinates.txt", header=TRUE)
geo <- sites[, c(2:3)]
geo$CAR <- spatialpos(geo$LAT, geo$LONG) # Tranform geographic coordinates into cartesian coordinates; order is Lat, Long
euclidian_distances <- dist(geo$CAR, method="euclidean")
euclidian_distances <- as.matrix(euclidian_distances)

#now, we REMOVE THE DIAGONALS of adrift and opendrift data. This is done so the elements that stay in the sites do not influence the analysis
diag(adrift)=0
diag(opendrift)=0

mantel(fsc, opendrift, 99999, type = 'whole')
mantel(fsc, adrift, 99999, type = 'whole')
mantel(fsc, euclidian_distances, 99999, type = 'whole')
mantel(fsc, inwater, 99999, type = 'whole')
mantel(opendrift, adrift, 99999, type = 'whole')