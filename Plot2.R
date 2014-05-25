NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Baltimore<- subset(NEI, fips == "24510")

Emission_year <- tapply(Baltimore$Emissions, Baltimore$year, sum)

png("plot2.png")
plot(names(Emission_year), Emission_year, type="l",
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions"),
     main=expression("Total" ~ PM[2.5] ~ "Emissions per Year in Baltimore City"))
dev.off()