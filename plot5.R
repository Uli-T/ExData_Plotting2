## Exploratory Data Analysis: Course Project 2
## https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/4/submissions

## Load required packages
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

## Read data into memory, format dates & select data
message("Reading data ...")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Q5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
BaltimoreCars <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD",]
Q5 <- aggregate(BaltimoreCars$Emissions, list(Year=BaltimoreCars$year), sum)

## Plot data
par(mfrow=c(1,1))
plot (Q5, type="b", main="Total PM2.5 emission from motor vehicle sources in Baltimore, MD", xlab="Year", ylab="PM2.5 emission (in tons)")

## Write plot to file
dev.copy(png, file="plot5.png", width=480, height=480)
dev.off()