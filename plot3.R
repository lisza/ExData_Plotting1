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
# Paste date and time together
datetime <- strptime(paste(household_data$Date, household_data$Time), format="%Y-%m-%d %H:%M:%S")

# Plot
par(cex=0.75)
plot(datetime, household_data$Sub_metering_1,
     type="l",
     ylab="Energy sub metering",
     xlab="")
lines(datetime, household_data$Sub_metering_2,
      type="l",
      col="red")
lines(datetime, household_data$Sub_metering_3,
      type="l",
      col="blue")
legend(x="topright",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1),
       col=c("black", "red", "blue"))

# Save plot as png
dev.copy(png,'plot3.png')
dev.off()