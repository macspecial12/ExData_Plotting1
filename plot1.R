################################################################################
# plot1.R - histogram of global active power

setwd("C:\\Users\\Thinkpad\\Desktop\\Data Science John Hopkins\\data\\C4 Wk1")

# clean out vars
rm(list=ls()) # remove all objects from the work env
ls()

fname <- "household_power_consumption.txt"
setClass('yyyymmdd')
setAs("character","yyyymmdd", function(from) as.POSIXct(from, format="%d/%m/%Y"))

# convert NAs
# set column classes
raw <- read.table(fname, sep=";", header=TRUE, stringsAsFactors=FALSE,
                  na.strings=c("NA", "-", "?"),
                  colClasses=c("yyyymmdd","character","numeric",                        
                               "numeric","numeric","numeric",
                               "numeric","numeric","numeric")
)

#subset
data <- raw[raw$Date >= "2007-02-01" & raw$Date <= "2007-02-02", ] #2880

#graphic - histogram
hist(data$Global_active_power, 
     main="Global Active Power",
     xlab="Global Active Power (kilowats)", 
     col="red"
     )

# output to bitmap: png
dev.copy(png,file="plot1.png", width=480, height=480)
dev.off()
