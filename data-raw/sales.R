library(tidyverse)

#
# The `sales` dataset
#

sales <-
  readr::read_csv("./data-raw/sales.csv", col_types = "cDccd")
