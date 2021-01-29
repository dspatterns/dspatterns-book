library(tidyverse)

#
# The `dmd` dataset
#
# This is a cut down and simplified version of the `diamonds` dataset
# that's part of the `ggplot2` package
#

# Set a seed for reproducibility
set.seed(23)

dmd <-
  ggplot2::diamonds %>%
  dplyr::sample_frac(size = 0.05) %>%
  dplyr::select(carat, depth, color, cut, clarity, price) %>%
  dplyr::rename(carats = carat) %>%
  dplyr::mutate(
    cut = as.character(cut),
    color = as.character(color),
    clarity = as.character(clarity)
  ) %>%
  dplyr::mutate(cut = case_when(
    cut %in% c("Good", "Fair") ~ "Fair",
    cut %in% c("Very Good", "Premium") ~ "Great",
    cut == "Ideal" ~ "The Best")
  ) %>%
  dplyr::mutate(clarity = case_when(
    clarity %in% c("I1", "SI2", "SI1", "VS2", "VS1") ~ "Fair",
    clarity %in% c("VVS2", "VVS1") ~ "Great",
    clarity == "IF" ~ "The Best")
  ) %>%
  dplyr::mutate(color = case_when(
    color %in% c("J", "I", "H") ~ "Fair",
    color %in% c("G", "F", "E") ~ "Great",
    color == "D" ~ "The Best")
  ) %>%
  dplyr::arrange(price)

