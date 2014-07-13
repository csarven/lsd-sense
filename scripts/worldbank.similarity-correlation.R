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
dataX$similarity <- abs(dataX$similarity)
dataX <- dataX[!(dataX$similarity<0.025 | dataX$similarity>0.975),]

dataY <- read.csv(paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), na.strings='', header=T)
dataY$correlation <- abs(dataY$correlation)
dataY <- dataY[!(dataY$correlation<0.025 | dataY$correlation>0.975 | dataY$pValue>0.05),]

data <- merge(dataX, dataY, by=c("datasetX", "datasetY"))

cat("Analysis\n")
correlation <- cor(data$similarity, data$correlation, use="complete.obs", method=correlationMethod)
pValue <- cor.test(data$similarity, data$correlation, method=correlationMethod)$p.value
n <- nrow(data)

cat("Create and store plot\n")
g <- ggplot(data, aes(data$similarity, data$correlation)) + xlab("Similarity") + ylab("Correlation") + geom_point(alpha = 1/10) + ggtitle(paste0(refPeriod, " World Bank indicators \n semantic similarity and correlation relationship")) + theme_bw(base_size = 12, base_family = "")

g <- g + annotate("text", x=Inf, y=Inf, label="270a.info", hjust=1.3, vjust=2, color="#0000E4", size=4)

g <- g + annotate("text", x=Inf, y=0, label=paste0("correlation: ", format(round(correlation, 3))), hjust=1.2, vjust=-4.75, size=4)
g <- g + annotate("text", x=Inf, y=0, label=paste0("p-value: ", format(round(pValue, 3))), hjust=1.25, vjust=-2.75, size=4)
g <- g + annotate("text", x=Inf, y=0, label=paste0("n: ", n), hjust=1.475, vjust=-0.75, size=4)

ggsave(plot=g, file=paste0(plotPath, ".png"), width=7, height=7)
g

warnings()

#real	1m13.920s
#user	1m13.867s
#sys	0m0.132s

