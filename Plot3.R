library(plyr)
library(ggplot2)

# Read the data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510")

emssion_baltimore <- ddply(Baltimore, .(year, type), function(x) sum(x$Emissions))
colnames(emssion_baltimore)[3] <- "Emissions"

png("plot3.png")
qplot(year, Emissions, data=emssion_baltimore, color=type, geom="line") +
  ggtitle(expression("Total" ~ PM[2.5] ~ "Emissions by Source by Year in Baltimore City.")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))
dev.off()