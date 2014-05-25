library(plyr)
library(ggplot2)

# Read the data file

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal_subset <- subset(SCC, grepl("Coal", Short.Name))

# Given these differences I believe the best approach is to union the two sets
coal_codes <- coal_subset$SCC
coal_codes<-as.character(coal_codes)

CoalCombustion_set <- subset(NEI, SCC %in% coal_codes)

Coal_emission <- ddply(CoalCombustion_set, .(year, type), function(x) sum(x$Emissions))
colnames(Coal_emission)[3] <- "Emissions"

png("plot4.png")
qplot(year, Emissions, data=Coal_emission, color=type, geom="line") +
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
               color = "black", aes(shape="total"), geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle(expression("Total" ~ PM[2.5] ~ "Emissions by Source Type by Year for Coal")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions"))
dev.off()