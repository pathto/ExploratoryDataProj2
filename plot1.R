## total PM2.5 emission from all sources in US for each of the years 1999, 2002,
## 2005, and 2008

## read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate the total by year
emi_us <- sapply(split(NEI, NEI$year), function(x) sum(x$Emissions))
png('plot1.png')
plot(names(emi_us), emi_us, xlab = 'Years', ylab = 'PM2.5 (tons)', type = 'o')
title(main = 'Total PM2.5 Emission in US')
dev.off()