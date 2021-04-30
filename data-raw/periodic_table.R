library(tidyverse)
library(jsonlite)

#
# The `periodic_table` dataset
#

periodic_table <-
  jsonlite::fromJSON(
    "data-raw/periodic_table.json",
    ) %>%
  dplyr::as_tibble() %>%
  tidyr::unpack(cols = everything()) %>%
  dplyr::select(
    number, symbol, name, atomic_mass, category,
    phase, boil, melt, molar_heat, density,
    ea = electron_affinity,
    en = electronegativity_pauling,
    appearance, period, xpos, ypos,
    discovered_by
  )
