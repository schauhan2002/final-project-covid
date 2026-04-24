# Exploratory Analysis of COVID-19 Data

This repository contains my final project for DATA 550. I use COVID-19 cases and deaths
using a country-level COVID-19 dataset ('data/covid.csv') to explore how reported cases and deaths relate to each other.
The project includes basic data cleaning, a summary table and one main scatterplot figure. 

## How to generate the final report

From the project root, run:

```bash
make
```

This command will run all the scripts below and then create report/final_report.html.

## Code Description

`code/01_clean.R`
- reads the raw COVID-19 data from `data/covid.csv`
- cleans column names and finds which columns contain cases and deaths
- creates numeric versions of cases and deaths
- keeps only rows that have at least one of cases or deaths
- saves the cleaned data as `output/covid_analysis.rds`
- saves the names of the columns used as `output/cols_used.rds`

`code/02_table.R`
- reads the cleaned data from `output/covid_analysis.rds`
- calculates summary statistics for cases and deaths (mean, median, max, and number of rows)
- saves the summary table as `output/summary_table.rds`

`code/03_figure.R`
- reads the cleaned data from `output/covid_analysis.rds` and `output/cols_used.rds`
- creates a scatterplot of cases vs. deaths
- saves the figure as `output/cases_deaths_scatter.png`

`report/final_report.Rmd`
- reads the saved outputs from the `output/` folder
- displays the summary table
- shows the scatterplot figure
- describes the findings in text

## Package environment with renv
This project uses the renv package to manage R package versions and make the analysis reproducible.

To synchronize your R packages with the versions used for this project:

1. Clone this repository and open the project folder in R or RStudio. 
2. In a terminal from the project root, run:

```bash
make install
```
This will install renv (if needed) and run renv::restore() to install all required packages as specified in renv.lock.

From inside R we can run:

```r
install.packages("renv") # if needed
renv::restore() # use the lockfile to install project packages
```
## Docker image

This project includes a Docker image that can be used to reproduce the analysis and render the final report.

To build the image locally:

```bash
docker build -t chauhansakshi/final-project-covid .
```

You can also pull the pre-built image from Docker Hub:

```bash
docker pull chauhansakshi/final-project-covid
```

Docker Hub repository: https://hub.docker.com/r/chauhansakshi/final-project-covid

## Creating the report with Docker

After building the image locally or pulling it from Docker Hub, you can create the final report using the Makefile Docker targets.

For Mac/Linux:

```bash
make docker-report
```

For Windows using Git Bash:

```bash
make docker-report-windows
```

These commands run the Docker container and mount the local `report/` directory to the appropriate folder in the container so that the compiled report is saved back to your project directory as:

`report/final_report.html`

