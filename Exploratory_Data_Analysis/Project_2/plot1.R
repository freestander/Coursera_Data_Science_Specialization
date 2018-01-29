#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")

# get the total emssion of per year 
aggEmission <- aggregate(Emissions ~ year, PM25, sum)

png('plot1.png', width=480, height=480)  

barplot(
	aggEmission$Emissions/10^6
	, names.arg=aggEmission$year
	, xlab="Year"
	, ylab="PM2.5 Emissions (10^6 Tons)"
	, main="Total Emissions from PM2.5 in the United States"
	)

dev.off()

#######################################################