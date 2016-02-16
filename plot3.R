## IMPORTING DATA
if(!file.exists("exdata-data-household_power_consumption.zip")){
  file_link <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  temp <- tempfile()
  download.file(file_link, temp)
  file <- unzip(temp, "household_power_consumption.txt")
  unlink(temp)
}

## READING AND PREPROCESSING DATA
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

## PLOT 3
plot3 <- function(){
  plot(df$timestamp, df$Sub_metering_1, type = "line", ylab = "Energy sub meeting")
  lines(df$timestamp, df$Sub_metering_2, type = "line", col = "red")
  lines(df$timestamp, df$Sub_metering_3, type = "line", col = "blue")
  legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
  
  dev.copy(png, file = "plot3.png", width = 480, height = 480)
  dev.off()
}
plot3()
