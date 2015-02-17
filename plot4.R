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
  
## Q4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

## Filter by Combustion
combustion <- SCC[grep("Combustion", SCC$SCC.Level.One),] 

## Filter further by Coal
coal <- combustion[grep("Coal", combustion$SCC.Level.Three),]

## Select data
total <- NEI[NEI$SCC %in% coal$SCC,] 

## Aggregate data
Q4 <- aggregate(Emissions ~ year, data = total, sum) # aggregate data

## Plot data
par(mfrow=c(1,1))
ggplot(Q4, aes(x=year, y=Emissions)) + geom_line() + xlab('Year') + ylab('Total PM2.5 Emissions (tons)') +
  ggtitle('Total US emissions of PM2.5 from coal combustion-related sources')

## Write plot to file
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()