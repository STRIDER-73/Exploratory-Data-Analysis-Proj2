## Reading from the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping the Data
baltcitymary_emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
baltcitymary_emissions_byyear <- summarise(group_by(baltcitymary_emissions, year), Emissions=sum(Emissions))

#Plotting the Graph and Saving it as PNG using PNG device
png("plot5.png", width=480, height=480)

## Making the gglot
ggplot(baltcitymary_emissions_byyear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emissions in tons")) +
        ggtitle("Emissions from motor vehicle sources in Baltimore City")+
        geom_label(aes(fill = year),colour = "white")

dev.off()