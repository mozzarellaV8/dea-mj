# Federal Bureau of Prisons data
# First Look
# https://www.bop.gov/locations/

# load data -------------------------------------------------------------------

prisons <- read.csv("data/FBP.csv")
str(prisons)
summary(prisons)

# exploratory -----------------------------------------------------------------

library(plyr)
library(tidyr)
library(ggplot2)

states <- as.data.frame(table(prisons$state))
states <- rename(states, replace = c("Var1" = "state", "Freq" = "NumPrisons"))

# create regions
MidAtlantic <- as.factor(c("DE", "WV", "VA", "MD", "NC", "TN", "KY"))
NorthCentral <- as.factor(c("ND", "SD", "NE", "CO", "KS", "MN", "WI", "MI", "IL", "IN", "MO"))
NorthEast <- as.factor(c("ME", "VT", "NH", "MA", "NY", "RI", "CT", "PA", "NJ", "OH"))
SouthCentral <- as.factor(c("TX", "LA", "AR", "OK", "NM"))
SouthEast <- as.factor(c("FL", "MS", "AL", "GA", "SC"))
Western <- as.factor(c("WA", "OR", "CA", "NV", "AZ", "MT", "ID", "WY", "UT"))

prisons$region <- ""

stateV1 <- ggplot(prisons, aes(x = state, fill = state)) + 
  geom_bar(stat = "count") +
  theme_minimal(base_size = 12, base_family = "HersheySans") +
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm")) +
  ggtitle("number of prisons by state") +
  xlab("") + ylab("number of prisons")

stateV1
