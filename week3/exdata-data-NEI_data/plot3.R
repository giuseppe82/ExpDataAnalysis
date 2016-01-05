# Course Project 2.
# 3. Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these 
# four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
# Script Name: plot3.R

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
library(dplyr)
# Load the ggplot2 package
library(ggplot2)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# e.g. NEI$type  to quickly explore the types of source variables
# 1st: let's create a subset, corresponding to the emissions records 
# only in the Baltimore city, MD. We use the filter() function, to select on rows

NEI.subset <- filter(NEI, fips == "24510") 

# alternative way to proceed 
# NEI.subset <- NEI[NEI$fips == "24510",]
# str(NEI.subset)
# PM.point <- NEI.subset[NEI.subset$type == "POINT", ]
# PM.nonpoint <- NEI.subset[NEI.subset$type == "NONPOINT", ]
# PM.onroad <- NEI.subset[NEI.subset$type == "ON-ROAD", ]
# PM.nonroad <- NEI.subset[NEI.subset$type == "NON-ROAD", ]
# ... but too long 

# Better, to use the features of ggplot2
# These are the variable mappings used here: 
# year: x-axis
# type: line color
# total emissions
png("./plot3.png", width = 640, height = 480)
par(mar=c(5,5,5,2)+0.1)
g <- ggplot(data = NEI.subset, aes(x = year, y = Emissions, color = type)) 
g <- g + geom_line(stat = "summary" , fun.y = "sum", size = 1.5) 
g <- g + theme(axis.text = element_text(size=16))
g <- g + xlab("Years") 
g <- g + ylab(expression('total PM'[2.5]*' emissions (tons)'))  
g <- g + theme(axis.title.x = element_text(size=16))
g <- g + theme(axis.title.y = element_text(size=16))
g <- g + ggtitle(expression('Total PM'[2.5]*' emissions (per type of sources) in the Baltimore City (MD), 1999 - 2008')) 
g <- g + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size = 16))

# stat_summary allows for tremendous flexibilty in the specification of summary 
# functions. The summary function can either operate on a data frame 
# (with argument name fun.data) or on a vector (fun.y, fun.ymax, fun.ymin).
print(g)
dev.off()

