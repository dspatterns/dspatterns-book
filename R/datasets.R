#' Star Wars characters
#'
#' Some characters from Star Wars. This dataset is a downsampled and simplified
#' version of the `starwars` dataset found in the \pkg{dplyr} package.
#' @format A tibble with 87 rows and 8 variables:
#' \describe{
#'   \item{name}{the name of the character}
#'   \item{height}{the character's height in centimeters, where available}
#'   \item{mass}{the character's weight in kilograms, where available}
#'   \item{hair_color}{a description of the character's hair color, where
#'   available; this is occasionally a comma-separated list if there are
#'   multiple colors associated}
#'   \item{gender}{the character's gender}
#'   \item{homeworld}{the name of the character's homeworld}
#'   \item{species}{the name of the character's species}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `sw`
#' dplyr::glimpse(sw)
"sw"

#' Properties and prices of diamonds
#'
#' A dataset that presents prices and attributes of nearly 2,700 diamonds. This
#' dataset is a downsampled and simplified version of the `diamonds` dataset
#' found in the \pkg{ggplot2} package.
#' @format A tibble with 2697 rows and 6 variables:
#' \describe{
#'   \item{carats}{the weight of the diamond in carats, where each carat is
#'   0.2 grams}
#'   \item{depth}{a depth percentage of the diamond that takes into account
#'   the diamond's length, width, and depth distances}
#'   \item{color,cut,clarity}{provides qualitative measures of the diamond's
#'   color, cut, and clarity; the measures for each of these variables are
#'   `Fair`, `Great`, and `The Best`}
#'   \item{price}{the price of the diamond in US Dollars}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `dmd`
#' dplyr::glimpse(dmd)
"dmd"

#' Ambient temperature data from Winnipeg, Canada
#'
#' This is four-times daily, hourly temperatures in the City of Winnipeg, MB.
#' Data is from the airport (YWG) station for the month of February, 2015. This
#' wouldn't be considered a tidy dataset (it's untidy): there are actually four
#' separate observations per row (where each row represents a different day of
#' records).
#' @format A tibble with 28 rows and 6 variables:
#' \describe{
#'   \item{yearmonth}{a representation of the year and the month in character
#'   form; it's given in the format `YYYY-M`}
#'   \item{day}{the day of the month, given as an integer (unlike the combined
#'   year and month, which is character-based)}
#'   \item{temp00_00,temp06_00,temp12_00,temp18_00}{hourly temperatures in
#'   degrees Celsius for the hours of 12 AM, 6 AM, 12 PM, and 6 PM}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `winniweather`
#' dplyr::glimpse(winniweather)
"winniweather"

#' Larger US cities/towns and their populations
#'
#' This contains a subset of US cities and towns and their populations. This is
#' for places with a municipal population of greater than 50,000 people
#' according to 2016 Census data. Obtained from the SimpleMaps website
#' (https://simplemaps.com).
#'
#' @format A tibble with 765 rows and 5 variables:
#' \describe{
#'   \item{city}{The name of the city, town, or unincorporated population
#'   center}
#'   \item{state_id,state_name}{The state or territory's USPS postal
#'   abbreviation and full name}
#'   \item{pop_urb,pop_mun}{The urban and municipal populations (uses 2016
#'   Census data)}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `us_cities`
#' dplyr::glimpse(us_cities)
"us_cities"

#' Weather in New York City
#'
#' This contains select weather data for New York City in 2010. The
#' meteorological data was recorded at Laguardia Airport. Data was retrieved by
#' using the \pkg{stationaRy} R package. The data was originates from the
#' Integrated Surface Dataset (ISD), which is maintained by the National Oceanic
#' and Atmospheric Administration (NOAA).
#'
#' @format A tibble with 13,306 rows and 6 variables:
#' \describe{
#'   \item{time}{The date-time value for the observations}
#'   \item{wd,wd}{The wind speed and wind direction at the time of observation;
#'   units are degrees (blowing from) and meters per second}
#'   \item{temp}{Temperature in degrees Celsius at the time of observation}
#'   \item{p}{The atmospheric pressure in hPa units}
#'   \item{rh}{The relative humidity as a percentage value (in range of `0` to
#'   `100`)}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `nycweather`
#' dplyr::glimpse(nycweather)
"nycweather"

#' Item sales from a shop that doesn't actually exist
#'
#' This contains synthetic sales data for the month of January in 2019. Each row
#' constitutes an individual item sold. Multiple items could be sold as part of
#' a single order; the date and time indicate the time of the order. The `price`
#' is the sell price for the item.
#'
#' @format A tibble with 13,306 rows and 6 variables:
#' \describe{
#'   \item{order_id}{The id value for the order; each order can take multiple
#'   rows (where each row is for the sale of an individual item)}
#'   \item{date,time}{The date and time of the order}
#'   \item{item_id}{The id value for the item sold}
#'   \item{price}{The price of the item sold}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `sales`
#' dplyr::glimpse(sales)
"sales"

#' Text from restaurant reviews for Momofuku Noodle Bar in Toronto
#'
#' This dataset is a character vector of 40 restaurant reviews for the Momufuku
#' Noodle Bar located in Toronto, Canada. Reviews were obtained from Yelp and
#' retrieved from <https://www.yelp.ca/biz/momofuku-noodle-bar-toronto>.
#'
#' @format A vector of length 40.
"resto_reviews"

#' Populations of large German cities
#'
#' This dataset contains a population data on a selection of the largest cities
#' in Germany. The name and state of each city are provided as factor columns.
#' Population values are taken from 2011 Census data and 2015 estimate data.
#' Data obtained from the Wikipedia page at
#' <https://en.wikipedia.org/wiki/List_of_cities_in_Germany_by_population>.
#'
#' @format A tibble with 79 rows and 4 variables:
#' \describe{
#'   \item{name,state}{The id value for the order; each order can take multiple
#'   rows (where each row is for the sale of an individual item)}
#'   \item{pop_2015,pop_2011}{The census populations of each city in 2015 and
#'   in 2011}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `german_cities`
#' dplyr::glimpse(german_cities)
"german_cities"

#' US employment figures from 1941 to 2010
#'
#' A dataset originally derived from thew USA Bureau of Labor Statistics. Data
#' obtained in tabular form from <https://datahub.io/core/employment-us> but
#' only a subset of columns was used here.
#'
#' @format A tibble with 71 rows and 6 variables:
#' \describe{
#'   \item{year}{The year for which the employment values apply.}
#'   \item{population}{The total population of employable citizens.}
#'   \item{employed}{The amount of citizens employed during the year.}
#'   \item{agriculture,nonagriculture}{The amount of citizens employed in the
#'   agricultural sector and those that were not}
#'   \item{unemployed}{The amount of employable citizens that were unemployed
#'   during the year.}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `employment`
#' dplyr::glimpse(employment)
"employment"

#' Yearly total rainfall amounts for seven cities in Canada
#'
#' @format A tibble with 25 rows and 8 variables:
#' \describe{
#'   \item{year}{The year for which the total rainfall amount applies.}
#'   \item{r_vancouver,r_calgary,r_kenora,r_toronto,r_montreal,r_halifax,r_stjohns}{
#'   Total rainfall amounts (in millimeters) for the cities Vancouver, BC;
#'   Calgary, AB; Kenora, ON; Toronto, ON; Montreal, QC; Halifax, NS; and
#'   St. John's, NL.}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `rainfall`
#' dplyr::glimpse(rainfall)
"rainfall"

#' Album reviews from the Pitchfork website (1999-2018)
#'
#' @format A tibble with 20,852 rows and 7 variables:
#' \describe{
#'   \item{artist,album,year}{The album artist, album name, and its year of
#'   release.}
#'   \item{genre}{One or more comma-separated musical genres applied to the
#'   album by the reviewer.}
#'   \item{score}{The reviewer score for the album (from 0 to 10).}
#'   \item{date}{The publication date of the review.}
#'   \item{link}{A link to the album review on the Pitchfork website.}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `pitchfork`
#' dplyr::glimpse(pitchfork)
"pitchfork"

#' Film reviews from the IMDB website (2000-2015)
#'
#' @format A tibble with 2,607 rows and 5 variables:
#' \describe{
#'   \item{title,year}{The title of the film and its year of release.}
#'   \item{score}{The aggregate rating for the film (from 0 to 10), based on
#'   voluntary user reviews at the site.}
#'   \item{budget,gross}{The reported budget for the film and its worldwide
#'   gross earnings (both in U.S. dollars).}
#' }
#'
#' @examples
#' # Here is a glimpse at the data
#' # available in `imdb`
#' dplyr::glimpse(imdb)
"imdb"

#' Datasets in the edr package
edr_datasets <- function() {
  c(
    "sw",
    "dmd",
    "winniweather",
    "us_cities",
    "nycweather",
    "sales",
    "resto_reviews",
    "german_cities",
    "employment",
    "rainfall",
    "pitchfork",
    "imdb"
  )
}
