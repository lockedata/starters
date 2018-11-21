Tests and Coverage
================
21 November, 2018 13:42:52

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr)
package.

| Object                                                    | Coverage (%) |
| :-------------------------------------------------------- | :----------: |
| pRojects                                                  |    66.74     |
| [R/project\_health.R](../R/project_health.R)              |     0.00     |
| [R/shinyGadget.R](../R/shinyGadget.R)                     |     0.00     |
| [R/external\_setup.R](../R/external_setup.R)              |    19.05     |
| [R/utils.R](../R/utils.R)                                 |    61.40     |
| [R/github.R](../R/github.R)                               |    81.82     |
| [R/createPackageProject.R](../R/createPackageProject.R)   |    86.76     |
| [R/repo\_status.R](../R/repo_status.R)                    |    94.74     |
| [R/createTrainingProject.R](../R/createTrainingProject.R) |    97.18     |
| [R/createAnalysisProject.R](../R/createAnalysisProject.R) |    100.00    |
| [R/createBasicProject.R](../R/createBasicProject.R)       |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                                    |  n |  time | error | failed | skipped | warning | icon |
| :---------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R) | 10 | 7.427 |     0 |      0 |       1 |       0 | 🔶    |
| [test-check\_github\_name.R](testthat/test-check_github_name.R)         |  3 | 0.466 |     0 |      0 |       0 |       0 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R)   |  9 | 5.563 |     0 |      0 |       0 |       0 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R)     | 14 | 0.492 |     0 |      0 |       0 |       0 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R)   | 33 | 0.773 |     0 |      0 |       0 |       3 | ⚠️   |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                                                            | context                  | test                                                                         | status  |  n |  time | icon |
| :------------------------------------------------------------------------------ | :----------------------- | :--------------------------------------------------------------------------- | :------ | -: | ----: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L16)     | createBasicProject       | createBasicProject() creates as expected                                     | PASS    |  7 | 6.060 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L30)     | createBasicProject       | createBasicProject() creates as expected when using checkpoint               | SKIPPED |  1 | 0.001 | 🔶    |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L48_L52) | createBasicProject       | createBasicProject() cleans if there was an error                            | PASS    |  1 | 0.012 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L70)     | createBasicProject       | createBasicProject() can create a GitHub repo                                | PASS    |  1 | 1.354 |      |
| [test-check\_github\_name.R](testthat/test-check_github_name.R#L4)              | test-check\_github\_name | check\_github\_name works                                                    | PASS    |  3 | 0.466 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L15)       | createAnalysisProject    | createAnalysisProject() creates as expected when using defaults              | PASS    |  8 | 5.549 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L28_L33)   | createAnalysisProject    | createAnalysisProject() cleans if there was an error                         | PASS    |  1 | 0.014 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L21)         | createPackageProject     | createPackageProject() creates as expected when using defaults               | PASS    | 13 | 0.486 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L43_L47)     | createPackageProject     | createPackageProject() cleans if there was an error                          | PASS    |  1 | 0.006 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L10_L12)   | createTrainingProject    | createTrainingProject() creates as expected when using defaults              | WARNING | 10 | 0.240 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L30_L33)   | createTrainingProject    | createTrainingProject() creates as expected when using bookdown and revealjs | WARNING | 11 | 0.263 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L51_L54)   | createTrainingProject    | createTrainingProject() creates as expected when using tufte and xaringan    | WARNING | 11 | 0.263 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L71_L77)   | createTrainingProject    | createTrainingProject() cleans if there was an error                         | PASS    |  1 | 0.007 |      |

| Failed | Warning | Skipped |
| :----- | :------ | :------ |
| 🛑      | ⚠️      | 🔶       |

</details>

<details>

<summary> Session Info
</summary>

| Field    | Value                         |                                                                                                                                                                                                              |
| :------- | :---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Version  | R version 3.5.1 (2017-01-27)  |                                                                                                                                                                                                              |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://travis-ci.org/lockedata/pRojects/jobs/457944194" target="_blank"><span title="Built on Travis">![](https://github.com/yonicd/covrpage/blob/master/inst/logo/travis.png?raw=true)</span></a> |
| Running  | Ubuntu 14.04.5 LTS            |                                                                                                                                                                                                              |
| Language | en\_US                        |                                                                                                                                                                                                              |
| Timezone | UTC                           |                                                                                                                                                                                                              |

| Package  | Version |
| :------- | :------ |
| testthat | 2.0.1   |
| covr     | 3.2.1   |
| covrpage | 0.0.66  |

</details>

<!--- Final Status : skipped/warning --->
