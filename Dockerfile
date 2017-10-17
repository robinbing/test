FROM cardcorp/r-pandoc

MAINTAINER "Robin Luo" robin.luo@blackwoodseven.com 

# Install External dependencies 
RUN apt-get update \
   && apt-get install -y \
      libcurl4-openssl-dev \
      libssl-dev \
      libsqlite3-dev \
      libxml2-dev \
      libmysqlclient-dev\
      qpdf \
      vim \
      git\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ 

RUN install2.r --error \
    devtools \
    testthat \
    RMySQL \
   && rm -rf /tmp/downloaded_packages/ /tmp/*.rds


# Install R packages
RUN R -e "devtools::install_github('twonil/fs/FeatureSelection-master', auth_token = Sys.getenv('AUTH_TOKEN'))"
RUN R -e "devtools::install_github('robinbing/toy', dependencies = TRUE)"

# Set work dir
WORKDIR /toy
ADD . /toy

# Run
CMD ["Rscript", "tryprint.R"]
