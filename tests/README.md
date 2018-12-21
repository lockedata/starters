Tests and Coverage
================
21 December, 2018 17:32:07

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

    ## ⚠️ Not All Tests Passed
    ##   Coverage statistics are approximations of the non-failing tests.
    ##   Use with caution
    ## 
    ##  For further investigation check in testthat summary tables.

| Object                                                    | Coverage (%) |
| :-------------------------------------------------------- | :----------: |
| pRojects                                                  |    67.08     |
| [R/project\_health.R](../R/project_health.R)              |     0.00     |
| [R/shinyGadget.R](../R/shinyGadget.R)                     |     0.00     |
| [R/external\_setup.R](../R/external_setup.R)              |    30.00     |
| [R/utils.R](../R/utils.R)                                 |    52.73     |
| [R/github.R](../R/github.R)                               |    81.82     |
| [R/createPackageProject.R](../R/createPackageProject.R)   |    85.39     |
| [R/repo\_status.R](../R/repo_status.R)                    |    93.48     |
| [R/createAnalysisProject.R](../R/createAnalysisProject.R) |    96.43     |
| [R/createTrainingProject.R](../R/createTrainingProject.R) |    96.43     |
| [R/createBasicProject.R](../R/createBasicProject.R)       |    98.15     |
| [R/styler\_precommit.R](../R/styler_precommit.R)          |    100.00    |
| [R/use\_readme.R](../R/use_readme.R)                      |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                                    |  n |  time | error | failed | skipped | warning | icon |
| :---------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R) | 12 | 7.577 |     0 |      0 |       1 |       0 | 🔶    |
| [test-check\_github\_name.R](testthat/test-check_github_name.R)         |  3 | 0.211 |     0 |      0 |       0 |       0 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R)   | 15 | 4.899 |     0 |      9 |       0 |       3 | 🛑⚠️  |
| [test-createPackageProject.R](testthat/test-createPackageProject.R)     | 16 | 0.417 |     0 |     13 |       0 |       0 | 🛑    |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                                                            | context                  | test                                                            | status  |  n |  time | icon |
| :------------------------------------------------------------------------------ | :----------------------- | :-------------------------------------------------------------- | :------ | -: | ----: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L12_L17) | createBasicProject       | createBasicProject() errors if name missing or not correct      | PASS    |  2 | 0.065 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L37_L40) | createBasicProject       | createBasicProject() creates as expected                        | PASS    |  7 | 6.003 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L53)     | createBasicProject       | createBasicProject() creates as expected when using checkpoint  | SKIPPED |  1 | 0.001 | 🔶    |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L75_L82) | createBasicProject       | createBasicProject() cleans if there was an error               | PASS    |  1 | 0.015 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L100)    | createBasicProject       | createBasicProject() can create a GitHub repo                   | PASS    |  1 | 1.493 |      |
| [test-check\_github\_name.R](testthat/test-check_github_name.R#L4)              | test-check\_github\_name | check\_github\_name works                                       | PASS    |  3 | 0.211 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L12_L17)   | createAnalysisProject    | createAnalysisProject() errors if name missing or not correct   | PASS    |  2 | 0.004 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L30_L33)   | createAnalysisProject    | createAnalysisProject() creates as expected when using defaults | WARNING | 12 | 4.888 | ⚠️   |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L51_L61)   | createAnalysisProject    | createAnalysisProject() cleans if there was an error            | PASS    |  1 | 0.007 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L22_L27)     | createPackageProject     | createPackageProject() errors if name missing or not correct    | PASS    |  2 | 0.003 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L44_L47)     | createPackageProject     | createPackageProject() creates as expected when using defaults  | FAILED  | 13 | 0.407 | 🛑    |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L68_L75)     | createPackageProject     | createPackageProject() cleans if there was an error             | PASS    |  1 | 0.007 |      |

| Failed | Warning | Skipped |
| :----- | :------ | :------ |
| 🛑      | ⚠️      | 🔶       |

</details>

<details>

<summary> Session Info
</summary>

| Field    | Value                         |                                                                                                                                                                                                              |
| :------- | :---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Version  | R version 3.5.1 (2018-12-12)  |                                                                                                                                                                                                              |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://travis-ci.org/lockedata/pRojects/jobs/471085282" target="_blank"><span title="Built on Travis">![](https://github.com/yonicd/covrpage/blob/master/inst/logo/travis.png?raw=true)</span></a> |
| Running  | Ubuntu 14.04.5 LTS            |                                                                                                                                                                                                              |
| Language | en\_US                        |                                                                                                                                                                                                              |
| Timezone | UTC                           |                                                                                                                                                                                                              |

| Package  | Version |
| :------- | :------ |
| testthat | 2.0.1   |
| covr     | 3.2.1   |
| covrpage | 0.0.68  |

</details>

<!--- Final Status : error/failed --->
