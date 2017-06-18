library(dplyr)
setwd("C:/Users/Samantha/Desktop/data_science")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./zipdata.zip")
unzip(zipfile="./zipdata.zip", exdir="./Electric_Power_Consumption"
hpc<-read.csv("./Electric_Power_Consumption/household_power_consumption.txt", sep=";")
hpc$Date<- as.Date(hpc$Date, "%d/%m/%Y")
hpc$Time <- strptime(hpc$Time, format="%H:%M:%S")
hpc[1:1440,"Time"] <- format(hpc[1:1440,"Time"],"2007-02-01 %H:%M:%S")
hpc[1441:2880,"Time"] <- format(hpc[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

date1<-subset(hpc, hpc$Date=="2007-02-02")
date2<-subset(hpc, hpc$Date=="2007-02-01")
newdata<-rbind(date1,date2)

newdata$Sub_metering_1<-as.character(newdata$Sub_metering_1)
newdata$Sub_metering_1<-as.numeric(newdata$Sub_metering_1)

newdata$Sub_metering_2<-as.character(newdata$Sub_metering_2)
newdata$Sub_metering_2<-as.numeric(newdata$Sub_metering_2)

newdata$Sub_metering_3<-as.character(newdata$Sub_metering_3)
newdata$Sub_metering_3<-as.numeric(newdata$Sub_metering_3)

png(file="plot3.png")
plot(subpower$Time,subpower$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering", main="Energy sub-metering", yaxt="n")
with(subpower,lines(Time, Sub_metering_1))
with(subpower,lines(Time, Sub_metering_2,col="red"))
with(subpower,lines(Time, Sub_metering_3,col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
axis(side=2,at=c(0,10,20,30))
dev.off()