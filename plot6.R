## Exploratory Data Analysis: Course Project 2
## https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/4/submissions

## Load required packages
if (!require("dplyr")) {
  install.packages("dplyr")
}
require("dplyr")

if (!require("ggplot2")) {
  install.packages("ggplot2")
}
require("ggplot2")

## Download and decompress data & record date of download
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("summarySCC_PM25.rds")) {
  download.file(fileURL, destfile="dataset.zip")
  date.downloaded = date()
  message("Decompressing data ...")
  unzip("dataset.zip")
  message("Data decompressed.")
}

## Read data into memory
message("Reading data ...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
## Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

## Select motor vehicle data (ON-ROAD) for Baltimore City and Los Angeles Country
BaLA <- NEI[(NEI$fips == "24510" | NEI$fips == "06037") & NEI$type == "ON-ROAD", ]

## Aggregate data as needed
Q6 <- aggregate(BaLA$Emissions, list(Year=as.factor(BaLA$year), Location=as.factor(BaLA$fips)), sum)

## Calculate percentage of change compared to 1999 baseline ...
baseline <- ifelse(Q6$Location == "24510", Q6$x[which(Q6$Year == "1999" & Q6$Location == "24510")],
                   Q6$x[which(Q6$Year == "1999" & Q6$Location == "06037")])

## ... and add this as new column to dataframe
Q6$Change <- Q6$x/baseline * 100

## Replace fips by full name of locations
Q6$Location <- ifelse(Q6$Location == "24510", "Baltimore City", "Los Angeles County")

## Plot data
par(mfrow=c(1,1))
ggplot(Q6, aes(Year, Change, fill=Location)) + geom_bar(position = "dodge", stat="identity") + 
  labs(y="Change (1999 = 100%)") + ggtitle(expression(atop("PM2.5 emissions from motor vehicle sources",
  atop(italic("Baltimore City and Los Angeles County compared, 1999-2008"), ""))))

# Write plot to file
dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()