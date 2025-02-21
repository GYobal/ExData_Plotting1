
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


#first Plot

png(file="Plot1.png",width = 480,height = 480
    )
    hist(power_sub$Global_active_power, main = "Global Active Power", col = "red",
          xlab="Global Active Power (kilowatts)" ,ylim = c(0,1200))
dev.off()


