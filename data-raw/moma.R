library(tidyverse)

#
# The `moma` dataset
#

moma <-
  readr::read_csv(
    here::here("data-raw", "moma.csv"),
    col_types = "ccciiiiiciidddddddcllcc"
  )



