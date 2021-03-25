library(tidyverse)

#
# The `chopsticks` dataset
#

chopsticks <-
  readr::read_csv("./data-raw/chopsticks.csv", col_types = "dcd") %>%
  dplyr::select(individual, length_amt, efficiency)
