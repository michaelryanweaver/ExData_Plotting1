#plot4.R

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
png(file = "plot4.png", width = 480, height = 480)

#make plots
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~DateTime, type="l", 
       ylab="Global Active Power", xlab="", cex=0.8)
  plot(Voltage~DateTime, type="l", 
       ylab="Voltage", xlab="datetime", cex=0.8)
  plot(Sub_metering_1~DateTime, type="l", 
       ylab="Global Active Power", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime,col='Red')
  lines(Sub_metering_3~DateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
  plot(Global_reactive_power~DateTime, type="l", 
       ylab="Global_reactive_power",xlab="datetime", cex=0.8)
})

dev.off()