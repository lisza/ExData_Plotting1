##Prepare data for plotting
# Get library to read in files using SQL statements
require(sqlfd)

# Download and unzip data
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp)
datafile <- unzip(temp)
unlink(temp)

# SQL query variable to specify which data we need
sql <- "select * from file where Date in ('1/2/2007', '2/2/2007')"
# Read in relevant rows of data
household_data <- read.csv.sql(datafile, sep=";", sql = sql)
# Convert date strings to dates
household_data$Date <- as.Date(household_data$Date, "%d/%m/%Y")
# Replace '?'s with NA
is.na(household_data) <- household_data == "?"

##Create plot
par(cex=0.75)
hist(household_data$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     ylim=c(0, 1200))

# Save plot as png
dev.copy(png,'plot1.png')
dev.off()