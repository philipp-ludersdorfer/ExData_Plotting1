# PLOT 2 #

# Check if Elecitric power consumption file is in working directory. 
if (!file.exists("household_power_consumption.txt")) {
    message("Please place the household_power_consumption.txt file in your working directory!")
}

# Read in data
household <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                        na.strings = "?", stringsAsFactors = FALSE, nrows = 100000)
# NOTE: To save time, only the first 100,000 rows are read as a course visual 
# inspection of the file indicated that this will definitely include the date 
# range of interest 

# Subset data to rows of 1st to 2nd Feb 2007
household <- subset(household, Date == "1/2/2007" | Date == "2/2/2007")

# Create new "datetime" column (POSIXlt) from "Date" and "Time" columns
household$datetime <- strptime(paste(household$Date, household$Time), "%d/%m/%Y %H:%M:%S")

# Open PNG file (graphics device)
png(filename = "plot4.png", width = 480, height = 480, units = "px", 
    bg = "transparent" )

# Create Plot 4
par(mfcol = c(2,2)) # create 2 (rows) x 2 (columns) subplots and fill column-wise
with(household, {
    # Subplot 1 
    plot(datetime,Global_active_power, type = "l", xlab ="", 
         ylab = "Global Active Power")
    # Subplot 2
    plot(datetime, Sub_metering_1, col = "black", type = "l",
         ylab = "Energy sub metering", xlab = "")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black","red","blue"), bty = "n",
           legend = names(household[7:9]))
    # Subplot 3
    plot(datetime, Voltage, type = "l", ylab = "Voltage")
    # Subplot 4
    plot(datetime, Global_reactive_power, type = "l")
})

# Close graphics device
dev.off()
