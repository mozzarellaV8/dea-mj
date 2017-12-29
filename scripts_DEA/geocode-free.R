## U.S. Drug Enforcement Administration:
## List of organizations licensed to handle marijuana
## geocoding addresses to get latitude and longitude coordinates

library(dplyr)
library(ggmap)

geocodeQueryCheck(userType = "free")

# load and code----------------------------------------------------------------

mjGeo <- read.csv("DEA-MJ_clean.csv", stringsAsFactors = FALSE)

mjGeo01 <- mjGeo[1:550, 1:8]
mjGeo02 <- mjGeo[551:2953, 1:8]

# 1st set - 001-550 -------------------------------
coords <- geocode(mjGeo550, output = "latlon", source = "google")

mjGeo01$lon <- coords$lon
mjGeo01$lat <- coords$lat

missing01 <- which(is.na(coords))
missing01

# missing lat/lon values:
# 78   98  109  124  133  163  228  236  245  311  349  350  383  384  486  
# 628  648  659  674  683  713  778  786  795  861 899  900  933  934 1036

# 2nd set - 550-2953 ------------------------------
coords2 <- geocode(mjGeoRest$GeoAddress, output = "latlon", source = "google")

mjGeo02$lon <- coords2$lon
mjGeo02$lat <- coords2$lat

missing02 <- which(is.na(coords2))
missing02

# missing lat/lon values: 
# 21  128  134  170  177  199  256  372  391  409  442  526  573  616  702  
# 765 1071 1165 1166 1173 1286 1399 1509 1750 1826 2057 2096 2280 2323 2424
# 2531 2537 2573 2580 2602 2659 2775 2794 2812 2845 2929 2976 3019 3105 3168 
# 3474 3568 3569 3576 3689 3802 3912 4153 4229 4460 4499 4683 4726

# combine into one CSV --------------------------------------------------------
mjGeoCoords <- bind_rows(mjGeo550, mjGeoRest)

write.table(mjGeoCoords, file = "deaMJ-geo.csv", sep = ",", row.names = FALSE)