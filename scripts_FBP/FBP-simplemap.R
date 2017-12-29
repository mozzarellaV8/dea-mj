# # Federal Bureau of Prisons data
# First Look
# https://www.bop.gov/locations/

# load data -------------------------------------------------------------------

prisons <- read.csv("data/FBP-V2.csv")
str(prisons)
summary(prisons)

# exploratory spatial ---------------------------------------------------------

# spatial plot
# some latitudes and longitudes are reversed

library(maps)
par(mar = c(4, 4, 4, 4), family = "HersheySans")
map(database = "usa", mar = c(4, 4, 4, 4))

plot(0, 0, bty = "n", asp = 1, axes = FALSE, 
     xlim = c(-128.3, -63.92), 
     ylim = c(21.89, 52.74), 
     xlab = "", ylab = "")

points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A12", cex = 1.0)
points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A75", cex = 0.5)
points(prisons$lat, prisons$lon, pch = 19, col = "#8B1A1A", cex = 0.2)


# NE Region

map('state', region = c('new york', 'new jersey', 'penn'))



