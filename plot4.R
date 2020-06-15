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

## create Plot 4
subsetdata$DT <- as.POSIXct(as.character(paste(subsetdata$Date, subsetdata$Time)))

plot(x=subsetdata$DT,y=subsetdata$Global_active_power,lines(x=subsetdata$DT,y=subsetdata$Global_active_power),
     pch = NA,xlab = "",ylab = "Global Active Power (kilowatts)")

plot(x=subsetdata$DT,y=subsetdata$Voltage,lines(x=subsetdata$DT,y=subsetdata$Voltage),
     pch = NA,xlab = "datetime",ylab = "Voltage")

plot(x=subsetdata$DT,y=subsetdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(x=subsetdata$DT,subsetdata$Sub_metering_1, lines(x=subsetdata$DT,y=subsetdata$Sub_metering_1,col = "black"), pch = NA)
points(x=subsetdata$DT,subsetdata$Sub_metering_2, lines(x=subsetdata$DT,y=subsetdata$Sub_metering_2,col = "red"), pch = NA)
points(x=subsetdata$DT,subsetdata$Sub_metering_3, lines(x=subsetdata$DT,y=subsetdata$Sub_metering_3,col = "blue"), pch = NA)
legend("topright", col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1)

plot(x=subsetdata$DT,y=subsetdata$Global_reactive_power,lines(x=subsetdata$DT,y=subsetdata$Global_reactive_power),
     pch = NA,xlab = "datetime",ylab = "Global_reactive_power")

## save as 480x480 PNG
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()