d<-read.table("seti-output.txt",sep=",")
colnames(d) <-  c("x","nrml")

#Normalisation

hist( d$nrml, nclass=30,prob=TRUE)
lines(density(d$nrml[!is.na(d$nrml)]))
