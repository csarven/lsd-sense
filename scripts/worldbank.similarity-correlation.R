#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i


library(ggplot2)

refPeriod <- c("2013")

dataPath <- c("../data/")
analysisPath <- paste0(dataPath, "analysis/")
plotPath <- paste0(dataPath, "plots/", "similarity-correlation", ".", refPeriod)

correlationMethod <- c("kendall")

cat("Get dataset similarities and correlations from each dataset\n")
dataX <- read.csv(paste0(analysisPath, "similarity", ".", refPeriod, ".csv"), na.strings='', header=T)
dataX <- dataX[!(dataX$similarity==-1 | dataX$similarity==1),]
dataX$similarity <- (dataX$similarity + 1)/2

#, colClasses=c(NA,NA,NA,'NULL','NULL')
dataY <- read.csv(paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), na.strings='', header=T)
dataY <- dataY[!(dataY$correlation==1 | dataY$correlation==-1 | dataY$pValue>0.05),]
dataY$correlation <- abs(dataY$correlation)


data <- merge(dataX, dataY, by=c("datasetX", "datasetY"))

cat("Analysis\n")
correlation <- cor(data$similarity, data$correlation, use="complete.obs", method=correlationMethod)
pValue <- cor.test(data$similarity, data$correlation, method=correlationMethod)$p.value
n <- nrow(data)

cat("Create and store plot\n")
#geom_point(alpha = 1/10)
#geom_point(size=1, shape=1)
#theme_bw(base_size = 12, base_family = "")

g <- ggplot(data, aes(data$similarity, data$correlation)) + xlab("Similarity") + ylab("Correlation") + geom_point(alpha = 1/10) + labs(list(title=paste0(refPeriod, " correlation:", correlation, " pValue:", pValue, " n:", n)))

g <- g + annotate("text", x=Inf, y=Inf, label="270a.info", hjust=1.3, vjust=2, color="#0000E4", size=4)
ggsave(plot=g, file=paste0(plotPath, ".jpg"), width=7, height=7)        
g
#ggsave(plot=g, file=paste0(plotPath, ".svg"), width=7, height=7)
#ggsave(plot=g, file=paste0(plotPath, ".png"), width=7, height=7)

warnings()

#real	1m13.920s
#user	1m13.867s
#sys	0m0.132s

