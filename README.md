# flowjupy

## Introduction

This [Docker](http://www.docker.com/) container provides a [`Jupyter`](http://jupyter.org/) Notebook interface to the functionality from the [R](http://r-project.org/)/[Bioconductor](http://bioconductor.org) package [`flowcatchR`](http://bioconductor.org/packages/flowcatchR). It is based on the [`jupyter/demo`](https://github.com/jupyter/docker-demo-images) Docker image.

## Installation

This app needs a recent version of Docker:

 * [Docker installation instructions](https://docs.docker.com/installation/#installation)
 * type `docker pull federicomarini/flowjupy` 
 * ... or alternatively clone this repository (`git clone https://github.com/federicomarini/flowjupy.git`) and build the image locally with `cd flowjupy && docker build -t flowjupy .` 

## Usage

 * `docker run -p 8888:8888 federicomarini/flowjupy`
 * If all goes well
    - On Linux, browse to [http://localhost:8888](http://localhost:8888) for the [Jupyter](http://jupyter.org/) notebook interface available in the home folder to find example notebooks illustrating the usage of the [`flowcatchR`](http://bioconductor.org/packages/flowcatchR) package
    - On MacOS or Windows running [`Docker Toolbox`](https://www.docker.com/toolbox) find the Docker host URL with `docker-machine ip default|[name of the virtual machine]` and browse to `http://[thatIPaddress]:8888`

## Other components of the `dockerflow` workflow solution

* [`flowstudio`](https://github.com/federicomarini/flowstudio) - https://github.com/federicomarini/flowstudio
* [`flowshiny`](https://github.com/federicomarini/flowshiny) - https://github.com/federicomarini/flowshiny
* [`dockerflow`](https://github.com/federicomarini/dockerflow) - https://github.com/federicomarini/dockerflow

## Contact
For additional details regarding the functions of [`flowcatchR`](http://bioconductor.org/packages/flowcatchR), please consult the package documentation, the package vignette or write an email to marinif@uni-mainz.de. 

## Bug reports/Issues/New features

Please use https://github.com/federicomarini/flowcatchR/issues for reporting bugs, issues or for suggesting new features to be implemented.

