##### Plot 1 - Histogram
## bebejr

## unzip file -- make sure file is in wd
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

#generate histogram
attach(data) # loads column names in R -- no $ needed
par(mar=c(5,6,4,2))
hist(Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "Red")

# Save .png file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
detach(data)