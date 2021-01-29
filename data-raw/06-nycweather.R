library(tidyverse)

#
# The `nycweather` dataset
#

nycweather <-
  readr::read_csv("./data-raw/06-nycweather.csv", col_types = "cciiiiiddddddddddc") %>%
  dplyr::select(time, wd, ws, temp, p = atmos_pres, rh) %>%
  dplyr::mutate(time = time %>% stringr::str_replace("T", " ")) %>%
  dplyr::mutate(time = time %>% stringr::str_replace("Z", ""))
