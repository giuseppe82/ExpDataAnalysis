# Course Project 2.
# 4. Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?
# Script Name: plot4.R

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
library(dplyr)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

emission.names <- SCC$Short.Name

# let's find the indexes corresponding to 
# emissions from coal combustion-related sources.
coal.indexes <- grep("coal", emission.names, ignore.case = TRUE) 

# mapping the SCC digit strings corresponding to coal combustion-related sources
SCC.coal <- SCC[coal.indexes, ] 

# select, in NEI, all the emissions corresponding to coal combustion-related sources
NEI.coal <- NEI[NEI$SCC %in% SCC.coal$SCC, ] 
emissions.duetocoal <- aggregate(Emissions ~ year, NEI.coal, sum)
# as an alternative, you can use the ddply() function. 
# e.g. ddply(NEI.coal, .(year), function(x) sum(x$Emissions))

png("./plot4.png", width = 640, height = 480)
par(mar=c(5,5,5,2)+0.1)
barplot(emissions.duetocoal$Emissions, col = "wheat",
        cex = 1.5, cex.main = 1.5, cex.axis = 1.5, 
        cex.lab = 1.5,
        main = expression('Total Emissions from coal sources in the USA, 1999-2008'),
        xlab = "Years", ylab = expression('total PM'[2.5]*' coal-related emissions (tons)'),
        horiz = FALSE, names.arg = emissions.duetocoal$year
)
dev.off()

