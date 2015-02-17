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

## Q3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these
## four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions
## from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

## Select data for Baltimore City (fips 24510)
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Aggregate data
Q3 <- aggregate(Emissions ~ type + year, data = Baltimore, sum)

## Plot data
par(mfrow=c(1,1))
ggplot(Q3, aes(x=year, y=Emissions, group=type, colour=type)) + geom_line() + xlab("Year") + 
  ylab("PM2.5 (tons)") + ggtitle("Total PM2.5 Emissions per year by source type (in tons)")

## Write plot to file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
