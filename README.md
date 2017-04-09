pRojects
================

<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/stephlocke/pRojects.svg?branch=master)](https://travis-ci.org/stephlocke/pRojects) [![Coverage Status](https://img.shields.io/coveralls/stephlocke/pRojects.svg)](https://coveralls.io/r/stephlocke/pRojects?branch=master)

This package is designed to take away some grunt work around setting up new projects.

All projects get setup with Git and Travis by default.

-   Use `createPackageProject` to setup a project with code coverage, vignettes, unit testing etc out of the box
-   Use `createAnalysisProject` to get a project ready for a typical analysis project. It includes packrat to help with reproducibility.
-   Use `createTrainingProject` to get a project ready for delivering training that often involves handouts and presentation materials. It includes packrat to help with reproducibility.

Install `pRojects`
------------------

    devtools::install_github("stephlocke/pRojects")

RStudio gadget
--------------

If you want to set up a pRoject without using the R functions, [@jonmcalder](https://github.com/jonmcalder) made a nifty [RStudio addin](https://rstudio.github.io/rstudioaddins/) for making pRojects. Install the package to get it added to your RStudio instance.

Up for grabs
------------

Make sure to check out the [Issues tab in GitHub](https://github.com/stephlocke/pRojects/issues)! We're making this project a great place to start contributing to R packages. We will help you through the process, especially if you pick up one of the [first-timers-only issues](https://github.com/stephlocke/pRojects/issues?q=is%3Aissue+is%3Aopen+label%3Afirst-timers-only). All work done on `pRojects` is subject to our [Code of Conduct](./CONDUCT.md).
