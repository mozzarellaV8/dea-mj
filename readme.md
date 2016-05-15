## quickclean - DEA list of organizations

_...licensed to handle marijuana_

This [list](http://birrenbach.com/INSTITUTE/wp-content/uploads/2016/04/16-00257-F-Final.xlsx.pdf) magically appeared in my inbox thanks to [Data is Plural](https://tinyletter.com/data-is-plural).

So! What is here is just some simple tidying of the data in R, geared towards parsing the date observations and prepping the addresses to be geocoded. There are a few dirty solutions - ahem, the regex. Will be working to learn regular expressions fully from here on out.

- [quickclean.R](https://github.com/mozzarellaV8/dea-mj/blob/master/quickclean.R) - R script
- [DEA-MJ_clean.csv](https://github.com/mozzarellaV8/dea-mj/blob/master/DEA-MJ_clean.csv) - the result

- [deaMJ-geo.csv](https://github.com/mozzarellaV8/dea-mj/blob/master/deaMJ-geo.csv) - DEA list cleaned, with addresses geocoded

- [process](https://github.com/mozzarellaV8/dea-mj/blob/master/process.md) - details on data wrangling approach
- [notes](https://github.com/mozzarellaV8/dea-mj/blob/master/notes.md) - initial EDA/notes on potential uses for list