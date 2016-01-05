# Course Project 2.
# 6. Compare emissions from motor vehicle sources 
# in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California ( fips == "06037" ). 
# Which city has seen greater changes over time in motor vehicle emissions?
# Script Name: plot6.R 

setwd(dir = "/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis/week3/exdata-data-NEI_data")
# Load the ggplot2 package
library(ggplot2)
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# 1st: let's create a subset corresponding to the emissions records 
# in the Baltimore city (MD), and/or Los Angeles (CA). 
# We use the filter() function, to select on rows
NEI.subset <- filter(NEI, fips == "24510" | fips == "06037")

# 2nd: let's find the indexes corresponding to 
# emissions from motor vehicle sources only.
emission.names <- SCC$EI.Sector
motor.indexes <- grep("vehicle|motor", emission.names, ignore.case = TRUE) 

# mapping the SCC digit strings corresponding to motor vehicle sources
SCC.motor <- SCC[motor.indexes, ] 

# select, in NEI.subset data frames, all the emissions corresponding to 
# motor vehicle-related sources
NEI.motor <- NEI.subset[NEI.subset$SCC %in% SCC.motor$SCC, ]
# renames the fips variables
NEI.motor$fips[NEI.motor$fips=="24510"] <- "Baltimore (MD)"
NEI.motor$fips[NEI.motor$fips=="06037"] <- "Los Angeles (CA)"

# let's use the ggplot2 features
png("./plot6.png", width = 1040, height = 480)
par(mar=c(5,5,5,2)+0.1)
g <- ggplot(data = NEI.motor, aes(x = factor(year), y = Emissions, fill = Emissions)) 
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat = "summary" , fun.y = "sum", size = 1.5) 
g <- g + theme(axis.text = element_text(size=18))
g <- g + xlab("Years") 
g <- g + ylab(expression('total PM'[2.5]*' emissions (tons)'))  
g <- g + theme(axis.title.x = element_text(size=16))
g <- g + theme(axis.title.y = element_text(size=16))
g <- g + ggtitle(expression('Total PM'[2.5]*' emissions in the Baltimore City (MD), and Los Angeles (CA), from motor vehicles, 1999-2008')) 
g <- g + theme(plot.title = element_text(lineheight=3, face="bold", color="black", size = 16))
print(g)
dev.off()