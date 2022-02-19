# download the zipped file at url to working directory
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2fdata%2fhousehold_power_consumption.zip'
# comment out if zip file already downloaded to working dir
# download.file(url, 'temp.zip')
# unzip and save the txt file to working dir
# comment out if unzipped txt file already in working dir
# unzip('temp.zip')

# read txt file into data frame
data <- read.table(file='household_power_consumption.txt', header=TRUE, sep=';')
# filter data frame to include only 2 dates
library(dplyr)
data <- filter(data, Date %in% c('1/2/2007', '2/2/2007'))

# Convert Date and Time variables from character
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, format = "%d/%m/%Y %H:%M:%S")

# convert other variables to numeric
i <- c(3,4,5,6,7,8,9)
data[ , i] <- apply(data[ , i], 2, function(x) as.numeric(x))

# sort on datetime
data <- arrange(data, datetime)


# graph Global_active_power on datetime
with(data, plot(datetime, Global_active_power, type='l', 
                xlab='', ylab='Global Active Power (kilowatts)'))
# copy to png file with default size 480 pixels x 480 pixels
dev.copy(png, file = 'plot2.png')
dev.off()

