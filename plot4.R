## total PM2.5 emission from Coal Combustion-Related Sources
##for each of the years 1999, 2002, 2005, and 2008

library(dplyr)
library(ggplot2)

## read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## find emission from coal combustion-related sources
s <- SCC[grep('^Fuel Comb', SCC$EI.Sector), 'SCC']
emi <- select(filter(NEI, SCC %in% s), c(year, Emissions))

emi_year <- summarise_each(group_by(emi, year), funs(sum))
png('plot4.png')
g <- ggplot(emi_year, aes(year, Emissions))
p <- g + geom_line() + labs(x = 'Years') + labs(y = 'PM2.5 (tons)') +
        labs(title = 'Total PM2.5 Emissions from Coal Combustion-Related Sources')
print(p)
dev.off()