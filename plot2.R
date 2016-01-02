## total PM2.5 emission from all sources in Baltimore
##for each of the years 1999, 2002, 2005, and 2008

library(dplyr)

## read data from files
NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")

## filter the data of Baltimore
data_bal <- filter(NEI, fips == '24510')
emi_bal <- sapply(split(data_bal, data_bal$year), function(x) sum(x$Emission))

png('plot2.png')
plot(names(emi_bal), emi_bal, xlab = 'Years', ylab = 'PM2.5 (tons)', type = 'o')
title(main = 'Total PM2.5 Emission in Baltimore')
dev.off()