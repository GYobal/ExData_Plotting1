
#Reading the dataset

getwd()



if (!dir.exists("./data")) {
  dir.create("./data")
}

dat<-("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip") 

download.file(dat,"./data/power.zip")

unzip("./data/power.zip")

#missing values = ? and separator = ;

power<-read.table("household_power_consumption.txt", sep=";", header = TRUE,na.strings ="?")
                 
str(power)

#Change date and time to proper formats

power$Date <- as.Date(power$Date, format = "%d/%m/%Y")  
power$timetemp <- paste(power$Date, power$Time)  
power$Time <- strptime(power$timetemp, format = "%Y-%m-%d %H:%M:%S")  

#creating subset with the two dates of interest: 2007-02-01- and 2007-02-02
power_sub <- subset(power, Date == "2007-02-01"|Date == "2007-02-02",)

str(power_sub)

#third Plot

png(file="Plot3.png",width = 480, height=480
)
plot(power_sub$Time,power_sub$Sub_metering_1,
     xlab= " ",ylab = "Energy Sub Metering", type = "l")
lines(power_sub$Time,power_sub$Sub_metering_2, col = "red")
lines(power_sub$Time,power_sub$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),      
       lty=c(1,1,1),col=c("black","red","blue"))
dev.off()
