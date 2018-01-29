############Plot 1############

source("loadData.R")

# open the device
png(filename="plot1.png", width=480, height=480, units="px", type="cairo")

# plot the data
hist(power_subset$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# turn off the device
x<-dev.off()