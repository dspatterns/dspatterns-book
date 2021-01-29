library(tidyverse)
library(RSQLite)
library(lubridate)


#
# The `pitchfork` dataset
#

conn <- RSQLite::dbConnect(RSQLite::SQLite(), "./data-raw/10d-pitchfork.db")

pitchfork <-
  dplyr::tbl(src = conn, "reviews") %>%
  dplyr::select(artist, album, genre, score, date, link) %>%
  dplyr::collect() %>%
  dplyr::mutate(
    date = lubridate::parse_date_time(date, orders = "%B %d Y") %>%
      lubridate::as_date()
  ) %>%
  dplyr::mutate(year = lubridate::year(date)) %>%
  dplyr::select(artist, album, year, genre, score, date, link) %>%
  dplyr::filter(year < 2019) %>%
  dplyr::distinct()

