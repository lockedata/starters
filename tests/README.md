Tests and Coverage
================
08 January, 2019 14:50:50

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

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
| starters                                                  |    67.57     |
| [R/project\_health.R](../R/project_health.R)              |     0.00     |
| [R/shinyGadget.R](../R/shinyGadget.R)                     |     0.00     |
| [R/external\_setup.R](../R/external_setup.R)              |    30.00     |
| [R/utils.R](../R/utils.R)                                 |    51.92     |
| [R/github.R](../R/github.R)                               |    81.82     |
| [R/createPackageProject.R](../R/createPackageProject.R)   |    85.39     |
| [R/repo\_status.R](../R/repo_status.R)                    |    93.48     |
| [R/createTrainingProject.R](../R/createTrainingProject.R) |    97.62     |
| [R/createAnalysisProject.R](../R/createAnalysisProject.R) |    100.00    |
| [R/createBasicProject.R](../R/createBasicProject.R)       |    100.00    |
| [R/styler\_precommit.R](../R/styler_precommit.R)          |    100.00    |
| [R/use\_readme.R](../R/use_readme.R)                      |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                                    |  n |  time | error | failed | skipped | warning | icon |
| :---------------------------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R) | 13 | 8.995 |     0 |      0 |       1 |       0 | 🔶    |
| [test-check\_github\_name.R](testthat/test-check_github_name.R)         |  3 | 0.296 |     0 |      0 |       0 |       0 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R)   | 16 | 4.747 |     0 |      9 |       0 |       3 | 🛑⚠️  |
| [test-createPackageProject.R](testthat/test-createPackageProject.R)     | 17 | 0.427 |     0 |     13 |       0 |       0 | 🛑    |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                                                            | context                  | test                                                            | status  |  n |  time | icon |
| :------------------------------------------------------------------------------ | :----------------------- | :-------------------------------------------------------------- | :------ | -: | ----: | :--- |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L12_L17) | createBasicProject       | createBasicProject() errors if name missing or not correct      | PASS    |  3 | 0.023 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L45_L48) | createBasicProject       | createBasicProject() creates as expected                        | PASS    |  7 | 7.378 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L61)     | createBasicProject       | createBasicProject() creates as expected when using checkpoint  | SKIPPED |  1 | 0.002 | 🔶    |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L83_L90) | createBasicProject       | createBasicProject() cleans if there was an error               | PASS    |  1 | 0.011 |      |
| [test-AAA-createBasicProject.R](testthat/test-AAA-createBasicProject.R#L108)    | createBasicProject       | createBasicProject() can create a GitHub repo                   | PASS    |  1 | 1.581 |      |
| [test-check\_github\_name.R](testthat/test-check_github_name.R#L4)              | test-check\_github\_name | check\_github\_name works                                       | PASS    |  3 | 0.296 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L12_L17)   | createAnalysisProject    | createAnalysisProject() errors if name missing or not correct   | PASS    |  3 | 0.004 |      |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L38_L41)   | createAnalysisProject    | createAnalysisProject() creates as expected when using defaults | WARNING | 12 | 4.735 | ⚠️   |
| [test-createAnalysisProject.R](testthat/test-createAnalysisProject.R#L59_L69)   | createAnalysisProject    | createAnalysisProject() cleans if there was an error            | PASS    |  1 | 0.008 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L22_L27)     | createPackageProject     | createPackageProject() errors if name missing or not correct    | PASS    |  3 | 0.005 |      |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L52_L55)     | createPackageProject     | createPackageProject() creates as expected when using defaults  | FAILED  | 13 | 0.415 | 🛑    |
| [test-createPackageProject.R](testthat/test-createPackageProject.R#L76_L83)     | createPackageProject     | createPackageProject() cleans if there was an error             | PASS    |  1 | 0.007 |      |

| Failed | Warning | Skipped |
| :----- | :------ | :------ |
| 🛑      | ⚠️      | 🔶       |

</details>

<details>

<summary> Session Info
</summary>

| Field    | Value                         |                                                                                                                                                                                                                           |
| :------- | :---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 3.5.2 (2017-01-27)  |                                                                                                                                                                                                                           |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://travis-ci.org/lockedata/starters/jobs/476866718" target="_blank"><span title="Built on Travis">![](https://github.com/metrumresearchgroup/covrpage/blob/master/inst/logo/travis.png?raw=true)</span></a> |
| Running  | Ubuntu 14.04.5 LTS            |                                                                                                                                                                                                                           |
| Language | en\_US                        |                                                                                                                                                                                                                           |
| Timezone | UTC                           |                                                                                                                                                                                                                           |

| Package  | Version |
| :------- | :------ |
| testthat | 2.0.1   |
| covr     | 3.2.1   |
| covrpage | 0.0.69  |

</details>

<!--- Final Status : error/failed --->
