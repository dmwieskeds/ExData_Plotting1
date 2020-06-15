## download data from url address for data file provided in assignment
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "zipfile.zip")

## read data table into R
library(data.table)
data <- read.table(unz("zipfile.zip", "household_power_consumption.txt"), header = TRUE, sep = ";" ,na.strings = "?")
data$Date <- as.Date(data$Date,"%d/%m/%Y")

## create a subset of the data as defined in the assignment
subsetdata <- data[data$Date %between% c("2007-02-01", "2007-02-02"),]

## remove zip file; no longer needed
unlink("zipfile.zip")

## create Plot 1 and save as 480x480 PNG
hist(subsetdata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
