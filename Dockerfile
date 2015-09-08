FROM jupyter/demo

MAINTAINER "Federico Marini" marinif@uni-mainz.de

#FROM bioconductor/release_base

USER root

# unix dependencies
RUN apt-get update && apt-get install libglu1-mesa-dev libjpeg-dev libtiff5-dev libX11-dev libcairo2-dev libreadline-dev libfftw3-dev valgrind wget -y

RUN ldconfig -v

RUN apt-get install -y r-base r-cran-rgl

# ** R                                                                                                                                                         
# ** inst                                                                                                                                                      
# ** preparing package for lazy loading                                                                                                                        
# ** help                                                                                                                                                      
# *** installing help indices                                                                                                                                  
# ** building package indices                                                                                                                                  
# ** testing if installed package can be loaded                                                                                                                
# Error in dyn.load(file, DLLpath = DLLpath, ...) : 
#   unable to load shared object '/usr/local/lib/R/site-library/png/libs/png.so':
#   libpng16.so.16: cannot open shared object file: No such file or directory
# Error: loading failed
# Execution halted
# ERROR: loading failed
# * removing '/usr/local/lib/R/site-library/png'                                                                                                               
# * installing *source* package 'locfit' ...                        

## all the dependencies:
ADD deps.R /tmp/
RUN echo "fede-dep"
RUN /usr/bin/R -f /tmp/deps.R 

RUN apt-get update && apt-get install libpng* -y
RUN apt-get update && apt-get install sudo -y
RUN ldconfig -v
# ADD justPng.R /tmp/
# RUN su && /usr/bin/R -f /tmp/justPng.R 
RUN sudo /usr/bin/R -e "install.packages('png',repos='http://cran.us.r-project.org')"


ADD intoTheFlow.R /tmp/
RUN echo "fede-pkg"
RUN /usr/bin/R -f /tmp/intoTheFlow.R 


## what is missing is now "only" to tell which version of R to use/link - hopefully the other pkgs will not make a mess?

ADD template_flowcatchR_vignetteSummary.ipynb $HOME/
ADD template_DetectionOfTransmigrationEvents.ipynb $HOME/



ADD irk.R /tmp/
RUN /usr/bin/R -f /tmp/irk.R

RUN /usr/bin/R -e "IRkernel::installspec()"

RUN rm /opt/conda/bin/R*

## UNTIL HERE IT WORKS!!!

## trying to update to the latest R?

RUN rm -rf /tmp/R-source && mkdir /tmp/R-source
ADD http://cran.fhcrc.org/src/base/R-latest.tar.gz /tmp/R-source/
RUN cd /tmp/R-source && \
  tar -zxf /tmp/R-source/*.tar.gz && \
  rm *.tar.gz && \
  cd R-* && \
  ./configure --enable-R-shlib --with-x=no && \
  make && \
  make install

RUN R -e "remove.packages('BiocInstaller')"# /tmp/intoTheFlow.R 
RUN sudo R -e "install.packages('rgl',repos='http://cran.us.r-project.org')"
  
ADD intoTheFlow.R /tmp/
RUN echo "fede-pkg"
RUN R -e "source('http://bioconductor.org/biocLite.R');biocLite('EBImage')"
RUN R -f /tmp/intoTheFlow.R 
  
# put the libraries again
# # # # RUN sudo /usr/bin/R -e "install.packages('png',repos='http://cran.us.r-project.org')"
# # # # ADD deps.R /tmp/
# # # # RUN echo "fede-dep"
# # # # RUN /usr/bin/R -f /tmp/deps.R 
# # # # 
# # # # 
# # # # ADD intoTheFlow.R /tmp/
# # # # RUN echo "fede-pkg"
# # # # RUN /usr/bin/R -f /tmp/intoTheFlow.R 
# # # # 
# # # # ADD irk.R /tmp/
# # # # RUN /usr/bin/R -f /tmp/irk.R
# # # # 
# # # # RUN /usr/bin/R -e "IRkernel::installspec()"


# ENV PATH="/opt/conda/envs/python2/bin:/home/jovyan/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:/opt/happy/1.19.4/bin:/opt/alex/3.1.3/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# RUN add-apt-repository ppa:nicola-onorata/toolchain
# RUN apt-get update && apt-get install gcc -y

# RUN mkdir /home/jovyan/.R/
# RUN echo 'R_LIBS_USER=/home/jovyan/.R:/usr/lib/R/site-library' > /home/jovyan/.Renviron
# RUN echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' > /home/jovyan/.Rprofile
# RUN echo "PKG_CXXFLAGS = '-std=c++11'" > /home/jovyan/.R/Makevars
# RUN echo "install.packages(c('jpeg'))" | R --no-save
# 

# RUN apt-get purge -y gcc-4.9
# RUN apt-get install gcc-4.8-base:amd64 -y


# In [1]:
# 
# sessionInfo()
# 
# Out[1]:
# 
# R version 3.2.1 (2015-06-18)
# Platform: x86_64-unknown-linux-gnu (64-bit)
# Running under: Debian GNU/Linux 8 (jessie)
# 
# locale:
# [1] C
# 
# attached base packages:
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# loaded via a namespace (and not attached):
#  [1] magrittr_1.5    IRdisplay_0.3   tools_3.2.1     base64enc_0.1-3
#  [5] uuid_0.1-2      stringi_0.5-5   rzmq_0.7.7      IRkernel_0.4   
#  [9] jsonlite_0.9.16 stringr_1.0.0   digest_0.6.8    repr_0.3       
# [13] evaluate_0.7   














# here should go the other dependencies
# r

# bioconductor

# install the package via github if this does not work via bioclite? temporary solution while waiting for R to be updated to R-3.1.2

# # # # 
# # # # 
# # # # 
# # # # # DO NOT EDIT FILES CALLED 'Dockerfile'; they are automatically
# # # # # generated. Edit 'Dockerfile.in' and generate the 'Dockerfile'
# # # # # with the 'rake' command.
# # # # # The suggested name for this image is: bioconductor/release_base.
# # # # #FROM ubuntu:14.04
# # # # RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && \
# # # # DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y 
# # # # #DEBIAN_FRONTEND=noninteractive \
# # # # #apt-get build-dep -y r-base && \
# # # # # DEBIAN_FRONTEND=noninteractive \
# # # # RUN apt-get install biber curl dh-autoreconf dvipng gdb gdebi-core libarchive-zip-perl libcurl4-openssl-dev libdbd-mysql-perl libdbi-perl libhdf5-dev libmpich2-dev libnetcdf-dev libopenmpi-dev libopenmpi1.6 libqt4-opengl-dev libssl1.0.0 libxml2-dev -y
# # # # 
# # # # RUN apt-get install mpich2 openmpi-bin openmpi-checkpoint openmpi-common pgf psmisc python-pip supervisor texlive-science unzip -y
# # # # 
# # # # 
# # # # RUN pip install -U awscli
# # # # 
# # # # # RUN apt-get install libtiff5-dev -y
# # # # 
# # # # # RUN apt-get install valgrind wget -y
# # # # 
# # # # 
# # # # # we need a pandoc that's newer than what apt-get provides
# # # # RUN cd /tmp && wget https://github.com/jgm/pandoc/releases/download/1.13.2/pandoc-1.13.2-1-amd64.deb && \
# # # # dpkg -i pandoc-1.13.2-1-amd64.deb && rm pandoc-1.13.2-1-amd64.deb
# # # # 
# # # # #RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
# # # # #&& locale-gen en_US.utf8 \
# # # # #&& /usr/sbin/update-locale LANG=en_US.UTF-8
# # # # #ENV LC_ALL en_US.UTF-8
# # # # 
# # # # # RUN apt-get install libreadline-dev libfftw3-dev -y
# # # # 
# # # # 
# # # # #RUN rm -rf /tmp/R-source && mkdir /tmp/R-source
# # # # #ADD http://cran.fhcrc.org/src/base/R-latest.tar.gz /tmp/R-source/
# # # # #RUN cd /tmp/R-source && \
# # # # #tar -zxf /tmp/R-source/*.tar.gz && \
# # # # #rm *.tar.gz && \
# # # # #cd R-* && \
# # # # #./configure --enable-R-shlib --with-x=no && \
# # # # #make && \
# # # # #make install
# # # # 
# # # # RUN conda config --add channels r
# # # # RUN conda install --yes r-jpeg
# # # # RUN conda install --yes r-png
# # # # 
# # # # #RUN echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' > /home/jovyan/.Rprofile
# # # # #RUN echo "install.packages(c('jpeg'))" | /usr/bin/R --no-save
# # # # 
# # # # 
# # # # #### MAYBE CONSIDER RE-PUTTING X11?
# # # # 
# # # # #RUN R -e "install.packages('BiocInstaller', repos='http://bioconductor.org/packages/3.0/bioc')"
# # # # 
# # # # 
# # # # 
# # # # ADD install.R /tmp/
# # # # RUN R -f /tmp/install.R 
# # # # #echo "library(BiocInstaller)" > $HOME/.Rprofile
# # # # # rstudio
# # # # #RUN VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \
# # # # #wget -q http://download2.rstudio.org/rstudio-server-${VER}-amd64.deb && \
# # # # #dpkg -i rstudio-server-${VER}-amd64.deb && \
# # # # #rm rstudio-server-*-amd64.deb
# # # # #ADD userconf.sh /usr/bin/
# # # # 
# # # # # RUN apt-get install libx11-dev -y
# # # # 
# # # # #RUN R -e "install.packages('BiocInstaller', repos='http://bioconductor.org/packages/3.0/bioc')"
# # # # #RUN R -e "source("http://bioconductor.org/biocLite.R")"
# # # # 
# # # # # RUN apt-get install libglu1-mesa-dev libjpeg-dev libtiff5-dev libX11-dev libcairo2-dev -y
# # # # 
# # # # 
# # # # RUN ldconfig ## make sure the shared library is linked
# # # # 
# # # # 
# # # # 
# # # # 
# # # # 
# # # # RUN mkdir /home/jovyan/.R/
# # # # RUN echo 'R_LIBS_USER=/home/jovyan/.R:/usr/lib/R/site-library' > /home/jovyan/.Renviron
# # # # RUN echo 'options(repos=structure(c(CRAN="http://cran.rstudio.com")))' > /home/jovyan/.Rprofile
# # # # # RUN echo "PKG_CXXFLAGS = '-std=c++11'" > /home/jovyan/.R/Makevars
# # # # 
# # # # #RUN echo "install.packages(c('jpeg'))" | R --no-save
# # # # 
# # # # 
# # # # RUN conda install --yes -c https://conda.anaconda.org/cgat r-locfit
# # # # RUN conda install --yes r-rgl
# # # # #RUN conda install --yes -c https://github.com/asmeurer/cran-conda-recipes r-ebimage
# # # # 
# # # # ## until here, ok. somehow i cannot use the normal packages but rather stick to the ones provided via conda.
# # # # # wtf
# # # # 
# # # # RUN apt-get install -y r-base r-cran-rgl
# # # # 
# # # # RUN echo "sessionInfo()" | /usr/bin/R --no-save
# # # # 
# # # # #RUN alias R="/usr/bin/R"
# # # # 
# # # # #RUN echo "sessionInfo()" | R --no-save
# # # # 
# # # # ADD intoTheFlow.R /tmp/
# # # # RUN /usr/bin/R -f /tmp/intoTheFlow.R 
# # # # 
# # # # #ADD template_flowcatchR_vignetteSummary.ipynb $HOME/
# # # # #ADD template_DetectionOfTransmigrationEvents.ipynb $HOME/
# # # # 
# # # # 
# # # # 
# # # # 
# # # # #RUN mkdir -p /var/log/supervisor
# # # # #COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# # # # #EXPOSE 8787
# # # # #CMD ["/usr/bin/supervisord"] 
# # # # 










