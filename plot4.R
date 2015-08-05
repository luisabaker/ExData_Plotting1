## Check for data in working directory
if(!file.exists("household_power_consumption.txt")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}
##Read in data
header <- read.table("household_power_consumption.txt", sep = ";", 
                     colClasses = "character", nrows = 1)
rawdata <- read.table("household_power_consumption.txt", sep = ";", 
                      na.strings = "?", col.names = header,
                      colClasses = c("character", "character", "numeric",
                                     "numeric", "numeric", "numeric",
                                     "numeric", "numeric", "numeric"),
                      nrows = 2880, skip = 66637)
## Convert Date and Time
rawdata$Datetime <- paste(rawdata$Date, rawdata$Time)
rawdata$Datetime <- strptime(rawdata$Datetime, format = "%d/%m/%Y %H:%M:%S")
## Create plot
par(mfrow = c(2, 2), cex = 0.65)
plot(rawdata$Datetime, rawdata$Global_active_power, type = "l", xlab = NA,
     ylab = "Global Active Power")
plot(rawdata$Datetime, rawdata$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage")
plot(rawdata$Datetime, rawdata$Sub_metering_1, type = "l", xlab = NA, 
     ylab = "Energy sub metering")
lines(rawdata$Datetime, rawdata$Sub_metering_2, type = "l", col = "red")
lines(rawdata$Datetime, rawdata$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.9, text.width = 76000)
plot(rawdata$Datetime, rawdata$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global_reactive_power")
## Write to png file
dev.copy(png, filename = "plot4.png")
dev.off()
