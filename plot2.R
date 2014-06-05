#-----------------------Source the data----------------------------------

# Check wther the CSV file is availble in the working directory.
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

#------------------------Draw and save plot 2------------------------------------
png(filename = "plot2.png", height = 480, width = 480)
        plot(as.numeric(data$Global_active_power), 
             ylab="Global Active Power (kilowatts)",
             type="l", xlab = "", xaxt='n')
# Label x axis.
axis(side=1, at=seq(0,3000,1450), labels = c("Thu","Fri","Sat") , tick = TRUE)
dev.off()
