## Reading from the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping the Data
baltcitymary_emissions_byyear<-summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))

#Plotting the Graph and Saving it as PNG using PNG device
png("plot3.png", width=960, height=960)

## Making the gglot
ggplot(baltcitymary_emissions_byyear, aes(x=factor(year), y=Emissions, fill=type,label = round(Emissions,2))) +
        geom_bar(stat="identity") +
        facet_grid(. ~ type) +
        xlab("year") +
        ylab(expression("total PM"[2.5]*" emission in tons")) +
        ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ","City by various source types", sep="")))+
        geom_label(aes(fill=type),colour = "white")

dev.off()
       