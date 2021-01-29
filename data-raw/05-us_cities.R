library(tidyverse)

#
# The `us_cities` dataset
#
# This comes from the SimpleMaps website (https://simplemaps.com). The CSV data
# was downloaded from https://simplemaps.com/data/us-cities on April 29, 2019
# and saved as `05-us_cities.csv`.

us_cities <-
  readr::read_csv(
    "./data-raw/05-us_cities.csv",
    col_types = "ccccdcdddddclccd") %>%
  dplyr::select(
    city_ascii, state_id, state_name,
    population, population_proper) %>%
  dplyr::arrange(state_id, city_ascii) %>%
  dplyr::filter(population_proper > 50000) %>%
  dplyr::rename(
    pop_urb = population,
    pop_mun = population_proper,
    city = city_ascii
  )

