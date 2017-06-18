library(dplyr)
setwd("C:/Users/Samantha/Desktop/data_science")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="./zipdata.zip")
unzip(zipfile="./zipdata.zip", exdir="./Electric_Power_Consumption"
hpc<-read.csv("./Electric_Power_Consumption/household_power_consumption.txt", sep=";")

newdata <- subset(hpc,hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007")

newdata$Date <- as.Date(newdata$Date, format="%d/%m/%Y")
newdata$Time <- strptime(newdata$Time, format="%H:%M:%S")
newdata[1:1440,"Time"] <- format(newdata[1:1440,"Time"],"2007-02-01 %H:%M:%S")
newdata[1441:2880,"Time"] <- format(newdata[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

png(file="plot2.png")
plot(newdata$Time,as.numeric(as.character(newdata$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)", main="Global Active Power Vs Time")
dev.off()