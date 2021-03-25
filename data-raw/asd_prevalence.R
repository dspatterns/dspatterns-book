library(tidyverse)

#
# The `asd_prevalence` dataset
#

asd_prevalence <-
  readr::read_csv("data-raw/asd_prevalence.csv", col_types = "dccddddddddcddddddllcdddd")
