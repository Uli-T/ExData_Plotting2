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

## Q2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?
## Use the base plotting system to make a plot answering this question.

## Select data for Baltimore (fips 24510)
Baltimore <- NEI[which(NEI$fips == "24510"),]

## Aggregate data
Q2 <- aggregate(Emissions ~ year, data = Baltimore, sum)

## Plot datas
par(mfrow=c(1,1))
plot(Q2, type="b", main = "Total PM2.5 Emissions of Baltimore City, MD", xlab="Year", ylab="Total PM2.5 emission (in tons)")

## Save plot to file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()