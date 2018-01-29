#######################################################

# set up the working directory (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis//Project_2")

# load the data from source
PM25 <- readRDS("./Data/summarySCC_PM25.rds")
SCC <- readRDS("./Data/Source_Classification_Code.rds")

# get the coal combustion subset
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustion & coal)
coalCombustionSCC <- SCC[coalCombustion, ]$SCC
PM25CoalCombustion <- PM25[PM25$SCC %in% coalCombustionSCC, ]

library(ggplot2)

png('plot4.png', width=480, height=480)

ggp <- ggplot	(PM25CoalCombustion, aes(factor(year), Emissions/10^5)) +
  		geom_bar(stat="identity") +
		guides(fill=FALSE) +
		labs(x="year", y=expression("Total PM2.5 Emissions (10^5 Tons)")) + 
		labs(title=expression("Emissions from Coal Combustion-related Sources from 1999¨C2008")) + 
  		theme_bw()

print(ggp)

dev.off()

#######################################################