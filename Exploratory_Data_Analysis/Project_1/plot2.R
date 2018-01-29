############Plot 2############

source("loadData.R")

# open the device
png(filename="plot2.png", width=480, height=480, units="px")

# plot the data
plot(power_subset$datetime, power_subset$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

# turn off the device
x<-dev.off()