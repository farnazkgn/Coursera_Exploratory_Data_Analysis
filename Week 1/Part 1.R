library("data.table")

#setwd("~/Exploratory Data Analysis/Week 1/Project/Data")

#Reads in data from file then subsets data for specified dates
pdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

# Change Date Column to Date Type
pdata[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Prevents histogram from printing in scientific notation
pdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Subsetting the data for 2007-02-01 and 2007-02-02
pdata1 <- subset(pdata, (Date >= "2007-02-01") & (Date <= "2007-02-02"))

png("plot1.png", width=480, height=480)

## Plot 1
hist(pdata1[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()