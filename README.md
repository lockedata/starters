
# pRojects <img src="man/figures/logo.png" align="right" height=140/>

<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/lockedata/pRojects.svg?branch=master)](https://travis-ci.org/lockedata/pRojects)
[![Coverage
Status](https://img.shields.io/coveralls/lockedata/pRojects.svg)](https://coveralls.io/r/lockedata/pRojects?branch=master)

This package is designed to take away some grunt work around setting up
new projects.

All projects get setup with Git and Travis by default.

  - Use `createPackageProject` to setup a project with code coverage,
    vignettes, unit testing etc out of the box
  - Use `createAnalysisProject` to get a project ready for a typical
    analysis project. It includes packrat to help with reproducibility.
  - Use `createTrainingProject` to get a project ready for delivering
    training that often involves handouts and presentation materials. It
    includes packrat to help with reproducibility.

## Install `pRojects`

    remotes::install_github("lockedata/pRojects")

## RStudio gadget

If you want to set up a pRoject without using the R functions,
[@jonmcalder](https://github.com/jonmcalder) made a nifty [RStudio
addin](https://rstudio.github.io/rstudioaddins/) for making pRojects.
Install the package to get it added to your RStudio instance.

## Contributing

### General info

Wanna report a bug or suggest a feature? Great stuff\! For more
information on how to contribute check out [our contributing
guide](.github/CONTRIBUTING.md).

Please note that this R package is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this package project
you agree to abide by its terms.

### Up for grabs

Make sure to check out the [Issues tab in
GitHub](https://github.com/stephlocke/pRojects/issues)\! We’re making
this project a great place to start contributing to R packages. We will
help you through the process.
