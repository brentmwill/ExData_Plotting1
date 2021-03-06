library(data.table)

# Set Folder and Create Assignment Folder 
write.folder <- "C:/Users/B/Desktop/Data Science Master Folder/Exploratory Data Analytics/ExData_Plotting1"
setwd(write.folder)
if (!file.exists("file_download")) {dir.create("file_download")}
read.folder <- "C:/Users/B/Desktop/Data Science Master Folder/Exploratory Data Analytics/ExData_Plotting1/file_download"

# Download and Unzip Data
assignment.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(assignment.url, "./file_download/household_power_consumption.zip")
unzip("./file_download/household_power_consumption.zip", exdir = read.folder)

# Create power.consumption data frame using fread to speed text file reading
power.consumption <- fread("./file_download/household_power_consumption.txt", sep = ";", 
                           nrows = 2075259, stringsAsFactors = FALSE, 
                           data.table = FALSE, na.strings = "?")

# Time / Date Conversion
power.consumption$Date.Time <- paste(power.consumption$Date, power.consumption$Time, sep = " ")
power.consumption$Date.Time <- strptime(power.consumption$Date.Time, format = "%d/%m/%Y %H:%M:%S")
power.consumption$Date <- strptime(power.consumption$Date, format = "%d/%m/%Y")
power.consumption$Time <- NULL # The Time variable by itself is useless, as strptime reads in as current day

# Subset Data to Required Days
power.consumption2 <- power.consumption[which(power.consumption$Date == "2007-02-01" | 
                                                power.consumption$Date == "2007-02-02"), ]


# Set mfrow parameters to ensure they are producing a single frame
par(mfrow = c(1, 1))

# Plot 1
png(file = "plot1.png", width = 480, height = 480)
with(power.consumption2, hist(Global_active_power, col = "red", 
                              xlab = "Global Active Power (kilowatts)", 
                              main = "Global Active Power"))
dev.off()