library(tidyverse)

#
# The `sales` dataset
#

sales <-
  readr::read_csv("./data-raw/07-sales.csv", col_types = "cDccd")
