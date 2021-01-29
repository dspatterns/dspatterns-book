library(tidyverse)

#
# The `rainfall` dataset
#

rainfall <-
  readr::read_csv("./data-raw/10b-rainfall.csv", col_types = "iddddddd")
