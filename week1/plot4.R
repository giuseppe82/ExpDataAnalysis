setwd("/Users/joedibernardo/Projects/DATASCIENCE/ExploratoryDataAnalysis")
df <- ("./household_power_consumption.txt")
data <- read.table(df, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")

data_subset <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]
class(data_subset$Date)
data_time <- strptime(paste(data_subset$Date, data_subset$Time, sep = " "), 
                      format="%d/%m/%Y  %H:%M:%S")
data_time

png("./plot4.png", width = 480, height = 480)
GAP <- as.numeric(data_subset$Global_active_power)
VOLT <- as.numeric(data_subset$Voltage)
SUB1 <- as.numeric(data_subset$Sub_metering_1)
SUB2 <- as.numeric(data_subset$Sub_metering_2)
SUB3 <- as.numeric(data_subset$Sub_metering_3)
GRP <- as.numeric(data_subset$Global_reactive_power)

par(mfrow = c(2, 2))
par(cex = 0.4)
# 1st plot
plot(data_time, GAP, type = "n", xlab = " ", ylab = "Global Active Power (kilowatts)")
lines(data_time, GAP)
#2nd plot
plot(data_time, VOLT, type = "n", 
     xlab = "datetime", ylab = "Voltage")
lines(data_time, VOLT)
#3rd plot
plot(data_time, SUB1, type = "n", xlab = " ", ylab = "Energy sub metering")
lines(data_time, type = "l", SUB1, col = "black")
lines(data_time, type = "l", SUB2, col = "red")
lines(data_time, type = "l", SUB3, col = "blue")
legend('topright',c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1,
       bty = "n", col = c('black', 'red', 'blue'))
#4th plot 
plot(data_time, GRP, type = "n", 
     xlab = "datetime", ylab = "Global_reactive_power")
lines(data_time, GRP)
dev.off()
