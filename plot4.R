##Libraries
if(!require(tidyverse)){
        install.packages("tidyverse")
        library(tidyverse)
}

## Arrange data
# Get original data
power_data_original <- read.table("./exdata_data_household_power_consumption/household_power_consumption.txt", header = TRUE, sep = ";")

# Coppy as tibble
power_data <- as.tibble(power_data_original)

# Set the "Date" variable as class POSIX
power_data$Date <- as.Date(power_data$Date, format = "%d/%m/%Y")

# Subset the data frame (select only the two days.)
days_data <- filter(power_data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Change factor variables to numeric
factor_col <- sapply(days_data, is.factor)
factor_col[2] = FALSE
days_data[factor_col] <- lapply(days_data[factor_col], function(x) as.numeric(as.character(x)))

## Plot
# Open device
png(filename="plot4.png", width=480, height=480)

# Plot 4
#Set parameter
par(mfrow = c(2,2), cex = .75)

# plot 4.1
plot(days_data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xaxt = "n", xlab = "") #plot the data

axis(side = 1, at=seq(0,length(days_data$Global_active_power),(length(days_data$Global_active_power)/2)), labels = c("Thu", "Fri", "Sat")) #add x axis

# plot 4.2
plot(days_data$Voltage, type = "l", ylab = "Voltage", xaxt = "n", xlab = "datetime") #plot the data

axis(side = 1, at=seq(0,length(days_data$Global_active_power),(length(days_data$Voltage)/2)), labels = c("Thu", "Fri", "Sat")) #add x axis

# plot 4.3
# Plot the lines 
plot(days_data$Sub_metering_1, type = "l", ylab = "Energy sub metering", xaxt = "n", xlab = "")
points(days_data$Sub_metering_2, type = "l", col = "red")
points(days_data$Sub_metering_3, type = "l", col = "blue")

axis(side = 1, at=seq(0,length(days_data$Global_active_power),(length(days_data$Sub_metering_1)/2)), labels = c("Thu", "Fri", "Sat")) #add x axis

legend ("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col= c("black","red", "blue"), bty = "n") #add legend

# plot 4.4
plot(days_data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xaxt = "n", xlab = "datetime") # plot the data

axis(side = 1, at=seq(0,length(days_data$Global_reactive_power),(length(days_data$Global_active_power)/2)), labels = c("Thu", "Fri", "Sat")) #add x axis

# Close device
dev.off()

