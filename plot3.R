require(dplyr) || install.packages("dplyr")
library(dplyr)

Sys.setlocale("LC_TIME","C") #Get weekdays in English in RStudio

# Load electric power consumption data set
power<- read.table("./data/household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   na.strings = "?")
# Subset 2007-02-01 and 2007-02-01
power <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert Date and Time variables to POSIX
power <- transform(power, dateAndTime = 
                     strptime(paste(as.Date(Date,"%d/%m/%Y"),
                                    Time),"%Y-%m-%d %H:%M:%S"))

# Make plot
par(mfrow = c(1,1))
with(power, plot(dateAndTime,Sub_metering_1, type = "n", 
     ylab ="Energy sub metering", xlab=""))
with(power, lines(dateAndTime,Sub_metering_1, col = "black"))
with(power, lines(dateAndTime,Sub_metering_2, col = "red"))
with(power, lines(dateAndTime,Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, cex= 0.8, x.intersp=1, adj = 0.1)

# Save plot to PNG
dev.copy(png, file ="plot3.png", width = 480, height = 480)
dev.off()
