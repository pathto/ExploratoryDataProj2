## total PM2.5 emission from motor vehicle sources in Baltimore
##for each of the years 1999, 2002, 2005, and 2008

library(dplyr)
library(ggplot2)

## read data from files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


## find the emission from motor vehicles
s <- SCC[grep('motor', SCC$Short.Name, ignore.case = TRUE), 'SCC']
emi_motor <- select(filter(NEI, fips %in% c('24510', '06037') & SCC %in% s), 
                        c(year, fips, Emissions))

emi_motor_year <- summarize_each(group_by(emi_motor, fips, year), funs(sum))
emi_motor_year$fips <- factor(emi_motor_year$fips, label = c('Los Angeles County', 
                                                       'Baltimore County'))

png('plot6.png')
p <- qplot(year, Emissions, data = emi_motor_year, group = fips, color = fips, 
           geom = c('line', 'point'), xlab = 'Years', ylab = 'PM2.5 (tons)', 
           main = 'Total PM2.5 Emissions from Motor Vehicle Sources by Counties')
print(p)
dev.off()