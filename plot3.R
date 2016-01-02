## total PM2.5 emission in Baltimore by the four types of sources
##for each of the years 1999, 2002, 2005, and 2008

library(dplyr)
library(ggplot2)

## read data from files
NEI <- readRDS("summarySCC_PM25.rds")
## SCC <- readRDS("Source_Classification_Code.rds")

## filter the data of Baltimore
data_bal <- filter(NEI, fips == '24510')

data_bal <- select(data_bal, Emissions:year)
emi_type <- summarise_each(group_by(data_bal, type, year), funs(sum))

png('plot3.png')
g <- ggplot(emi_type, aes(year, Emissions))
p <- g + geom_line(aes(group = type, color = type)) + geom_point(aes(group = type, color = type)) + labs(x = 'Years') + labs(y = 'PM2.5 (tons)') +
        labs(title = 'Total PM2.5 Emissions for the Four Types of Sources in Baltimore')
print(p)
dev.off()