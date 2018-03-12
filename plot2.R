# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# Name each of the plot files as 𝚙𝚕𝚘𝚝𝟷.𝚙𝚗𝚐, 𝚙𝚕𝚘𝚝𝟸.𝚙𝚗𝚐, etc.
# Your code file should include code for reading the data so that the plot can be fully reproduced. 
# You must also include the code that creates the PNG file.
# Add the PNG file and R code file to the top-level folder of your git repository 
# (no need for separate sub-folders)

# to download file and unzip it
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destZip = "./household_power_consumption_data.zip"

if(!file.exists("./household_power_consumption.txt")){
     download.file(fileUrl, destfile = destZip) 
     unzip(destZip)
     file.remove(destZip)
}

HH_fileName <- "./household_power_consumption.txt"
library(data.table)

# to read the file
HH_power <- fread(HH_fileName, sep = ";",header = T, colClasses = rep("character",9), na.strings = "?")

# to check that the dataset has 2,075,259 rows and 9 columns.
# dim(HH_power) # [1] 2075259       9

# We will only be using data from the dates 2007-02-01 and 2007-02-02
HH_power_use <- HH_power[HH_power$Date == as.Date("2007-02-01") | HH_power$Date == as.Date("2007-02-02"),]
HH_power$Date <- as.Date(HH_power$Date, format = "%d/%m/%Y")
HH_power$Date.Time <- as.POSIXct(strptime(paste(HH_power$Date,HH_power$Time), 
                                          format = "%Y-%m-%d %H:%M:%S"))


## Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(HH_power_use$Global_active_power~HH_power_use$Date.Time, 
     ylab = "Global Active power (kilowatts)",
     xlab = "",
     type = "l")
dev.off()
