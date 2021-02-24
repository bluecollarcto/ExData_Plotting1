#plot 4 
##ASSUME FILE IS ALREADY DOWNLOADED - see PLOT1 for code to download
##Download file to temp file to unzip from
#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#              ,destfile=temp)

#read data from txt file within zip file into a data object
#data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=T)
#unlink(temp)
##SINCE FILE IS DOWNLOADED - we can just create a connection to it
con<-unz("household_power_consumption.zip","household_power_consumption.txt")
data<-read.table(con,sep=";",header=T)

##convert date strings to Date
data$Date<-as.Date(strptime(data$Date,"%d/%m/%Y"))

##subset February 2nd and 3rd data into febdays
febdays<-subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")

##set up for 2 x 2 graphs 
par(mfrow=c(2,2)) # all plots on one page

#1st grid of 4
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Global_active_power),
     pch=NA,xlab="",ylab="Global Active Power",type="l")
#2nd grid of 4
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Voltage),
     pch=NA,xlab="datetime",ylab="Voltage",type="l")
#3rd grid of 4
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Sub_metering_1),xlab="",
     ylab="Energy sub metering",type="l")
lines(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),as.numeric(febdays$Sub_metering_2),col="red")
lines(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),as.numeric(febdays$Sub_metering_3),col="blue")

#legend("topright", lty=1, bty="n", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
##small adjustment to legend to make sure it fits
legend("topright", inset=c(.05,0),lty=1, bty="n", col = c("black", "red","blue"), c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#4th grid of 4
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Global_reactive_power),
     pch=NA,xlab="datetime",ylab="Global_reactive_power",type="l")

##create a PNG file with width of 480 and height of 480
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

##set default plot size back to 1 by 1
par(mfrow=c(1,1))

