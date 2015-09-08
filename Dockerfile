FROM jupyter/demo

MAINTAINER "Federico Marini" marinif@uni-mainz.de

USER root

# additional unix dependencies
RUN apt-get update && apt-get install -y \
    libglu1-mesa-dev \
    libjpeg-dev \
    libtiff5-dev \
    libX11-dev \
    libcairo2-dev \
    libreadline-dev \
    libfftw3-dev \
    valgrind \
    wget \
    libpng* \
    sudo 

# should be used to aid linking the shared libraries
RUN ldconfig -v

# install newest version of R
RUN rm -rf /tmp/R-source && mkdir /tmp/R-source
ADD http://cran.fhcrc.org/src/base/R-latest.tar.gz /tmp/R-source/
RUN cd /tmp/R-source && \
  tar -zxf /tmp/R-source/*.tar.gz && \
  rm *.tar.gz && \
  cd R-* && \
  ./configure --enable-R-shlib --with-x=no && \
  make && \
  make install

# correspondingly, make the R* executables from conda disappear - they gave compiler issues
RUN rm /opt/conda/bin/R*

# two R dependencies need to be installed as sudo to avoid shared object/library issues
RUN sudo R -e "install.packages('png',repos='http://cran.us.r-project.org')"
RUN sudo R -e "install.packages('rgl',repos='http://cran.us.r-project.org')"

# install correspondent version of biocLite and flowcatchR with dependencies
ADD intoTheFlow_jupy.R /tmp/
RUN R -f /tmp/intoTheFlow_jupy.R 

# add two sample Jupyter Notebooks for the user to try - in a vignette way
ADD template_flowcatchR_vignetteSummary.ipynb $HOME/
ADD template_DetectionOfTransmigrationEvents.ipynb $HOME/

# (re)install the IRkernel and its dependencies
ADD install_irkernel.R /tmp/
RUN R -f /tmp/install_irkernel.R
RUN R -e "IRkernel::installspec()"
