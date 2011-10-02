data <- read.table("dataset.txt", sep="\t", header=FALSE)
colnames(data) <-  c("node1","node2","begin","end")

data2 <- read.table("data.txt",sep=" ",header=FALSE)
colnames(data2) <- c("id","moyenne","total","effectif")

#Normalisation

data2$moyenne <- ( data2$moyenne - mean( data2$moyenne ) )/sd(data2$moyenne)
data2$total <- ( data2$total - mean( data2$total ) )/sd(data2$total)
data2$effectif <- ( data2$effectif - mean( data2$effectif ) )/sd(data2$effectif)

write.csv2( data2, file = 'data2.txt', eol='\n'  )
#res = unlist(lapply(unique(data$node1), function(x){sum(data$duration[data$node1 == x])}))

#for(i in 1:length(data[[1]])) res[[data$node1[i]]] = res[[data$node1[i]]]+data$end[i]-data$begin[i]

## ANOVA 
#
#aov_lines_commit <- aov( data_merged$lines ~ data_merged$commit )
#aov_lines_diff_commiters <- aov( data_merged$lines ~ data_merged$diff_commiters )
#aov_commit_diff_commiters <- aov( data_merged$commit ~ data_merged$diff_commiters )
#
#capture.output( aov_lines_commit, file = 'aov_lines_commit.txt' )
#capture.output( aov_lines_diff_commiters, file = 'aov_lines_diff_commiters.txt' )
#capture.output( aov_commit_diff_commiters, file = 'aov_commit_diff_commiters.txt' )
#
#capture.output( summary(aov_lines_diff_commiters), file = 'summary_aov_lines_diff_commiters.txt' )
#capture.output( summary(aov_commit_lines), file = 'summary_aov_commit_lines.txt' )
#capture.output( summary(aov_commit_diff_commiters), file = 'summary_aov_commit_diff_commiters.txt' )
#
#
#jpeg( filename = 'img/aov_lines_commit.jpeg' )
#plot( aov_lines_commit )
#dev.off()
#
#jpeg( filename = 'img/aov_lines_diff_commiters.jpeg' )
#plot ( aov_lines_diff_commiters )
#dev.off()
#
#jpeg( filename = 'img/aov_commit_diff_commiters.jpeg' )
#plot( aov_commit_diff_commiters )
#dev.off()
#
## Regression exp
#
#f <- function( x, a, b ){ a * exp( b * x ) }
##fm <- nls( y ~ f( x, a, b ), data = data_merged_sortby_lines, start = c( a=1, b=1 )) 
#
## Quantile regression
#
#rq_commit_line_0.1 <- rq( commit ~ lines , tau = 0.1 )
#rq_commit_line_0.5 <- rq( commit ~ lines , tau = 0.5 )
#rq_commit_line_0.9 <- rq( commit ~ lines , tau = 0.9 )
#
## K-medians (ROBUST) 
#
#data_merged.clara.silcoeff <- numeric(10)
#
#for( k in  2:10 ) 
#{
#	data_merged.clara.silcoeff [k] <- 
#	summary( silhouette( clara( data_num[,c(-4)], k ) ) )$avg.width
#}
#rm(k)
#
#jpeg( filename='img/clara_clustering.jpeg')
#plot(data_merged.clara.silcoeff)
#dev.off()
#
### Best choice k = 2
#
#data_merged.clara <- clara( data_num[,c(-3,-4)], 2 )
#data_merged.outliers <- data_merged[ clara( data_num[,c(-4)], 2 )$clustering == 2, ]
#data_merged.outliers_sortby_lines <- data_merged.outliers[order( data_merged.outliers$lines, decreasing=TRUE ), ]
#
#jpeg( filename='img/clara.jpeg' )
#plot( data_merged.clara )
#dev.off()
#
## Principal composant analysis 
#
## stat package
#
#pca <- prcomp( data_num )
#names( pca )
#
#jpeg( filename='img/pca.jpeg' )
#biplot( pca )
#dev.off()
#
#jpeg( filename='img/pca2.jpeg' )
#pca2 <- princomp( data_num )
#biplot( pca2 )
#dev.off()
#
#
#capture.output( summary(pca) , file='../summary_pca.txt' )
#capture.output( pca, file='../pca.txt' )
#
#
#data_num_c <- data_merged_c[,c(-1,-5,-6)]
#
#jpeg( filename = 'img/pca_c.jpeg' )
#pca_c <-  prcomp( data_num_c )
#biplot( pca_c )
#dev.off()
#
#capture.output( summary(pca_c) , file='../summary_pca_c.txt' )
#capture.output( pca_c, file='../pca_c.txt' )
#
## pca( H file )
#
#data_num_h <- data_merged_h[,c(-1,-5,-6)]
#
#jpeg( filename = 'img/pca_h.jpeg' )
#pca_h <- prcomp( data_num_h )
#biplot( pca_h )
#dev.off()
#
#capture.output( summary(pca_h), file = '../summary_pca_h.txt' )
#capture.output( pca_h, file = '../pca_h.txt' )
#
## anova ( c file )
#
#data_merged_c_aov_lines_commit <- aov( data_merged_c$lines ~ data_merged_c$commit )
#data_merged_c_aov_lines_diff_commiters <- aov( data_merged_c$lines ~ data_merged_c$diff_commiters )
#data_merged_c_aov_commit_diff_commiters <- aov( data_merged_c$commit ~ data_merged_c$diff_commiters )
#
#capture.output( data_merged_c_aov_lines_commit, file = 'data_merged_c_aov_lines_commit.txt' )
#capture.output( data_merged_c_aov_lines_diff_commiters, file = 'data_merged_c_aov_lines_diff_commiters.txt' )
#capture.output( data_merged_c_aov_commit_diff_commiters, file = 'data_merged_c_aov_commit_diff_commiters.txt' )
#
#capture.output( summary(data_merged_c_aov_lines_diff_commiters), file = 'data_merged_c_summary_aov_lines_diff_commiters.txt' )
#capture.output( summary(data_merged_c_aov_lines_commit), file = 'data_merged_c_summary_aov_lines_commit.txt' )
#capture.output( summary(data_merged_c_aov_commit_diff_commiters), file = 'data_merged_c_summary_aov_commit_diff_commiters.txt' )
#
## anova ( h file )
#
#data_merged_h_aov_lines_commit <- aov( data_merged_h$lines ~ data_merged_h$commit )
#data_merged_h_aov_lines_diff_commiters <- aov( data_merged_h$lines ~ data_merged_h$diff_commiters )
#data_merged_h_aov_commit_diff_commiters <- aov( data_merged_h$commit ~ data_merged_h$diff_commiters )
#
#capture.output( data_merged_h_aov_lines_commit, file = 'data_merged_h_aov_lines_commit.txt' )
#capture.output( data_merged_h_aov_lines_diff_commiters, file = 'data_merged_h_aov_lines_diff_commiters.txt' )
#capture.output( data_merged_h_aov_commit_diff_commiters, file = 'data_merged_h_aov_commit_diff_commiters.txt' )
#
#capture.output( summary(data_merged_h_aov_lines_diff_commiters), file = 'data_merged_h_summary_aov_lines_diff_commiters.txt' )
#capture.output( summary(data_merged_h_aov_lines_commit), file = 'data_merged_h_summary_aov_lines_commit.txt' )
#capture.output( summary(data_merged_h_aov_commit_diff_commiters), file = 'data_merged_h_summary_aov_commit_diff_commiters.txt' )
#
########################### Graphes #########################
#
#jpeg( filename='img/plot.jpeg' )
#plot( data_num, main='Damier des plots' ) # Damier de graphes
#dev.off()
#
#
### Histogrammes
#
#jpeg( filename='img/histogramme.jpeg' )
#hist(	data_merged[[5]],
#	main='Histogramme log(lines)',
#	xlab='log(lines)',
#	ylab='Effectif'	
#) # Histogramme du vecteur log_line (Normal saikks)
#dev.off()
#
## Il faut en faire plein avec l'utilisation du log des 
## valeurs intéressantes
#
#
#jpeg(filename='barplot.jpeg')
#barplot(data_merged[[3]]) # Le graphe est chaotique
#dev.off()
#
## QQ-plot 
#
#jpeg( filename='img/qqplot_commit_lines.jpeg' )
#qqplot( commit, lines ) 
#dev.off()
#
#jpeg( filename='img/qqplot_commit_diff_commiters.jpeg' )
#qqplot( commit, diff_commiters )
#dev.off()
#
#jpeg( filename='img/qqplot_lines_diff_commiters.jpeg' )
#qqplot( lines, diff_commiters )
#dev.off()
#
## Graphes bivariés
#
#jpeg( filename='img/pairs.jpeg' )
#pairs( data_merged, main='Graphes bivariés' )
#dev.off()
#
## Export to csv 
#
#write.csv2( data_merged, file = 'export/merged.log', eol='\n', na='NA' )
