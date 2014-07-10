#Author: Sarven Capadisli <info@csarven.ca>
#Author URL: http://csarven.ca/#i

args <- commandArgs(TRUE)
argv <- length(args)

library(ggplot2)

refPeriod <- c("2013")

dataPath <- c("/var/www/linked-dataset-similarity-correlation/data/")
observationPath <- paste0(dataPath, "observations/")
analysisPath <- paste0(dataPath, "analysis/")
datasets <- read.csv(paste0(dataPath, "worldbank.dataset.identifier.", refPeriod, ".csv"), header=T)

correlationMethod <- c('kendall')
cat(paste("datasetX", "datasetY", "correlation", "pValue", "n", sep=","), file=paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), sep="\n")



#datasetY <- c("SH.MMR.RISK.ZS")

datasetX <- c("FP.CPI.TOTL.ZG")
dataX <- read.csv(paste0(observationPath, datasetX, ".", refPeriod, ".csv"), na.strings='', header=T)

for (i in 1:length(datasets[, 1])) {
    datasetY <- datasets[i, "identifier"]

    print(paste0(datasetX, ", ", datasetY))
    
    plotPath <- paste0(dataPath, "plots/", datasetX, "-", datasetY, ".", refPeriod, ".svg")

    #Get the observations form each dataset
    dataY <- read.csv(paste0(observationPath, datasetY, ".", refPeriod, ".csv"), na.strings='', header=T)
    data <- merge(dataX, dataY, by="refArea")

    if (length(data[,1]) < 10) {NA}
    else {
        #Analysis
        correlation <- cor(data$obsValue.x, data$obsValue.y, use="complete.obs", method=correlationMethod)
        pValue <- cor.test(data$obsValue.x, data$obsValue.y, method=correlationMethod)$p.value
        n <- nrow(data)
        
        #Store analysis
        cat(paste(datasetX, datasetY, correlation, pValue, n, sep=","), file=paste0(analysisPath, "correlation", ".", refPeriod, ".csv"), sep="\n", append=TRUE)
        
        #Create and store plot
        g <- ggplot(data, aes(data$obsValue.x, data$obsValue.y)) + xlab(datasetX) + ylab(datasetY) + geom_point(size=2, shape=1) + labs(list(x=datasetX, y=datasetY, title=paste0(refPeriod, " correlation")))
        g <- g + annotate("text", x=Inf, y=Inf, label="270a.info", hjust=1.3, vjust=2, color="#0000E4", size=4)
        ggsave(plot=g, file=plotPath, width=7, height=7)
    }
}
warnings()