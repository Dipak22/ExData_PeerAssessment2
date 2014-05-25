NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalemission_year <- tapply(NEI$Emissions, NEI$year, sum)
year<-NEI$year

png("plot1.png")
plot(year, totalemission_year, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions"),
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year"))
dev.off()