# Course Project 2.
# 5. How have emissions from motor vehicle sources 
# changed from 1999 - 2008 in Baltimore City?
# Script Name: plot5.R 

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
library(dplyr)
# Load the ggplot2 package
#library(ggplot2)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# 1st: let's create a subset corresponding to the emissions records 
# only in the Baltimore city, MD. We use the filter() function, to select on rows
NEI.subset <- filter(NEI, fips == "24510") 

# 2nd: let's find the indexes corresponding to 
# emissions from motor vehicle sources only.
# Searching in Short.Name with grep motor|vehicle 
# returns missing info, I think. 
emission.names <- SCC$EI.Sector
motor.indexes <- grep("vehicle|motor", emission.names, ignore.case = TRUE) 

# mapping the SCC digit strings corresponding to motor vehicle sources
SCC.motor <- SCC[motor.indexes, ] 
# head(SCC.motor)

# select, in NEI, all the emissions corresponding to motor vehicle sources
NEI.motor <- NEI.subset[NEI.subset$SCC %in% SCC.motor$SCC, ] 
emissions.duetomotor <- aggregate(Emissions ~ year, NEI.motor, sum)
str(emissions.duetomotor)
png("./plot5.png", width = 640, height = 480)
par(mar=c(5,5,5,5)+0.1)
barplot(emissions.duetomotor$Emissions, col = "wheat",
        cex = 1.5, cex.main = 1.5, cex.axis = 1.5, 
        cex.lab = 1.5,
        main = expression('Total Emissions from motor vehicles in the Baltimore City (MD), 1999 - 2008'),
        xlab = "Years", ylab = expression('total PM'[2.5]*' motor-related emissions (tons)'),
        horiz = FALSE, names.arg = emissions.duetomotor$year
)
dev.off()
