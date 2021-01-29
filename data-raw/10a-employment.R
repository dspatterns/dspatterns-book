library(tidyverse)

#
# The `employment` dataset
#

employment <-
  readr::read_csv("./data-raw/10a-employment.csv", col_types = "iiiiii")
