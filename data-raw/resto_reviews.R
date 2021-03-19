library(tidyverse)

#
# The `resto_reviews` dataset
#

resto_reviews <-
  readr::read_csv("./data-raw/resto_reviews.csv", col_types = "c") %>%
  dplyr::pull(review)
