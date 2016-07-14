# # Federal Bureau of Prisons data
# First Look
# https://www.bop.gov/locations/

# load data -------------------------------------------------------------------

prisons <- read.csv("data/FBP.csv")
str(prisons)
summary(prisons)

# exploratory spatial ---------------------------------------------------------

library(rgdal)
library(sp)
library(maptools)
library(mapproj)

# shapelines from rgdal 
usa1 <- readOGR(dsn = "data/usa-1", layer = "USA_adm1")
# 52 features, 12 fields
usa2 <- readOGR(dsn = "data/usa-2", layer = "USA_adm2")
# 3148 features, 14 fields

summary(usa1)
# [+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0]
summary(usa2)
# [+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0]

# bounding for both:
#          min      max
# x -179.15056 179.7734
# y   18.90986  72.6875

usa1shape <- readShapePoly("data/usa-1/USA_adm1", verbose = TRUE)
usa1lines <- readShapeLines("data/usa-1/USA_adm1")

# spatial plot
# some latitudes and longitudes are reversed
par(mar = c(2, 2, 2, 2), family = "HersheySans", bg = "#EEE5DE75")

plot(0, 0, bty = "n", asp = 1, axes = FALSE, 
     xlim = c(-128.3, -63.92), 
     ylim = c(21.89, 52.74), 
     xlab = "", ylab = "", 
     col = "grey82")

points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A12", cex = 1.0)
points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A75", cex = 0.5)
points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A", cex = 0.2)
lines(usa1lines, lty = 2, col = "cadetblue4", cex = 0.65)
