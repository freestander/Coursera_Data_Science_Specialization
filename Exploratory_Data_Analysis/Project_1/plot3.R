############Plot 3############

source("loadData.R")

# open the device
png(filename="plot3.png", width=480, height=480, units="px")

# plot the data, add lines and lengend
with(power_subset, {
    plot(Sub_metering_1~datetime, xlab="", ylab="Energy sub metering", type="l")
    lines(Sub_metering_2~datetime, col="Red")
    lines(Sub_metering_3~datetime, col="Blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2)
})

# add the legend to the plot
# legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, lwd=2)

# turn off the device
x<-dev.off()