ARG BASE_IMAGE=rocker/rstudio
ARG R_VER=4.2.3
FROM ${BASE_IMAGE}:${R_VER}
# renews the R_VER and BASE_IMAGE args
ARG BASE_IMAGE
ARG R_VER

ARG IMAGE_NAME=wrokshop
LABEL Name=${IMAGE_NAME} Version=${R_VER}

ENV RENV_CONFIG_REPOS_OVERRIDE https://packagemanager.rstudio.com/cran/latest

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  libcurl4-openssl-dev \
  libicu-dev \
  libsodium-dev \
  libssl-dev \
  make \
  zlib1g-dev

# this uses a predescribed set of packages to be baked into this image
# this will install all the packages from the project into the root of the docker image
# so any R session (that doesn't use renv) will have all the packages
COPY renv.lock renv.lock
RUN Rscript -e "install.packages('renv')"
RUN Rscript -e "renv::restore()"

# Use some nice config settings
COPY ./prep/rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json
