all: report/final_report.html

report/final_report.html: report/final_report.Rmd output/summary_table.rds output/cases_deaths_scatter.png
	Rscript -e "rmarkdown::render('report/final_report.Rmd')"

output/covid_analysis.rds output/cols_used.rds: code/01_clean.R data/covid.csv
	Rscript code/01_clean.R

output/summary_table.rds: code/02_table.R output/covid_analysis.rds
	Rscript code/02_table.R

output/cases_deaths_scatter.png: code/03_figure.R output/covid_analysis.rds output/cols_used.rds
	Rscript code/03_figure.R

.PHONY: clean
clean:
	rm -f output/*.rds output/*.png report/*.html

install:
	Rscript -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"

docker-report:
	mkdir -p report
	docker run --rm -v "$$(pwd)/report:/project/report" chauhansakshi/final-project-covid

docker-report-windows:
	mkdir -p report
	docker run --rm -v "/$$(pwd)/report:/project/report" chauhansakshi/final-project-covid