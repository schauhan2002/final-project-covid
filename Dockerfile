FROM rocker/tidyverse:latest
FROM rocker/tidyverse:latest

WORKDIR /project

# Copy renv files first
COPY renv.lock ./
COPY renv/ ./renv/

# Install renv and restore packages from lockfile
RUN R -e "if (!requireNamespace('renv', quietly = TRUE)) install.packages('renv'); renv::restore()"

# Copy the rest of the project
COPY code/ ./code/
COPY data/ ./data/
COPY report/ ./report/
COPY Makefile ./Makefile

# Default command: run the Makefile pipeline to build the report
CMD ["make", "all"]