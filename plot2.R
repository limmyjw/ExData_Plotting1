#Exploratory Data Analysis, Course Project 1
#plot2.r
#Jan Willem van der Lichte
#22/01/2021


#Read data
library(readr)
bestand<-file.choose(new = FALSE)
hpc<- read_delim(bestand, ";", escape_double = FALSE, trim_ws = TRUE)

#Check for NA
hpc[hpc == "?"] <- NA
dim(hpc)
# only complete records
hpc <- na.omit(hpc) 
dim(hpc)


#Change field Date to type date
hpc$DateOld<-hpc$Date
hpc$Date<-as.Date(hpc$DateOld, "%d/%m/%Y")

#Get subset 
hpcss<-subset(hpc, Date>=as.Date("2007-02-01")& Date<=as.Date("2007-02-02"))
dim(hpcss)

#create field DT  for use in  plot 2
hpcss$TimeOld<-hpcss$Time  #keep old value
hpcss$Time<-as.character(hpcss$TimeOld) 
hpcss$DT <- as.POSIXct(as.character(paste(hpcss$DateOld, hpcss$Time)), format="%d/%m/%Y %H:%M:%S")


#plot2
par(mfrow=c(1,1))
plot(hpcss$DT,
     hpcss$Global_active_power,
     type = "l",
     ylab="Global Active Power (kilowatts)",
     xlab = "")
#export plot to png
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
