#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

source("config.worldbank.R", local=TRUE)

dataX <- read.csv(paste0(summaryPath, "correlation.", refPeriod, ".csv"), na.strings='', header=T)
dataX <- dataX[(dataX$n > 50 & dataX$pValue < 0.05 & dataX$correlation > 0.05 & dataX$correlation < 0.95),]

x <- data.frame("identifier" = unique(c(levels(dataX[, "datasetX"]), levels(dataX[, "datasetY"]))))

dataY <- read.csv(paste0(metaPath, "worldbank.metadata.", refPeriod, ".csv"), na.strings='', header=T)

write.csv(merge(x, dataY, by="identifier"), file=paste0(metaPath, "worldbank.metadata.", refPeriod, ".subset.csv"), row.names=FALSE)

