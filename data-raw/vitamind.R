library(tidyverse)

#
# The `vitamind` dataset
#

vitamind <-
  readr::read_csv("./data-raw/vitamind.csv", col_types = "fcffdd")
