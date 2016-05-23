# quickplot
# mapping locations licensed to handle marijuana
# *Projection still needs more exploration.

library(maptools)
library(mapproj)
library(sp)
library(rgdal)

# load geocoded data ----------------------------------------------------------
mj_coords <- read.csv("data/deaMJ-geo.csv")

# shapelines from rgdal -------------------------------------------------------
usa20m <- readOGR(dsn = "data/2015_us_nation_20m", layer = "cb_2015_us_nation_20m")
# OGR data source with driver: ESRI Shapefile 
# Source:  "data/2015_us_nation_20m", layer: "cb_2015_us_nation_20m"
# with 1 features
# It has 3 fields

# converting NADS83 TO WGS84 --------------------------------------------------

usa20m <- spTransform(usa20m, 
                      CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

admin20m <- readShapePoly("data/2015_us_nation_20m/cb_2015_us_nation_20m", verbose = TRUE,
                          proj4string = CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"))

summary(usa20m)
summary(admin20m)

# continental US / lower 48 projected -----------------------------------------

par(mar = c(2, 2, 2, 2), family = "HersheySans", bg = "#FFFFFF")

map(admin20m, bty = "n", asp = 1, 
    xlim = c(-128.3, -63.92), 
    ylim = c(21.89, 52.74), 
    xlab = "", ylab = "", 
    col = "grey82")

points(mj_coords$lon, mj_coords$lat, pch = 19,
       col = "#CD000050", cex = 1.0)
points(mj_coords$lon, mj_coords$lat, pch = 1,
       col = "#CD000050", cex = 1.0)

bounds <- par("usr")
bounds # -128.71520  -63.50480   11.23642   63.39358
# -95.75, 37.31 midpoints
text(-95.75, 56, labels = "DEA Federal List of Organizations",
     col = "#000000", family = "HersheySans")
text(-95.75, 55, labels = "licensed to handle marijuana",
     col = "#000000", family = "HersheySans", font = 3)

# Delaunay Triangulation ------------------------------------------------------

library(deldir)
mj_coords <- na.omit(mj_coords)
mjTess <- deldir(mj_coords$lon, mj_coords$lat)

plot(mjTess, wlines = "triang", wpoints = "none", number = FALSE, add = TRUE,
     lty = 1, lwd = 0.675, col = "#36648B65")

plot(mjTess, wlines = "tess", wpoints = "none", number = FALSE, add = TRUE,
     lty = 1, lwd = 0.675, col = "#FFFFFF35")

