library(tidyverse)

#
# The `german_cities` dataset
#

german_cities <-
  read.csv("./data-raw/09-german_cities.csv") %>%
  dplyr::as_tibble() %>%
  dplyr::arrange(name, state, pop_2011, pop_2015)
