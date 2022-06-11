## Reading from the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping the Data
baltcitymary_emissions<-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
losangelscal_emissions<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltcitymary_emissions$County <- "Baltimore City, MD"
losangelscal_emissions$County <- "Los Angeles County, CA"
both_emissions <- rbind(baltcitymary_emissions, losangelscal_emissions)

#Plotting the Graph and Saving it as PNG using PNG device
png("plot6.png", width=480, height=480)

## Making the gglot
ggplot(both_emissions, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
        geom_bar(stat="identity") + 
        facet_grid(County~., scales="free") +
        ylab(expression("total PM"[2.5]*" emissions in tons")) + 
        xlab("year") +
        ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
        geom_label(aes(fill = County),colour = "white")

dev.off()