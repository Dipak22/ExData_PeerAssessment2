library(plyr)
library(ggplot2)

# Read the data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore <- subset(NEI, fips == "24510" & type=="ON-ROAD")

Baltimore_emission <- ddply(Baltimore, .(year), function(x) sum(x$Emissions))
colnames(Baltimore_emission)[2] <- "Emissions"
Baltimore_emission$Type<-"Baltimore"

California<-subset(NEI, fips == "06037" & type=="ON-ROAD")
California_emission<-ddply(California, .(year), function(x) sum(x$Emissions))
colnames(California_emission)[2] <- "Emissions"
California_emission$Type<-"California"
merged_data<-rbind(Baltimore_emission,California_emission)

png("plot6.png")
qplot(year, Emissions, data=merged_data, geom="line",color=Type) +
  ggtitle(expression("MOtor Vehicle" ~ PM[2.5] ~ "Emissions by Year for Baltimore and California")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))
dev.off()