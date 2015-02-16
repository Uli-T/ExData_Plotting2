## Exploratory Data Analysis: Course Project 2
## https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/4/submissions

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

## Q1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system,
## make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Aggregate datas
Q1 <- aggregate(Emissions ~ year, data = NEI, sum)

## Plot data
par(mfrow=c(1,1))
plot(Q1, type="b", main = "Total PM2.5 Emissions in the US", xlab="Year", ylab="Total PM2.5 emission (in tons)")

## Save plot in file
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()