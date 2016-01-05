setwd("/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis")
df <- ("./household_power_consumption.txt")
data <- read.table(df, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
data_time <- strptime(paste(data_subset$Date, data_subset$Time, sep = " "), 
                      format="%d/%m/%Y  %H:%M:%S")

png("./plot1.png", width = 480, height = 480)
GAP <- as.numeric(data_subset$Global_active_power)
hist(GAP, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200))
dev.off()
