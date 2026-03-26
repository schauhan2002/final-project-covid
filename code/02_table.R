# code/02_table.R

library(tidyverse)
library(knitr)
library(kableExtra)

covid_analysis <- readRDS("output/covid_analysis.rds")

summary_table <- covid_analysis %>%
  summarise(
    Cases_Mean = mean(cases_num, na.rm = TRUE),
    Cases_Median = median(cases_num, na.rm = TRUE),
    Cases_Max = max(cases_num, na.rm = TRUE),
    Deaths_Mean = mean(deaths_num, na.rm = TRUE),
    Deaths_Median = median(deaths_num, na.rm = TRUE),
    Deaths_Max = max(deaths_num, na.rm = TRUE),
    N_Rows = n()
  ) %>%
  mutate(across(where(is.numeric), ~ round(.x, 2)))

# save the table for the report
if (!dir.exists("output")) dir.create("output")
saveRDS(summary_table, file = "output/summary_table.rds")
