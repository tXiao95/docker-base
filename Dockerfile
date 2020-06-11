FROM rocker/verse:latest

RUN R -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"

# install 'ihmeuw-demographics' R packages from github
RUN R -e "remotes::install_github('ihmeuw-demographics/demUtils', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/hierarchyUtils', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/demCore', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/demViz', dependencies = TRUE)"

