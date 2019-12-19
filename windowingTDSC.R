library(parallel)
library(sonicscrewdriver)
library(tuneR)
library(tdsc)
library(ggplot2)

#Initialise cluster
cl <- defaultCluster()

#Read wave
wave <- readWave("speechCricket.wav")

#Apply windowing function
d <- windowing(wave=wave, window.length=tSamples(0.2, wave=wave), FUN=tdsc.w, cluster=cl)

#Extract A Matrices
a_matrices <- sapply(d, function(x) as.vector(x@a_matrix))

#Prepare for k means
a_matrices <- t(simplify2array(a_matrices))

km<- kmeans(a_matrices, centers=3)

#Plot
r <- rep(km$cluster, each=tSamples(0.2, wave = wave))
df  <- data.frame(x=1:length(wave@left),y=wave@left,col=rainbow(3)[r[1:length(wave@left)]])

plt <- ggplot(df[c(rep(FALSE, 9), TRUE),], aes(x=x,y=y,group=1)) + 
  geom_line(aes(colour=col), show.legend = FALSE) + 
  theme_void()
print(plt)

#Cleanup
stopCluster(cl)
