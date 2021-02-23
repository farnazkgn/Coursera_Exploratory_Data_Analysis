library("data.table")

#setwd("~/Exploratory Data Analysis/Week 1/Project/Data")

#Reads in data from file then subsets data for specified dates
pdata <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
pdata[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
pdata[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Subsetting the data for 2007-02-01 and 2007-02-02
pdata1 <- subset(pdata, (dateTime >= "2007-02-01") & (dateTime < "2007-02-03"))

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = pdata1[, dateTime]
     , y = pdata1[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()