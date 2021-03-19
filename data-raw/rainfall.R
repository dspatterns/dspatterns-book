library(tidyverse)

#
# The `rainfall` dataset
#

rainfall <-
  readr::read_csv("./data-raw/rainfall.csv", col_types = "iddddddd")
