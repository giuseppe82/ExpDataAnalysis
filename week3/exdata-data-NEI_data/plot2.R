# Course Project 2. 
# 2. Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland ( fips == "24510" ) from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.
# Script Name: plot2.R

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
library(dplyr)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}
# 1st: let's create a subset, corresponding to the emissions records 
# only in the Baltimore City, MD
NEI.subset <- NEI[NEI$fips == "24510",]
EM <- NEI.subset$Emissions  # numeric vector of emissions 
YR <- NEI.subset$year       # numeric vector of years 
# a convenient "new" data frame
Data <- data.frame(cbind(YR, EM), stringsAsFactors = FALSE)

# let's apply some filtering. 
PM1999 <- Data[Data$YR == 1999, ] # data frame, corresponding to the emissions in 1999 
PM2002 <- Data[Data$YR == 2002, ] # """           """        """         """      2002            
PM2005 <- Data[Data$YR == 2005, ] # """           """        """         """      2005 
PM2008 <- Data[Data$YR == 2008, ] # """           """        """         """      2008

years <- cbind(1999,2002,2005,2008)
total_emissions <- cbind(sum(PM1999$EM), sum(PM2002$EM), sum(PM2005$EM), sum(PM2008$EM))
png("./plot2.png", width = 640, height = 480)
par(mar=c(5,5,5,2)+0.1)
barplot(total_emissions, width = 1, col = "wheat",
        cex = 1.5, cex.main = 1.5, cex.axis = 1.5, 
        cex.lab = 1.5,
        main = expression('Total PM'[2.5]*' emissions in the Baltimore City (MD), 1999 - 2008'),
        xlab = "Years", ylab = expression('total PM'[2.5]*' emissions (tons)'),
        horiz = FALSE, names.arg = years
)
dev.off()
