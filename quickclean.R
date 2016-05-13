## U.S. Drug Enforcement Administration:
## List of organizations licensed to handle marijuana
## quick clean for geocoding and working with date observations

mj <- read.csv("data/DEA-MJ.csv", stringsAsFactors = FALSE)

library(dplyr)
library(tidyr)

# Registration Date wrangling -------------------------------------------------

library(zoo)
mj$REGISTRATION.DATE[mj$REGISTRATION.DATE == ""] <- NA
mj$REGISTRATION.DATE <- na.locf(mj$REGISTRATION.DATE, na.rm = FALSE)

# separating date values for annual, monthly, daily analysis
mj <- separate(mj, "REGISTRATION.DATE", c("Month", "Date", "Year"), sep = "/",
               convert = TRUE)

# Full Addresses for geocoding ------------------------------------------------
mj$ADDRESS.1[mj$ADDRESS.1 == ""] <- "goddamit"
mj$ADDRESS.2[mj$ADDRESS.2 == ""] <- "goddamit"

mj <- unite(mj, ADDRESS, ADDRESS.1, ADDRESS.2, sep = ", ")

mj$ADDRESS <- gsub("\\(B6\\)", "", mj$ADDRESS)
mj$ADDRESS <- gsub("^,*", "", mj$ADDRESS)
mj$ADDRESS <- gsub(", goddamit", "", mj$ADDRESS)
mj$ADDRESS <- gsub("goddamit", "", mj$ADDRESS)

# preserving individual columns before uniting
mj$City <- mj$CITY
mj$State <- mj$STATE

# uniting cols for simple geocoding
mj <- unite(mj, FullAddress, ADDRESS,
            CITY, STATE, sep = ", ")
mj <- unite(mj, GeoAddress, FullAddress, ZIP, sep = " ")

write.table(mj, file = "dea_MJ-clean.csv", sep = ",", row.names = FALSE)