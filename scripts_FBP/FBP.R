# Federal Bureau of Prisons data
# First Look
# https://www.bop.gov/locations/

# load data -------------------------------------------------------------------

prisons <- read.csv("data/FBP-V2.csv")
str(prisons)
summary(prisons)

# exploratory -----------------------------------------------------------------
library(plyr)
library(tidyr)

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
ifelse(prisons$state == "DE"|"WV"|"VA"|"MD"|"NC"|"TN"|"KY", 
       prisons$region == "MidAtlantic", NA)

library(ggplot2)
library(RColorBrewer)
display.brewer.all()

state_pal <- brewer.pal(6, "Reds")

stateV1 <- ggplot(prisons, aes(x = state, fill = state)) + 
  geom_bar(stat = "count") +
  theme_minimal(base_size = 12, base_family = "HersheySans") +
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm")) +
  ggtitle("number of prisons by state") +
  xlab("") + ylab("number of prisons") +
  scale_fill_brewer(palette = "Reds")
stateV1

stateV2 <- ggplot(states, aes(x = state, y = NumPrisons, fill = NumPrisons)) + 
  geom_bar(stat = "identity", width = 0.75) +
  theme_minimal(base_size = 12, base_family = "HersheySans") +
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm")) +
  ggtitle("federal prisons by state") +
  xlab("") + ylab("number of prisons")
stateV2

stateV3 <- ggplot(states, aes(x = reorder(state, NumPrisons),
                              y = NumPrisons, fill = NumPrisons)) + 
  geom_bar(stat = "identity", width = 0.75) +
  theme_minimal(base_size = 12, base_family = "HersheySans") +
  theme(plot.margin = unit(c(1, 1, 1, 1), "cm")) +
  ggtitle("federal prisons by state") +
  xlab("") + ylab("number of prisons") +
  labs(fill = "") +
  theme(axis.text.x = element_text(size = 14),
        axis.text.y = element_text(size = 14))
stateV3

# find land area of each state

