#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")

# get the total emissions from PM2.5 in the Baltimore City
PM25BC <- PM25[PM25$fips=="24510", ]
aggBC <- aggregate(Emissions ~ year, PM25BC, sum)

png('plot2.png', width=480, height=480)  

barplot(
	aggBC$Emissions
	, names.arg=aggBC$year
	, xlab="Year"
	, ylab="PM2.5 Emissions (Tons)"
	, main="Total Emissions from PM2.5 in Baltimore City"
	)

dev.off()

#######################################################