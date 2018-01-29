#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")

# get the total emissions from PM2.5 in the Baltimore City
PM25BC <- PM25[PM25$fips=="24510", ]

library(ggplot2)

png('plot3.png', width=480, height=480)

# plot the PM2.5 emissions four sources 
ggp <- ggplot	(PM25BC, aes(factor(year), Emissions, fill=type)) +  
		geom_bar(stat="identity") + 
		guides(fill=FALSE) +
		facet_grid(.~type, scales = "free", space="free") + 
		labs(x="year", y=expression("Total PM2.5 Emissions (Tons)")) + 
		labs(title=expression("Emissions from PM2.5 in Baltimore City from 1999-2008 by Source Type")) +
		theme_bw()		

print(ggp)

dev.off()

#######################################################