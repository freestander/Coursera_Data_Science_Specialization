#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

# get the motor vehicle sources
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehicleSCC <- SCC[vehicle, ]$SCC
PM25Vehicle <- PM25[PM25$SCC %in% vehicleSCC, ]

# Baltimore City "vs" in Los Angeles County
PM25VehicleBC <- PM25Vehicle[PM25Vehicle$fips=="24510", ]
PM25VehicleLA <- PM25Vehicle[PM25Vehicle$fips=="06037", ]
PM25VehicleBC$city <- "Baltimore City"
PM25VehicleLA$city <- "Los Angeles County"
BC_vs_LA <- rbind(PM25VehicleBC, PM25VehicleLA)

library(ggplot2)

png('plot6.png', width=480, height=480)

ggp <- ggplot	(BC_vs_LA, aes(x=factor(year), y=Emissions, fill=city)) +
		geom_bar(aes(fill=year), stat="identity") +
		facet_grid(.~city, scales="free", space="free") +
		guides(fill=FALSE) +
		labs(x="year", y=expression("Total PM2.5 Emissions (Tons)")) + 
		labs(title=expression("Emissions from PM2.5 from Motor Vehicles in Baltimore City vs LA from 1999-2008")) +
		theme_bw() 

print(ggp)

dev.off()

#######################################################