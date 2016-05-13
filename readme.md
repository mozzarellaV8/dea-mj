## quickclean - DEA list of organizations licensed to handle marijuana

This [list](http://birrenbach.com/INSTITUTE/wp-content/uploads/2016/04/16-00257-F-Final.xlsx.pdf) magically appeared in my inbox thanks to [Data is Plural](https://tinyletter.com/data-is-plural).

So! What is here is just some simple tidying of the data in R, geared towards parsing the date observations and prepping the addresses to be geocoded. There are a few dirty solutions - ahem, the regex. Will be working to learn regular expressions fully from here on out.

[quickclean.R](https://github.com/mozzarellaV8/dea-mj/blob/master/quickclean.R) is the script and [DEA-MJ_clean.csv](https://github.com/mozzarellaV8/dea-mj/blob/master/DEA-MJ_clean.csv) is the result.

#### Registration Date wrangling

If there were multiple licenses registered on one day, only one date would be added to the spreadsheet and the rest left empty until a new date with new license info was added. I'd begun by converting the blank values to NAs, and below is an illustration of the issue and desired outcome. 

``` {r}
mj[4, 1]                # [1] "3/1/1991"
mj[5:7, 1]              # [1] NA NA NA
mj[5:7, 1] <- mj[4, 1]  
mj[5:7, 1]              # [1] "3/1/1991" "3/1/1991" "3/1/1991"
```

What I wanated to do was fill in the NA values with the preceding date value. This seemed to be pretty easy using `na.locf` from the `zoo` library.

``` {r}
head(mj$REGISTRATION.DATE)
[1] "12/31/1990" NA           "5/15/1991"  "3/1/1991"   NA           NA

library(zoo)
mj$REGISTRATION.DATE <- na.locf(mj$REGISTRATION.DATE, na.rm = FALSE)

head(mj$REGISTRATION.DATE)
[1] "12/31/1990" "12/31/1990" "5/15/1991"  "3/1/1991"   "3/1/1991"   "3/1/1991"  
```

From there went on to `separate` the dates into their own Month, Date, and Year columns. 

#### Addresses for geocoding

The address information was originally provided in four columns: `ADDRESS.1`, `ADDRESS.2`, `CITY`, and `STATE`. My thinking was, it'd be a mess to try to geocode using information from 4 columns, so through a dirty process ended up united these four into one. Also preserved the `CITY`and `STATE` columns, in the event that those might be quantified for study. 

Ran into an issue when trying to remove trailing commas, but seemed to have found a bad workaround by misusing `gsub`. `",*$"` wouldn't remove the end-of-string commas, so I added a word to each field following the comma and removed that afterwards:

``` {r}
mj$ADDRESS.1[mj$ADDRESS.1 == ""] <- "goddamit"
mj$ADDRESS.2[mj$ADDRESS.2 == ""] <- "goddamit"

mj <- unite(mj, ADDRESS, ADDRESS.1, ADDRESS.2, sep = ", ")

mj$ADDRESS <- gsub("^,*", "", mj$ADDRESS)
mj$ADDRESS <- gsub(", goddamit", "", mj$ADDRESS)
mj$ADDRESS <- gsub("goddamit", "", mj$ADDRESS)
```

Not a proud moment, but will be continuing to learn the nuances of regex and approaches to handling different kinds of messy data. Although now that I think of it, `"goddamit"` could have been replaced with `NA` from the start. 
