data <- read.csv("repdata-data-StormData.csv")

cleanData <- subset(data, !is.na(PROPDMG) & !is.na(CROPDMG), select = c("FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP", "EVTYPE"))

Fatalities <- aggregate(cleanData$FATALITIES, by = list(cleanData$EVTYPE), sum)

topFatal <- Fatalities[order(Fatalities$x, decreasing = TRUE), ][1:20, ]

Injuries <- aggregate(cleanData$INJURIES, by = list(cleanData$EVTYPE), sum)

topInjuries <- Injuries[order(Injuries$x, decreasing = TRUE), ][1:20, ]

loss <- NULL
cleanData$PROPDMGEXP <- as.character(cleanData$PROPDMGEXP)
cleanData$CROPDMGEXP <- as.character(cleanData$CROPDMGEXP)

unique(cleanData$PROPDMGEXP)

cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "+"] <- 0
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "-"] <- 0
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "0"] <- 1
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "1"] <- 10
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "2"] <- 100
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "3"] <- 1000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "4"] <- 10000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "5"] <- 100000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "6"] <- 1000000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "7"] <- 10000000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "8"] <- 100000000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "?"] <- 0
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "B"] <- 1e+9
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "H"] <- 100
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "K"] <- 1000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "M"] <- 1e+6
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "h"] <- 100
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "K"] <- 1000
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == "m"] <- 1e+6
cleanData$PROPDMGEXP[cleanData$PROPDMGEXP == ""] <- 0
cleanData$PROPDMGEXP[is.na(cleanData$PROPDMGEXP)] <- 0

cleanData$PROPLOSS <- as.numeric(cleanData$PROPDMGEXP) * cleanData$PROPDMG


unique(cleanData$CROPDMGEXP)

cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "0"] <- 1
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "2"] <- 100
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "?"] <- 0
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "B"] <- 1e+9
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "K"] <- 1000
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "M"] <- 1e+6
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "k"] <- 1000
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == "m"] <- 1e+6
cleanData$CROPDMGEXP[cleanData$CROPDMGEXP == ""] <- 0
cleanData$CROPDMGEXP[is.na(cleanData$CROPDMGEXP)] <- 0

cleanData$CROPLOSS <- as.numeric(cleanData$CROPDMGEXP) * cleanData$CROPDMG

cleanData$TOTALLOSS <- cleanData$CROPLOSS + cleanData$PROPLOSS

propLoss <- aggregate(cleanData$PROPLOSS, by = list(cleanData$EVTYPE), sum)
cropLoss <- aggregate(cleanData$CROPLOSS, by = list(cleanData$EVTYPE), sum)
totalLoss <- aggregate(cleanData$TOTALLOSS, by = list(cleanData$EVTYPE), sum)
topPropLoss <- propLoss[order(propLoss$x, decreasing = TRUE), ][1:20, ]
topCropLoss <- cropLoss[order(cropLoss$x, decreasing = TRUE), ][1:20, ]
topTotalLoss <- totalLoss[order(totalLoss$x, decreasing = TRUE), ][1:20, ]

########

print(topFatal)
print(topInjuries)

par(mfrow=c(2,1))
barplot(topFatal$x, names.arg = topFatal$Group.1, main = "Fatalities", cex.axis = 0.8, cex.names = 0.7, las = 2)
barplot(topInjuries$x, names.arg = topInjuries$Group.1, main = "Injuries", cex.axis = 0.8, cex.names = 0.7, las = 2)


print(topPropLoss)
print(topCropLoss)

par(mfrow=c(2,1))
barplot(topPropLoss$x, names.arg = topPropLoss$Group.1, main = "Property Loss", cex.axis = 0.8, cex.names = 0.7, las = 2)
barplot(topCropLoss$x, names.arg = topCropLoss$Group.1, main = "Crop Loss", cex.axis = 0.8, cex.names = 0.7, las = 2)


print(topTotalLoss)
barplot(topTotalLoss$x, names.arg = topTotalLoss$Group.1, main = "Total Loss", cex.axis = 0.8, cex.names = 0.7, las = 2)

