##plot3 
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


#plot Sub_metering_1, Sub_metering_2, Sub_metering_3 as function of entry (minute) of each of 2 days
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Sub_metering_1),xlab="",ylab="Energy sub metering",type="l")
lines(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
      as.numeric(febdays$Sub_metering_2),col="red")
lines(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
      as.numeric(febdays$Sub_metering_3),col="blue")
#add legend
legend("topright", lty=1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

##create a PNG file with width of 480 and height of 480
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()

############ UNUSED CODE/NOTES
##as.numeric(febdays$Global_active_power)
