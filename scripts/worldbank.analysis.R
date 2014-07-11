#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i


library(ggplot2)

refPeriod <- c("2013")

dataPath <- c("/var/www/linked-dataset-similarity-correlation/data/")
observationPath <- paste0(dataPath, "observations/")
analysisPath <- paste0(dataPath, "analysis/")
datasets <- read.csv(paste0(dataPath, "worldbank.dataset.identifier.", refPeriod, ".csv"), header=T)


correlationMethod <- c('kendall')
cat(paste("datasetX", "datasetY", "correlation", "pValue", "n", sep=","), file=paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), sep="\n")
cat(paste("dataset", "time", sep=","), file=paste0(analysisPath, "metadata", ".", refPeriod, ".csv"), sep="\n")


datasetLength <- nrow(datasets)

for (i in 1:datasetLength) {
    dtstart <- Sys.time()

    for (j in 1:datasetLength) {
        if (i <= j) {
            datasetX <- datasets[i, "identifier"]
            datasetY <- datasets[j, "identifier"]

            plotPath <- paste0(dataPath, "plots/", datasetX, "-", datasetY, ".", refPeriod, ".svg")

            #Get the observations from each dataset
            dataX <- read.csv(paste0(observationPath, datasetX, ".", refPeriod, ".csv"), na.strings='', header=T)
            dataY <- read.csv(paste0(observationPath, datasetY, ".", refPeriod, ".csv"), na.strings='', header=T)
            data <- merge(dataX, dataY, by="refArea")

            n <- nrow(data)

            if (n < 10 || sd(data$obsValue.x)==0 || sd(data$obsValue.y)==0) {NA}
            else {
                #Analysis
                correlation <- cor(data$obsValue.x, data$obsValue.y, use="complete.obs", method=correlationMethod)
                pValue <- cor.test(data$obsValue.x, data$obsValue.y, method=correlationMethod)$p.value

                analysisLine <- paste(datasetX, datasetY, correlation, pValue, n, sep=",")
                print(analysisLine)

                #Store analysis
                cat(analysisLine, file=paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), sep="\n", append=TRUE)

                #Create and store plot
                g <- ggplot(data, aes(data$obsValue.x, data$obsValue.y)) + xlab(datasetX) + ylab(datasetY) + geom_point(size=2, shape=1) + labs(list(x=datasetX, y=datasetY, title=paste0(refPeriod, " correlation")))
                g <- g + annotate("text", x=Inf, y=Inf, label="270a.info", hjust=1.3, vjust=2, color="#0000E4", size=4)
                ggsave(plot=g, file=plotPath, width=7, height=7)
            }
        }
    }

    dtend <- Sys.time()
    duration <- as.numeric(dtend - dtstart, units="secs")
    print(duration)
    cat(paste(datasetX, duration, sep=","), file=paste0(analysisPath, "metadata", ".", refPeriod, ".csv"), sep="\n", append=TRUE)
}
warnings()
