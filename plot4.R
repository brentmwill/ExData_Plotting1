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


## Plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Subplot 1
with(power.consumption2, plot(Date.Time, Global_active_power, 
                              ylab = "Global Active Power", 
                              xlab = "", type = "l"))

# Subplot 2
with(power.consumption2, plot(Date.Time, Voltage, type = "l", xlab = "datetime", 
                              yaxt = "n"))
axis.vec <- seq(234, 246, 2)
axis.vec2 <- as.character(axis.vec)
axis.vec2[axis.vec %% 4 == 0] <- ""
axis(side = 2, at = axis.vec, labels = axis.vec2)



# Subplot 3
with(power.consumption2, plot(Date.Time, Sub_metering_1, col = "black", 
                              xlab = "", ylab = "Energy sub metering", type = "l"))
with(power.consumption2, lines(Date.Time, Sub_metering_2, col = "red", type = "l"))
with(power.consumption2, lines(Date.Time, Sub_metering_3, col = "blue", type = "l"))
legend("topright", col = c("black", "red", "blue"), lty = "solid", bty = "n",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Subplot 4
with(power.consumption2, plot(Date.Time, Global_reactive_power, type = "l", 
                              xlab = "datetime"))
dev.off()

