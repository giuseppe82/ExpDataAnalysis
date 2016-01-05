setwd("/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis")
df <- ("./household_power_consumption.txt")
data <- read.table(df, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
class(data_subset$Date)
data_time <- strptime(paste(data_subset$Date, data_subset$Time, sep = " "), 
                      format="%d/%m/%Y  %H:%M:%S")
data_time
png("./plot3.png", width = 480, height = 480)
SUB1 <- as.numeric(data_subset$Sub_metering_1)
SUB2 <- as.numeric(data_subset$Sub_metering_2)
SUB3 <- as.numeric(data_subset$Sub_metering_3)
plot(data_time, SUB1, type = "n", xlab = " ", ylab = "Energy sub metering")
lines(data_time, type = "l", SUB1, col = "black")
lines(data_time, type = "l", SUB2, col = "red")
lines(data_time, type = "l", SUB3, col = "blue")
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
                     col = c('black', 'red', 'blue'))

dev.off()
