#examine how household energy usage varies over a 2-day period in February, 2007
#plot 1 Global_active_power vs. Frequency
# as per https://class.coursera.org/exdata-013
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
par(mfrow = c(1,1))
#png("mygraph.png",  width = 500, height = 480, units = "px")
hist(DT$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# copy graph to png file
dev.copy(png, file = "plot1.png")
dev.off()


