if(!file.exists("exdata-data-household_power_consumption.zip")){
  file_link <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(file_link, temp)
  file <- unzip(temp, "household_power_consumption.txt")
  unlink(temp)
}

## reading and preprocessing data
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)
df <- data[(data$Date == "1/2/2007") | (data$Date == "2/2/2007"), ]

df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df$Global_intensity <- as.numeric(as.character(df$Global_intensity))
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$timestamp <- as.POSIXct(paste(df$Date, df$Time))

# PLOT 1
plot1 <- function(){
  hist(as.numeric(df$Global_active_power), xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")
  
  dev.copy(png, file = "plot1.png", width = 480, height = 480)
  dev.off()
}
plot1()
