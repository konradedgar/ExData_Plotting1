#-----------------------Source the data----------------------------------

# Check wther the text file is availble in the working directory.
if (!file.exists("household_power_consumption.txt")) {
        
        # Check wthether the zip archive is available.
        if (!file.exists("exdata_data_household_power_consumption.zip")) {
                
                # Define data source.
                dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                
                # Download, save and unzip the file.
                library(RCurl)
                bin <- getBinaryURL(dataurl, ssl.verifypeer=FALSE, 
                                    noprogress = FALSE)
                con <- file("exdata_data_household_power_consumption.zip",
                            open = "wb")
                writeBin(bin, con)
                close(con)
                unzip("exdata_data_household_power_consumption.zip")
        } else
                unzip("exdata_data_household_power_consumption.zip")
}
#----------------------Preparing the data---------------------------------

# Create data table.
data <- read.table("household_power_consumption.txt", sep=";", header = TRUE)

# Converts date to the date format.
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset the data.
data <- subset(data, Date >= as.Date("2007-02-01", format = "%Y-%m-%d") 
               & Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))

# Combine date and time.
data$DateTime <- strptime(paste(data$Date, data$Time, sep = " "), 
                          "%Y-%m-%d %H:%M:%S")


#------------------------Draw and save plot 3------------------------------------
# Open PNG export.
png(filename = "plot3.png", height = 480, width = 480)

# First series
plot(data$DateTime, as.numeric(as.character(data$Sub_metering_1)), 
     xlab = "", type = 'l', col = 'black', ylab = "Energy sub metering",
     yaxt = 'n', ylim = c(0,40))

# Adding second line.
lines(data$DateTime, as.numeric(as.character(data$Sub_metering_2)), 
      col = 'red', type = 'l')

# Add third line.
lines(data$DateTime, as.numeric(as.character(data$Sub_metering_3)), 
      col = 'blue', type = 'l')

# Define axis with labels.
axis(side = 2, at=seq(0,30,10), labels = c("0","10","20","30") , 
     tick = TRUE, , yaxs="i")

# Add and place the legend.
legend('topright', legend, 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c('black','red','blue'), lty = c(1,1,1), 
       cex=0.9)

# Switch off the export device.
dev.off()
