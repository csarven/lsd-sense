source("config.worldbank.R", local=TRUE)

dataX <- read.csv(paste0("../../worldbank-refPeriod/summary/", "correlation.", refPeriod, ".csv"), na.strings='', header=T)
dataY <- read.csv(paste0("../../worldbank-topics/meta/", "worldbank.metadata", ".", topic, ".", refPeriod, ".csv"), na.strings='', header=T, colClasses=c(NA,'NULL','NULL'))

dataW <- merge(dataX, dataY, by.x="datasetY", by.y="identifier")
dataZ <- merge(dataW, dataY, by.x="datasetX", by.y="identifier")

dX <- dataZ[(dataZ$n > 50 & dataZ$pValue < 0.05 & dataZ$correlation > 0.05 & dataZ$correlation < 0.95),]

write.csv(dX, file=paste0("../../worldbank-topics/summary/", "correlation", ".", topic, ".", refPeriod, ".csv"), , row.names=FALSE)

