library(tidyverse)

#
# The `sw` dataset
#
# This is a simplified version of the `starwars` dataset
# that's part of the `dplyr` package
#

sw <-
  dplyr::starwars %>%
  dplyr::select(
    name, height, mass, hair_color, birth_year,
    gender, homeworld, species)

