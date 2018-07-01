library(data.table)
library(datasets)
library(graphics)
library(grDevices)

# Read one line of the file to get the columns's names
fHpc <- file("./data/household_power_consumption.txt", "r");
hpcCols <- read.table(fHpc, header = TRUE, sep=";", nrows = 1)
colNames <- colnames(hpcCols)

# Read lines from the dates 2007-02-01 and 2007-02-02
hpcSub <- read.table(text = grep("^[1,2]/2/2007", readLines(fHpc), value = TRUE),
                     header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
close(fHpc)
colnames(hpcSub) <- colNames

# Set graphic's parameters
par(mfrow = c(1, 1), mar = c(5.1, 4.1, 4.1, 2.1), cex = 1, bg = "grey87")

# Plot graphic 1
hist(hpcSub$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

# Save the plot to a png file
dev.copy(png, file = "plot1.png")
dev.off()

