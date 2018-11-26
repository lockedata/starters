Tests and Coverage
================
25 November, 2018 07:50:04

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr)
package.

| Object                                                    | Coverage (%) |
| :-------------------------------------------------------- | :----------: |
| pRojects                                                  |    66.00     |
| [R/project\_health.R](../R/project_health.R)              |     0.00     |
| [R/shinyGadget.R](../R/shinyGadget.R)                     |     0.00     |
| [R/external\_setup.R](../R/external_setup.R)              |    20.69     |
| [R/utils.R](../R/utils.R)                                 |    62.69     |
| [R/github.R](../R/github.R)                               |    81.82     |
| [R/createPackageProject.R](../R/createPackageProject.R)   |    85.37     |
| [R/repo\_status.R](../R/repo_status.R)                    |    94.12     |
| [R/createTrainingProject.R](../R/createTrainingProject.R) |    97.73     |
| [R/createAnalysisProject.R](../R/createAnalysisProject.R) |    100.00    |
| [R/createBasicProject.R](../R/createBasicProject.R)       |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                                    |  n |  time | error | failed | skipped | warning | icon |
| :---------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R) | 12 | 7.226 |     0 |      0 |       1 |       0 | 🔶    |
| [test-check\_github\_name.R](testthat/test-check_github_name.R)         |  3 | 0.136 |     0 |      0 |       0 |       0 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R)   | 12 | 5.290 |     0 |      0 |       0 |       0 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R)     | 16 | 0.482 |     0 |      0 |       0 |       0 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R)   | 35 | 0.759 |     0 |      0 |       0 |       3 | ⚠️   |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                                                            | context                  | test                                                                         | status  |  n |  time | icon |
| :------------------------------------------------------------------------------ | :----------------------- | :--------------------------------------------------------------------------- | :------ | -: | ----: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L12_L16) | createBasicProject       | createBasicProject() errors if name missing or not correct                   | PASS    |  2 | 0.037 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L37_L38) | createBasicProject       | createBasicProject() creates as expected                                     | PASS    |  7 | 6.120 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L51)     | createBasicProject       | createBasicProject() creates as expected when using checkpoint               | SKIPPED |  1 | 0.001 | 🔶    |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L71_L78) | createBasicProject       | createBasicProject() cleans if there was an error                            | PASS    |  1 | 0.011 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L96)     | createBasicProject       | createBasicProject() can create a GitHub repo                                | PASS    |  1 | 1.057 |      |
| [test-check\_github\_name.R](testthat/test-check_github_name.R#L4)              | test-check\_github\_name | check\_github\_name works                                                    | PASS    |  3 | 0.136 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L12_L16)   | createAnalysisProject    | createAnalysisProject() errors if name missing or not correct                | PASS    |  2 | 0.004 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L35_L36)   | createAnalysisProject    | createAnalysisProject() creates as expected when using defaults              | PASS    |  9 | 5.274 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L49_L59)   | createAnalysisProject    | createAnalysisProject() cleans if there was an error                         | PASS    |  1 | 0.012 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L22_L26)     | createPackageProject     | createPackageProject() errors if name missing or not correct                 | PASS    |  2 | 0.003 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L44_L45)     | createPackageProject     | createPackageProject() creates as expected when using defaults               | PASS    | 13 | 0.473 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L66_L73)     | createPackageProject     | createPackageProject() cleans if there was an error                          | PASS    |  1 | 0.006 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L11_L15)   | createTrainingProject    | createTrainingProject() errors if name missing or not correct                | PASS    |  2 | 0.003 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L29_L33)   | createTrainingProject    | createTrainingProject() creates as expected when using defaults              | WARNING | 10 | 0.238 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L50_L55)   | createTrainingProject    | createTrainingProject() creates as expected when using bookdown and revealjs | WARNING | 11 | 0.259 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L75_L80)   | createTrainingProject    | createTrainingProject() creates as expected when using tufte and xaringan    | WARNING | 11 | 0.252 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L99_L109)  | createTrainingProject    | createTrainingProject() cleans if there was an error                         | PASS    |  1 | 0.007 |      |

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
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://travis-ci.org/lockedata/pRojects/jobs/459334602" target="_blank"><span title="Built on Travis">![](https://github.com/yonicd/covrpage/blob/master/inst/logo/travis.png?raw=true)</span></a> |
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
