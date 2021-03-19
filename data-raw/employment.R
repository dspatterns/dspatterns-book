library(tidyverse)

#
# The `employment` dataset
#

employment <-
  readr::read_csv("./data-raw/employment.csv", col_types = "iiiiii")
