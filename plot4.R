library(data.table)
library(datasets)
library(graphics)
library(grDevices)

# Read one line of file to get the columns's names
fHpc <- file("./data/household_power_consumption.txt", "r");
hpcCols <- read.table(fHpc, header=TRUE, sep=";", nrows=1)
colNames <- colnames(hpcCols)

# Read lines from the dates 2007-02-01 and 2007-02-02  
hpcSub <- read.table(text = grep("^[1,2]/2/2007", readLines(fHpc), value = TRUE),
                     header = TRUE, sep=";", na.strings = "?", stringsAsFactors = FALSE)
close(fHpc)
colnames(hpcSub) <- colNames

# Set date and time 
Sys.setlocale("LC_TIME", "en_US.UTF-8")
hpcSub$dateTime <- as.POSIXct(strptime(paste(hpcSub$Date, hpcSub$Time, sep = " "), "%d/%m/%Y %H:%M:%S"))

# Set graphic's parameters
par(mfrow = c(2, 2), mar = c(4.8, 4, 4, 2), cex = 0.85, bg = "grey87")

# Plot the 4 graphics
with(hpcSub, {
        # Plot graphic 1
        plot(dateTime, Global_active_power, type = "l", xlab = " ", ylab = "Global Active Power")
        
        # Plot graphic 2
        plot(dateTime, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
        
        # Plot graphic 3
        plot(dateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
        lines(hpcSub$dateTime, hpcSub$Sub_metering_2, col = "red")
        lines(hpcSub$dateTime, hpcSub$Sub_metering_3, col = "blue")
        temp <- legend("topright", legend = c(" ", " ", " "), pch = NA, lty = 1, bty = "n",
                       cex = 0.8, text.width = strwidth("1,000,000"),
                       col = c("black", "red", "blue"), y.intersp = 0.6, xjust = 1, adj = c(0, 1))
        text(temp$rect$left + temp$rect$w, temp$text$y, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), pos = 2)
        
        # Plot graphic 4
        plot(dateTime, Global_reactive_power, type = "l", xlab = "datetime")
})

# Save the plot to a png file
dev.copy(png, file = "plot4.png")
dev.off()