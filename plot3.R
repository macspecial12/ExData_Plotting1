################################################################################
# plot3.R - sub metering

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

# subset
data <- raw[raw$Date >= "2007-02-01" & raw$Date <= "2007-02-02", ] # 2880

# add column
data$datetime <- as.POSIXct(strptime(paste(data$Date,data$Time), format="%Y-%m-%d %H:%M:%S"))


# graphic
par(mar=c(5, 4, 4, 4))
plot(data$datetime,data$Sub_metering_1, 
     xlab="", 
     ylab="Energy sub metering",
     type="s" # lines
)
lines(data$datetime,data$Sub_metering_2,col="red")
lines(data$datetime,data$Sub_metering_3,col="blue")

# legend
legend("top",
       col = 1:3, #color
       cex = 0.7, #text size
       lty = 1, #line type to match the plots (could be a sequence 1:3)
       #lwd=c(2,2), #line width
       bty ="n", #bounding box off
       legend=c("Sub-metering 1","Sub-metering 2","Sub-metering 3")
)


# output to bitmap: png
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
