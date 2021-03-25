library(usethis)

# This script uses `usethis::use_data()` to add data to the package

# Source all of the datasets

# New datasets
source("data-raw/moma.R")
source("data-raw/vitamind.R")


# Existing datasets
source("data-raw/sw.R")
source("data-raw/dmd.R")
source("data-raw/winniweather.R")
source("data-raw/us_cities.R")
source("data-raw/nycweather.R")
source("data-raw/sales.R")
source("data-raw/resto_reviews.R")
source("data-raw/german_cities.R")
source("data-raw/employment.R")
source("data-raw/rainfall.R")
source("data-raw/imdb.R")
source("data-raw/pitchfork.R")

# Create external datasets
use_data(
  # New datasets
  moma,
  vitamind,

  # Existing datasets
  sw,
  dmd,
  winniweather,
  us_cities,
  nycweather,
  sales,
  resto_reviews,
  german_cities,
  employment,
  rainfall,
  imdb,
  pitchfork,
  internal = FALSE,
  overwrite = TRUE
)
