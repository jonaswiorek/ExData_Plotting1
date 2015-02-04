require(dplyr) || install.packages("dplyr")

Sys.setlocale("LC_TIME","C") #Get weekdays in English in RStudio

# Load electric power consumption data set
power<- read.table("./data/household_power_consumption.txt",
                   header = TRUE,
                   sep = ";",
                   na.strings = "?")
# Subset 2007-02-01 and 2007-02-01
power <- filter(power, Date == "1/2/2007" | Date == "2/2/2007")

# Convert Date and Time variables to POSIX
power$dateAndTime <- strptime(paste(as.Date(power$Date,"%d/%m/%Y"), 
                                         power$Time),"%Y-%m-%d %H:%M:%S")

# Make plot
par(mfrow = c(1,1))
with(power, plot(dateAndTime,Global_active_power, 
     xlab ="", ylab ="Gloabal Active Data (kilowatts)", type = "n"))
with(power,lines(dateAndTime,Global_active_power))

# Save plot to PNG
dev.copy(png, file ="plot2.png", width = 480, height = 480)
dev.off()