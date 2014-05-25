library(plyr)
library(ggplot2)

# Read the data file

NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")


Baltimore <- subset(NEI, fips == "24510" & type=="ON-ROAD")

Baltimore_emission <- ddply(Baltimore, .(year), function(x) sum(x$Emissions))
colnames(Baltimore_emission)[2] <- "Emissions"

png("plot5.png")
qplot(year, Emissions, data=Baltimore_emission, geom="line") +
  ggtitle(expression("Motor Vehicle " ~ PM[2.5] ~ " Emissions by Year for Baltimore City")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))
dev.off()