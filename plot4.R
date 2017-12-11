##### Plot 4 - four plots on one page
## bebejr

## unzip file -- make sure file is in wd with exact file name
rm(list = ls())
library("data.table")
f <- "household_power_consumption.zip" ## filename here
dataPath <- "household_power_consumption" ## filename here
if (!file.exists(dataPath)) {
  unzip(f)
}

## make graph

#Reads in data from file then subsets data for specified dates

data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")


# create line plots


data$datetime <- as.POSIXct(data$datetime)
par(mfrow = c(2, 2))
par(mar=c(3,2,2,1))
attach(data)
plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", xlab = "")
plot(Voltage ~ datetime, type = "l")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
  bty = "n", y.intersp = 0.25) ## note the y.intersp puts legend labels closer to each other, default = 1.

plot(Global_reactive_power ~ datetime, type = "l")

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()
detach(data)