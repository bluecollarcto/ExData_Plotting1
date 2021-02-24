#plot1.R
##Download file to temp file to unzip from
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
              ,destfile=temp)

#read data from txt file within zip file into a data object
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header=T)
unlink(temp)
##
##convert date strings to Date
data$Date<-as.Date(strptime(data$Date,"%d/%m/%Y"))

##subset February 2nd and 3rd data into febdays
febdays<-subset(data,data$Date>="2007-02-01" & data$Date<="2007-02-02")

##create histogram from febdays - converting Global_active_power to numeric
## use color red, and title of Global Active Power with x axis labeled. Y axis gets
## labeled as Frequency automatically
hist(as.numeric(febdays$Global_active_power),col="red",
     main="Global Active Power",xlab="Global Active Power (kilowatts)")

##create a PNG file with width of 480 and height of 480
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()

############ UNUSED CODE/NOTES
##download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="household_power_consumption.zip")
##con<-unz("household_power_consumption.zip","household_power_consumption.txt")
##con<-unz("household_power_consumption.zip","household_power_consumption.txt")
##data<-read.table(con,sep=";",header=T)
##strptime(testdate,"%d/%m/%Y"))
###data$Date<-as.Date(strptime(testdate,"%d/%m/%Y"))
##febdays[febdays$Global_active_power=="0.326",]

