library(tidyverse)

#
# The `maze` dataset
#

maze <-
  readr::read_csv("data-raw/maze.csv", col_types = "cddccddddddd")
