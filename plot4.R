require(dplyr) || install.packages("dplyr")
library(dplyr)

Sys.setlocale("LC_TIME","C") #Get weekdays in English in RStudio

# Load lectric power consumption data set
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
par(mfrow = c(2,2))
#Topleft
with(power, plot(power$dateAndTime,power$Global_active_power, 
     xlab ="", ylab ="Gloabal Active Data", type = "l"))
#Topright
with(power, plot(power$dateAndTime,power$Voltage, xlab = "datetime", 
     ylab ="Voltage", type="l"))
#Bottomleft
with(power, plot(power$dateAndTime,power$Sub_metering_1, type = "n", 
     ylab ="Energy sub metering", xlab=""))
with(power, lines(power$dateAndTime,power$Sub_metering_1, col = "black"))
with(power, lines(power$dateAndTime,power$Sub_metering_2, col = "red"))
with(power, lines(power$dateAndTime,power$Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, cex= 0.6, y.intersp=0.4, bty="n", inset = c(0.1,-0.1))
#Bottomeright
with(power, plot(power$dateAndTime,power$Global_reactive_power, xlab = "datetime", 
     ylab ="Gloab_reactive_power", type="l"))

# Save plot to PNG
dev.copy(png, file ="plot4.png", width = 480, height = 480)
dev.off()