## Reading from the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping the Data
combustion_coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion_coal_sources <- SCC[combustion_coal,]

# Find emissions from coal combustion-related sources
emissions_coal_combustion <- NEI[(NEI$SCC %in% combustion_coal_sources$SCC), ]
emissions_coal_related <- summarise(group_by(emissions_coal_combustion, year), Emissions=sum(Emissions))

#Plotting the Graph and Saving it as PNG using PNG device
png("plot4.png", width=480, height=480)

## Making the gglot
ggplot(emissions_coal_related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
        ggtitle("Emissions from coal combustion-related sources in kilotons")+
        geom_label(aes(fill = year),colour = "white")

dev.off()