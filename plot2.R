library(data.table)
library(datasets)
library(graphics)
library(grDevices)

# Read one line of the file to get the columns's names
fHpc <- file("./data/household_power_consumption.txt", "r");
hpcCols <- read.table(fHpc, header = TRUE, sep = ";", nrows = 1)
colNames <- colnames(hpcCols)

# Read lines from the dates 2007-02-01 and 2007-02-02 
hpcSub <- read.table(text = grep("^[1,2]/2/2007", readLines(fHpc), value = TRUE),
                     header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
close(fHpc)
colnames(hpcSub) <- colNames

# Convert date and time variables to Date/Time class
Sys.setlocale("LC_TIME", "en_US.UTF-8")
hpcSub$dateTime <- as.POSIXct(strptime(paste(hpcSub$Date, hpcSub$Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

# Set graphic's parameters
par(mfrow = c(1, 1 ), mar = c(5.1, 4.1, 4.1, 2.1), cex = 1, bg = "grey87")

# Plot graphic 2
with(hpcSub, plot( dateTime, Global_active_power, type = "l", xlab = " ",
                   ylab = "Global Active Power (kilowatts)"))

# Save the plot to a png file
dev.copy(png, file = "plot2.png")
dev.off()
