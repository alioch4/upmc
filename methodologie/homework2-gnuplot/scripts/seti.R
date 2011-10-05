shape=0.3787
scale=3.0932

d<-read.table("seti-output.txt",sep=",")
colnames(d) <-  c("x","nrml")

pdf(file='../img/part2.pdf')
hist( d$nrml,
    nclass=30,
    prob=TRUE,
    main="Uptime time",
    ylim = c(0,1),
    xlab="Normalized time")
lines(density(d$nrml[!is.na(d$nrml)]))

dev.off()

