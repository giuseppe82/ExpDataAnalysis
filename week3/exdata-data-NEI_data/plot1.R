# Course Project 2. 
# 1. Have total emissions from PM2.5 decreased in the United States 
# from 1999 to 2008? Using the base plotting system, make a plot showing 
# the total PM2.5 emission from all sources for each of the years 
# 1999, 2002, 2005, and 2008.
# Script Name: plot1.R

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
library(dplyr)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

EM <- NEI$Emission # numeric vector of emissions 
YR <- NEI$year # numeric vector of years
# str(EM) have a quick look into the EM data frame. 
# a convenient "new" data frame
Data <- data.frame(cbind(YR, EM), stringsAsFactors = FALSE)
# summary(Data), just a quick check 

# let's apply some filtering. 
PM1999 <- Data[Data$YR == 1999, ]
PM2002 <- Data[Data$YR == 2002, ]
PM2005 <- Data[Data$YR == 2005, ]
PM2008 <- Data[Data$YR == 2008, ]
# summary(PM1999$EM), just a quick check 
years <- cbind(1999,2002,2005,2008)
total_emissions <- cbind(sum(PM1999$EM), sum(PM2002$EM), sum(PM2005$EM), sum(PM2008$EM))
# total_emissions

png("./plot1.png", width = 640, height = 480)
par(mar=c(5,5,5,2)+0.1)
barplot(total_emissions, width = 1, col = "wheat", 
        cex = 1.5, cex.main = 1.5, cex.axis = 1.5, 
        cex.lab = 1.5,
        ylim = c(0e+00, 7e+06),
        axis.lty = 0,
        main = expression('Total PM'[2.5]*' emissions in the USA, 1999 - 2008'),
        xlab = "Years", ylab = expression('total PM'[2.5]*' emissions (tons)'),
        horiz = FALSE, names.arg = years
        )
dev.off()
