##plot2.R
##NOTE: points can be omitted from the plot using pch = NA.

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

##create line plot of Global Active Power
plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),
     as.numeric(febdays$Global_active_power),xlab="",
     ylab="Global Active Power (kilowatts)",type="l")

##create a PNG file with width of 480 and height of 480
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()


############ UNUSED CODE/NOTES
##as.numeric(febdays$Global_active_power)
##plot(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),febdays$Global_active_power,pch=NA,xlab="",ylab="Global Active Power (kilowatts)")
##lines(as.POSIXct(paste(febdays$Date,febdays$Time),format="%Y-%m-%d %H:%M:%S"),febdays$Global_active_power)
