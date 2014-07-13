#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i


refPeriod <- c("2013")

dataPath <- c("../data/")
analysisPath <- paste0(dataPath, "analysis/")

dataX <- read.csv(paste0(analysisPath, "correlation.", refPeriod, ".csv"), na.strings='', header=T)
dataX <- dataX[!(dataX$n <= 10),]
x <- data.frame("identifier" = unique(c(levels(dataX[, "datasetX"]), levels(dataX[, "datasetY"]))))

dataY <- read.csv(paste0(dataPath, "worldbank.dataset.identifier.", refPeriod, ".csv"), na.strings='', header=T)

write.csv(merge(x, dataY, by="identifier"), file=paste0(dataPath, "worldbank.identifier.title.", refPeriod, ".csv"), row.names=FALSE)

