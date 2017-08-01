#plot3.R

#download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="sourcedata.zip", method="curl")
unzip ("sourcedata.zip", exdir = "./")

#read data from file
data_all <- read.table("household_power_consumption.txt", header=TRUE, na.strings="?", sep=";")
#get subset for 2 day period
data <- data_all[(data_all$Date=="1/2/2007" | data_all$Date=="2/2/2007" ), ]

#make a combined Date and Time field
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

# set png for export
png(file = "plot3.png", width = 480, height = 480)

# make plot
with(data, {
  plot(Sub_metering_1~DateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

dev.off()