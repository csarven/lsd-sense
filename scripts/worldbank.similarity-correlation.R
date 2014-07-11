#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i


library(ggplot2)

refPeriod <- c("2013")

dataPath <- c("../data/")
analysisPath <- paste0(dataPath, "analysis/")
plotPath <- paste0(dataPath, "plots/", "similarity-correlation", ".", refPeriod, ".svg")

correlationMethod <- c("kendall")

cat("Get dataset similarities and correlations from each dataset\n")
dataX <- read.csv(paste0(analysisPath, "similarity", ".", refPeriod, ".csv"), na.strings='', header=T)
dataY <- read.csv(paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), na.strings='', header=T)
data <- merge(dataX, dataY, by=c("datasetX", "datasetY"))

cat("Analysis\n")
correlation <- cor(data$similarity, data$correlation, use="complete.obs", method=correlationMethod)
pValue <- cor.test(data$similarity, data$correlation, method=correlationMethod)$p.value
n <- nrow(data)

cat("Create and store plot\n")
g <- ggplot(data, aes(data$similarity, data$correlation)) + xlab("Similarity") + ylab("Correlation") + geom_point(size=2, shape=1) + labs(list(title=paste0(refPeriod, " correlation:", correlation, " pValue:", pValue, " n:", n)))
g <- g + annotate("text", x=Inf, y=Inf, label="270a.info", hjust=1.3, vjust=2, color="#0000E4", size=4)
ggsave(plot=g, file=plotPath, width=7, height=7)

warnings()

#real	2m35.869s
#user	2m35.438s
#sys	0m0.594s
