library(tidyverse)

#
# The `winniweather` dataset
#
# This comes from the Environment Canada Weather Information website
# https://weather.gc.ca/ The downloaded CSV data was processed and reduced in
# content (both in rows and columns) and saved here as `04-winniweather.csv`
#

winniweather <-
  readr::read_csv("./data-raw/04-winniweather.csv", col_types = "iiicdiiid") %>%
  tidyr::replace_na(list(temp_c = 9999)) %>%
  dplyr::mutate(yearmonth = paste(year, month, sep = "-")) %>%
  dplyr::select(yearmonth, dplyr::everything(), -year, -month) %>%
  dplyr::filter(time %in% c("00:00", "06:00", "12:00", "18:00")) %>%
  dplyr::select(-rh_pct, -wd, -ws, -stn_p) %>%
  tidyr::pivot_wider(names_from = time, values_from = temp_c) %>%
  dplyr::rename(
    temp00_00 = `00:00`,
    temp06_00 = `06:00`,
    temp12_00 = `12:00`,
    temp18_00 = `18:00`
  )
