library(dplyr)
setwd("C:/Users/Samantha/Desktop/data_science")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./zipdata.zip")
unzip(zipfile="./zipdata.zip", exdir="./Electric_Power_Consumption"
hpc<-read.csv("./Electric_Power_Consumption/household_power_consumption.txt", sep=";")
newdata <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007")

newdata$Date<- as.Date(newdata$Date, "%d/%m/%Y")
newdata$Time <- strptime(newdata$Time, format="%H:%M:%S")
newdata[1:1440,"Time"] <- format(newdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
newdata[1441:2880,"Time"] <- format(newdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")



newdata$Global_active_power<-as.character(newdata$Global_active_power)
newdata$Global_active_power<-as.numeric(newdata$Global_active_power)

newdata$Voltage<-as.character(newdata$Voltage)
newdata$Voltage<-as.numeric(newdata$Voltage)

newdata$Sub_metering_1<-as.character(newdata$Sub_metering_1)
newdata$Sub_metering_1<-as.numeric(newdata$Sub_metering_1)

newdata$Sub_metering_2<-as.character(newdata$Sub_metering_2)
newdata$Sub_metering_2<-as.numeric(newdata$Sub_metering_2)

newdata$Sub_metering_3<-as.character(newdata$Sub_metering_3)
newdata$Sub_metering_3<-as.numeric(newdata$Sub_metering_3)

newdata$Global_reactive_power<-as.character(newdata$Global_reactive_power)
newdata$Global_reactive_power<-as.numeric(newdata$Global_reactive_power)

png(file="plot4.png")
par(mfrow=c(2,2))
  plot(newdata$Time, newdata$Global_active_power, type="l",  xlab="",ylab="Global Active Power")  
  plot(newdata$Time, newdata$Voltage, type="l",xlab="datetime",ylab="Voltage")
  plot(newdata$Time,newdata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
   with(newdata,lines(Time, Sub_metering_1))
   with(newdata,lines(Time, Sub_metering_2,col="red"))
   with(newdata,lines(Time, Sub_metering_3,col="blue"))
   legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(newdata$Time,newdata$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()