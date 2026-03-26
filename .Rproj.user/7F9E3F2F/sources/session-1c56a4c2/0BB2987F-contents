# code/01_clean.R

library(tidyverse)
library(janitor)

covid_raw <- read.csv("data/covid.csv")

covid <- janitor::clean_names(covid_raw)

pick_col <- function(df, options){
  options <- janitor::make_clean_names(options)
  hit <- options[options %in% names(df)]
  if (length(hit) == 0) return(NA_character_)
  hit[1]
}

case_candidates <- c("total_cases", "cases", "confirmed_cases", "confirmed", "cumulative_cases", "new_cases")
death_candidates <- c("total_deaths", "deaths", "confirmed_deaths", "cumulative_deaths", "new_deaths")
date_candidates <- c("date", "report_date", "time", "day")
place_candidates <- c("location", "country", "country_region", "state", "province_state", "region", "county")

case_col <- pick_col(covid, case_candidates)
death_col <- pick_col(covid, death_candidates)
date_col <- pick_col(covid, date_candidates)
place_col <- pick_col(covid, place_candidates)

if (is.na(case_col)) {
  stop("Couldn't find a cases column.")
}
if (is.na(death_col)) {
  stop("Couldn't find a deaths column.")
}

covid <- covid %>%
  mutate(
    cases_num = suppressWarnings(as.numeric(gsub(",", "", .data[[case_col]]))),
    deaths_num = suppressWarnings(as.numeric(gsub(",", "", .data[[death_col]])))
  )

if (!is.na(date_col)) {
  covid <- covid %>%
    mutate(date_parsed = suppressWarnings(as.Date(.data[[date_col]])))
}

covid_analysis <- covid %>%
  filter(!(is.na(cases_num) & is.na(deaths_num)))

# save cleaned data and column names
if (!dir.exists("output")) dir.create("output")
saveRDS(covid_analysis, file = "output/covid_analysis.rds")
saveRDS(list(case_col = case_col, death_col = death_col, date_col = date_col, place_col = place_col),
        file = "output/cols_used.rds")
