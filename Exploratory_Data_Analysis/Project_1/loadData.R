################################################################################################
# set the working directory to the foler (user specific)
# setwd("C://Users//Qi-Desktop//Documents//RProjects//Coursera//Exploratory_Data_Analysis")

# read full dataset
power_full <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F,                       stringsAsFactors=F, comment.char="", quote='\"')

# convert the date field to date format 
power_full$Date <- as.Date(power_full$Date, format="%d/%m/%Y")

# only use data from the dates 2007-02-01 and 2007-02-02.  
power_subset <- subset(power_full, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

# join the fields of date and time
datetime <- paste(as.Date(power_subset$Date), power_subset$Time)
power_subset$datetime <- as.POSIXct(datetime)
################################################################################################