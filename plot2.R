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
png(filename = "plot2.png", width = 480, height = 480, units = "px", 
    bg = "transparent" )

# Create Plot 2
with(household, plot(datetime,Global_active_power, type = "l", xlab ="", 
                     ylab = "Global Active Power (kilowatts)"))

# Close graphics device
dev.off()