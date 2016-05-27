## quickclean - DEA list of organizations

_...licensed to handle marijuana_

This [list](http://birrenbach.com/INSTITUTE/wp-content/uploads/2016/04/16-00257-F-Final.xlsx.pdf) magically appeared in my inbox thanks to [Data is Plural](https://tinyletter.com/data-is-plural).

So! What is here is just some simple tidying of the data in R, geared towards parsing the date observations and prepping the addresses to be geocoded. There are a few dirty solutions - ahem, the regex. Will be working to learn regular expressions fully from here on out.

Scripts: 

- [Continental 48](https://github.com/mozzarellaV8/dea-mj/blob/master/continental48.R) initial script for mapping of coordinates
- [quickclean.R](https://github.com/mozzarellaV8/dea-mj/blob/master/quickclean.R) - R script for wrangling
- [geocode.R](https://github.com/mozzarellaV8/dea-mj/blob/master/R%20scripts/geocode.R) - R script for geocoding
- [geocode-free.R](https://github.com/mozzarellaV8/dea-mj/blob/master/R%20scripts/geocode-free.R) - R script for geocoding, split in 2.
- [process](https://github.com/mozzarellaV8/dea-mj/blob/master/process.md) - details on data wrangling approach

Data: 

- [deaMJ-clean.csv](https://github.com/mozzarellaV8/dea-mj/blob/master/DEA-MJ_clean.csv) - DEA list cleaned
- [deaMJ-geo.csv](https://github.com/mozzarellaV8/dea-mj/blob/master/deaMJ-geo.csv) - DEA list cleaned, with addresses geocoded
- [Federal List of Prisons](https://github.com/mozzarellaV8/dea-mj/blob/master/data/FBP.csv) - CSV hand-collected from Federal Bureau of Prisons


### to do 

- look into the NA values in the `deaMJ-geo.csv` list
- ~~introduce coordinate information from Federal Bureau of Prisons.~~
- subset all institutions that are not K9 Training units or Prisons. 
