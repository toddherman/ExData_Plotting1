#examine how household energy usage varies over a 2-day period in February, 2007
#plot 3 as per https://class.coursera.org/exdata-013
#save png.


#if the file has already been downloaded, skip this download
local_file <- "household_power_consumption.txt"
if (!file.exists(local_file)){
    #download the data from 
    #Dataset: Electric power consumption [20Mb],
    #Format: zip
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    # create the placeholder file
    tf = tempfile(fileext=".zip")
    # download into the placeholder file
    download.file(fileURL, tf)
    # get the name of the first file in the zip archive
    fname = unzip(tf, list=TRUE)$Name[1] 
    # unzip the file
    unzip(tf, files=fname, overwrite=TRUE) #once unzipped, this is a .txt file
}
fh <- file(local_file)
# read data subset from semi-colon separated text file.  re-create column names.
DT <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
## Converting dates
datetime <- paste(as.Date(DT$Date), DT$Time)
DT$Datetime <- as.POSIXct(datetime)

par(mfrow = c(1,1), mar = c(4,4,2,1), oma = c(0,0,2,1))
## Generating Plot 3
with(DT, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})

legend("topright", col = c("black", "red", "blue"),  cex = .75, lty = 1, lwd = 2, 
       legend = c("Sub_metering_1                 ", "Sub_metering_2", "Sub_metering_3"))
# copy graph to png file
dev.copy(png, file = "plot3.png" )
dev.off()