pRojects
================

<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/stephlocke/pRojects.svg?branch=master)](https://travis-ci.org/stephlocke/pRojects) [![Coverage Status](https://img.shields.io/coveralls/stephlocke/pRojects.svg)](https://coveralls.io/r/stephlocke/pRojects?branch=master)

This package is designed to take away some grunt work around setting up new projects.

All projects get setup with Git and Travis by default.

-   Use `createPackageProject` to setup a project with code coverage, vignettes, unit testing etc out of the box
-   Use `createAnalysisProject` to get a project ready for a typical analysis project. It includes packrat to help with reproducibility.
-   Use `createTrainingProject` to get a project ready for delivering training that often involves handouts and presentation materials. It includes packrat to help with reproducibility.
