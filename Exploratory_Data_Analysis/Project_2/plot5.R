#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

# get the motor vehicle sources for Baltimore City
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicle, ]$SCC
PM25Vehicle <- PM25[PM25$SCC %in% vehicleSCC, ]
PM25VehicleBC <- PM25Vehicle[PM25Vehicle$fips=="24510", ]

library(ggplot2)

png('plot5.png', width=480, height=480)

ggp <- ggplot	(PM25VehicleBC, aes(factor(year), Emissions)) +
		geom_bar(stat="identity") +
		guides(fill=FALSE) +
		labs(x="year", y=expression("Total PM2.5 Emissions (Tons)")) + 
		labs(title=expression("Emissions from PM2.5 from Motor Vehicles in Baltimore City from 1999-2008")) +
		theme_bw()

print(ggp)

dev.off()

#######################################################