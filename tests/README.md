Tests and Coverage
================
22 November, 2018 20:26:21

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr)
package.

| Object                                                    | Coverage (%) |
| :-------------------------------------------------------- | :----------: |
| pRojects                                                  |    65.87     |
| [R/project\_health.R](../R/project_health.R)              |     0.00     |
| [R/shinyGadget.R](../R/shinyGadget.R)                     |     0.00     |
| [R/external\_setup.R](../R/external_setup.R)              |    20.69     |
| [R/utils.R](../R/utils.R)                                 |    62.69     |
| [R/github.R](../R/github.R)                               |    81.82     |
| [R/createPackageProject.R](../R/createPackageProject.R)   |    87.50     |
| [R/repo\_status.R](../R/repo_status.R)                    |    94.12     |
| [R/createTrainingProject.R](../R/createTrainingProject.R) |    97.67     |
| [R/createAnalysisProject.R](../R/createAnalysisProject.R) |    100.00    |
| [R/createBasicProject.R](../R/createBasicProject.R)       |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                                    |  n |  time | error | failed | skipped | warning | icon |
| :---------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R) | 10 | 8.017 |     0 |      0 |       1 |       0 | 🔶    |
| [test-check\_github\_name.R](testthat/test-check_github_name.R)         |  3 | 0.131 |     0 |      0 |       0 |       0 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R)   | 10 | 5.319 |     0 |      0 |       0 |       0 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R)     | 14 | 0.507 |     0 |      0 |       0 |       0 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R)   | 33 | 0.797 |     0 |      0 |       0 |       3 | ⚠️   |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                                                            | context                  | test                                                                         | status  |  n |  time | icon |
| :------------------------------------------------------------------------------ | :----------------------- | :--------------------------------------------------------------------------- | :------ | -: | ----: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L19_L20) | createBasicProject       | createBasicProject() creates as expected                                     | PASS    |  7 | 6.916 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L33)     | createBasicProject       | createBasicProject() creates as expected when using checkpoint               | SKIPPED |  1 | 0.001 | 🔶    |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L53_L60) | createBasicProject       | createBasicProject() cleans if there was an error                            | PASS    |  1 | 0.013 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L78)     | createBasicProject       | createBasicProject() can create a GitHub repo                                | PASS    |  1 | 1.087 |      |
| [test-check\_github\_name.R](testthat/test-check_github_name.R#L4)              | test-check\_github\_name | check\_github\_name works                                                    | PASS    |  3 | 0.131 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L17_L18)   | createAnalysisProject    | createAnalysisProject() creates as expected when using defaults              | PASS    |  9 | 5.303 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L31_L41)   | createAnalysisProject    | createAnalysisProject() cleans if there was an error                         | PASS    |  1 | 0.016 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L26_L27)     | createPackageProject     | createPackageProject() creates as expected when using defaults               | PASS    | 13 | 0.500 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L48_L55)     | createPackageProject     | createPackageProject() cleans if there was an error                          | PASS    |  1 | 0.007 |      |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L11_L15)   | createTrainingProject    | createTrainingProject() creates as expected when using defaults              | WARNING | 10 | 0.239 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L32_L37)   | createTrainingProject    | createTrainingProject() creates as expected when using bookdown and revealjs | WARNING | 11 | 0.297 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L57_L62)   | createTrainingProject    | createTrainingProject() creates as expected when using tufte and xaringan    | WARNING | 11 | 0.254 | ⚠️   |
| [test-createTrainingProject.R](testthat/test-createTrainingProject.R#L81_L91)   | createTrainingProject    | createTrainingProject() cleans if there was an error                         | PASS    |  1 | 0.007 |      |

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
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://travis-ci.org/lockedata/pRojects/jobs/458560685" target="_blank"><span title="Built on Travis">![](https://github.com/yonicd/covrpage/blob/master/inst/logo/travis.png?raw=true)</span></a> |
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
