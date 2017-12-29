# quickplot
# mapping locations licensed to handle marijuana

# load geocoded data ----------------------------------------------------------
mj_coords <- read.csv("data/deaMJ-geo.csv")

library(maptools)
library(mapproj)
library(sp)
library(rgdal)
library(ggmap)

# ggmap ------------------------------------------------------------------------
us <- c(-128.3, -63.92, 21.89, 52.74)
maptype = c("toner")
myMap <- get_map(location = us, source = "stamen", maptype = "toner",
                 crop = FALSE)
ggmap(myMap)
summary(myMap)


# shapelines from rgdal -------------------------------------------------------
usa20m <- readOGR(dsn = "data/2015_us_nation_20m", layer = "cb_2015_us_nation_20m")
# OGR data source with driver: ESRI Shapefile 
# Source:  "data/2015_us_nation_20m", layer: "cb_2015_us_nation_20m"
# with 1 features
# It has 3 fields

# projecting  -----------------------------------------------------------------
usa.web <- spTransform(usa20m, 
                       CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"))

admin.web <- readShapePoly("data/2015_us_nation_20m/cb_2015_us_nation_20m", verbose = TRUE,
                           proj4string = CRS("+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs"))

summary(usa.web)
summary(admin.web)
# Coordinates:
# min       max
# x -179.17426 179.77392
# y   17.91377  71.35256
# Is projected: TRUE 
proj4string(admin.web)

# Delaunay Triangulation ------------------------------------------------------

library(deldir)
mj_coords <- na.omit(mj_coords)
mjTess <- deldir(mj_coords$lon, mj_coords$lat)

plot(mjTess, wlines = "triang", wpoints = "none", number = FALSE, add = TRUE,
     lty = 1, lwd = 0.75, col = "#36648B95")
plot(mjTess, wlines = "tess", wpoints = "none", number = FALSE, add = TRUE,
     lty = 1, lwd = 0.75, col = "#FFFFFF35")


