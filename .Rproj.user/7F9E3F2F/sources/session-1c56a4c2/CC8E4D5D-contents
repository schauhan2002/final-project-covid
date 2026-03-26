# code/03_figure.R

library(tidyverse)

covid_analysis <- readRDS("output/covid_analysis.rds")
cols_used <- readRDS("output/cols_used.rds")
case_col <- cols_used$case_col
death_col <- cols_used$death_col

p <- ggplot(covid_analysis, aes(x = cases_num, y = deaths_num)) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Relationship Between COVID-19 Cases and Deaths",
    x = paste0("COVID-19 Cases (", case_col, ")"),
    y = paste0("COVID-19 Deaths (", death_col, ")")
  ) +
  theme_minimal()

if (!dir.exists("output")) dir.create("output")
ggsave("output/cases_deaths_scatter.png", plot = p, width = 6, height = 4)
