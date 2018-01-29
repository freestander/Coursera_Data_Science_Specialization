############Plot 4############

source("loadData.R")

# open the device
png(filename="plot4.png", width=480, height=480, units="px")

# plot the data, add lines and lengend
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(power_subset, {
    plot(Global_active_power~datetime, type="l", xlab="", ylab="Global Active Power")
    plot(Voltage~datetime, xlab="", ylab="Voltage", type="l")
    plot(Sub_metering_1~datetime, xlab="", ylab="Energy sub metering", type="l")
    lines(Sub_metering_2~datetime, col="Red")
    lines(Sub_metering_3~datetime, col="Blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
          col=c("black", "red", "blue"), lty=1, lwd=2, bty="n")
    plot(Global_reactive_power~datetime, xlab="", ylab="Global_rective_power", type="l")
    })

# turn off the device
x<-dev.off()