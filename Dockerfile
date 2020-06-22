FROM rocker/verse:latest


# install helper packages
RUN R -e "install.packages('remotes', repos = 'http://cran.us.r-project.org')"
RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"

# install tmb related packages
RUN install2.r --error --deps TRUE \
    TMB \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
RUN R -e "remotes::install_github('mlysy/TMBtools', dependencies = TRUE)"

# install rstan related packages
# based off of Dockerfile from https://hub.docker.com/r/jrnold/rstan/dockerfile
RUN install2.r --error --deps TRUE \
    rstan \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

# Global site-wide config -- neeeded for building packages
RUN mkdir -p $HOME/.R/ \
    && echo "CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function -flto -ffat-lto-objects  -Wno-unused-local-typedefs \n" >> $HOME/.R/Makevars

# Config for rstudio user
RUN mkdir -p $HOME/.R/ \
    && echo "CXXFLAGS=-O3 -mtune=native -march=native -Wno-unused-variable -Wno-unused-function -flto -ffat-lto-objects  -Wno-unused-local-typedefs -Wno-ignored-attributes -Wno-deprecated-declarations\n" >> $HOME/.R/Makevars \
    && echo "rstan::rstan_options(auto_write = TRUE)\n" >> /home/rstudio/.Rprofile \
    && echo "options(mc.cores = parallel::detectCores())\n" >> /home/rstudio/.Rprofile

# Install rstan
RUN install2.r --error --deps TRUE \
    rstan \
	loo \
        spdep \
	bayesplot \
    rstanarm \
    rstantools \
    shinystan \
    ggmcmc \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


# install 'ihmeuw-demographics' R packages from github
RUN R -e "remotes::install_github('ihmeuw-demographics/demUtils', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/hierarchyUtils', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/demCore', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/demViz', dependencies = TRUE)"
RUN R -e "remotes::install_github('ihmeuw-demographics/popMethods', dependencies = TRUE)"

