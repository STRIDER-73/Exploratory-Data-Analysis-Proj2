## Reading from the file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grouping the Data
baltcitymary_emissions<- summarise(group_by(filter(NEI,fips=="24510"), year), Emissions=sum(Emissions))

#Plotting the Graph and Saving it as PNG using PNG device
png("plot2.png", width=480, height=480)

## Making the Bar plot
x2<-barplot(height=baltcitymary_emissions$Emissions/1000, names.arg=baltcitymary_emissions$year,
        xlab="Years", ylab=expression('total PM'[2.5]*' emission in Kilotons'),ylim=c(0,4),
        main=expression('Total PM'[2.5]*' emissions in Baltimore City-MD in kilotons'))

## Making the exact amt to appear on top of the plot
text(x = x2, y = round(baltcitymary_emissions$Emissions/1000,2), label = round(baltcitymary_emissions$Emissions/1000,2), pos = 3, cex = 0.8, col = "black")

dev.off()
