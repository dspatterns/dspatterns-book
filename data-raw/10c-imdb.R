library(tidyverse)

#
# The `imdb` dataset
#

imdb <-
  readr::read_csv("./data-raw/10c-imdb.csv", col_types = "cdddcccDcc") %>%
  dplyr::select(title, score, budget, gross, date) %>%
  dplyr::mutate(
    budget = as.numeric(budget),
    gross = as.numeric(gross),
    year = lubridate::year(date)
  ) %>%
  dplyr::filter(year %in% 2000:2015) %>%
  dplyr::filter(!is.na(budget)) %>%
  dplyr::filter(!is.na(gross)) %>%
  dplyr::filter(!is.na(score)) %>%
  dplyr::filter(!is.na(year)) %>%
  dplyr::select(title, year, score, budget, gross) %>%
  dplyr::distinct()
