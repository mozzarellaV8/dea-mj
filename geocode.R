# geocoding the list

library(ggmap)

geocodeQueryCheck(userType = "free")

# load and code----------------------------------------------------------------

mjGeo <- read.csv("DEA-MJ_clean.csv")

coords <- geocode(mjGeo$GeoAddress, output = "latlon",
                 source = "google",
                 force  = ifelse(source == "dsk"))

mjGeo$lon <- coords$lon
mjGeo$lat <- coords$lat
write.table(mjGeo, file = "DEA-MJ-geo.csv", sep = ",", row.names = FALSE)
