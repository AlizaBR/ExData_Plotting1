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
png(filename="plot1.png", width=480, height=480)

# Plot 1
par(mar = c(5,4,2,1)) #Set margins
hist(days_data$Global_active_power, xlim = c(0,6), breaks = 12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", axes = FALSE, col = "red") #Plot data without axes
axis(side = 1, xlim = c(0,6), at=seq(0,6,2)) #Set x axis
axis(side = 2, ylim = c(0,1200), at=seq(0,1200,200)) #Set y axis

# Close devise
dev.off()