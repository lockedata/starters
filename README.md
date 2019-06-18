Project health
================
18 June, 2019 10:52:16

# Good practice

``` r
if(!require("goodpractice")){
  install.packages("goodpractice")
}
checks <- goodpractice::all_checks()
gp <- goodpractice::gp(fs::path_dir(getwd()),
                       checks[!grepl("rcmdcheck", checks)])
```

    ## 
    ##   
       checking for file ‘/tmp/RtmpSlLsJc/remotes4ff33e889ea/starters/DESCRIPTION’ ...
      
    ✔  checking for file ‘/tmp/RtmpSlLsJc/remotes4ff33e889ea/starters/DESCRIPTION’
    ## 
      
    ─  preparing ‘starters’:
    ## 
      
       checking DESCRIPTION meta-information ...
      
    ✔  checking DESCRIPTION meta-information
    ## 
      
       checking vignette meta-information ...
      
    ✔  checking vignette meta-information
    ## 
      
    ─  checking for LF line-endings in source and make files and shell scripts
    ## 
      
    ─  checking for empty or unneeded directories
    ## 
      
    ─  building ‘starters_0.0.2.tar.gz’
    ## 
      
       
    ## 

``` r
print(gp)
```

    ## ── GP starters ────────────────────────────────────────────────────────────
    ## 
    ## It is good practice to
    ## 
    ##   ✖ write unit tests for all functions, and all package code in
    ##     general. 43% of code lines are covered by test cases.
    ## 
    ##     R/createAnalysisProject.R:47:NA
    ##     R/createAnalysisProject.R:63:NA
    ##     R/createBasicProject.R:59:NA
    ##     R/createBasicProject.R:60:NA
    ##     R/createBasicProject.R:61:NA
    ##     ... and 477 more lines
    ## 
    ## ───────────────────────────────────────────────────────────────────────────

# Typos

``` r
devtools::spell_check()
```

    ##   WORD              FOUND IN
    ## addin             README.md:66
    ##                   README.Rmd:52
    ##                   starters.Rmd:58
    ## addins            starters.Rmd:58
    ## browseVignettes   starters.Rd:15
    ## codecov           createPackageProject.Rd:32
    ##                   starters.Rmd:372
    ## config            createPackageProject.Rd:36
    ##                   NEWS.md:3
    ##                   starters.Rmd:171,361
    ## favour            starters.Rmd:169
    ## flavours          starters.Rmd:91
    ## gh                starters.Rmd:212,271,374
    ## gitconfig         start_here.Rd:14
    ##                   README.md:54
    ##                   README.Rmd:49
    ##                   starters.Rmd:20
    ## https             createAnalysisProject.Rd:46
    ##                   createBasicProject.Rd:42
    ##                   createPackageProject.Rd:45
    ##                   createTrainingProject.Rd:52
    ##                   start_here.Rd:18
    ##                   starters.Rmd:169
    ## licence           starters.Rmd:349
    ## md                starters.Rmd:126,353
    ## packrat           README.md:27,30
    ##                   README.Rmd:27,29
    ##                   starters.Rmd:135,300
    ## Packrat           starters.Rmd:137
    ## pkgdown           createPackageProject.Rd:36
    ##                   starters.Rmd:374
    ## pre               starters.Rmd:68
    ## pRojects          NEWS.md:9
    ## Rbuildignore      starters.Rmd:357
    ## README            createAnalysisProject.Rd:31,49
    ##                   createBasicProject.Rd:29,45
    ##                   createPackageProject.Rd:30,48
    ##                   createTrainingProject.Rd:33,55
    ##                   starters.Rmd:126,359
    ## repo              createAnalysisProject.Rd:44,45
    ##                   createBasicProject.Rd:40,41
    ##                   createPackageProject.Rd:43,44
    ##                   createTrainingProject.Rd:50,51
    ##                   starters.Rmd:162,167
    ## repostatus        createAnalysisProject.Rd:30
    ##                   createBasicProject.Rd:28
    ##                   createPackageProject.Rd:29
    ##                   createTrainingProject.Rd:32
    ##                   starters.Rmd:126,359
    ## reproducibility   createAnalysisProject.Rd:35
    ##                   createBasicProject.Rd:31
    ##                   createTrainingProject.Rd:41
    ##                   README.md:27,30
    ##                   README.Rmd:27,29
    ## Rmd               starters.Rmd:126,359
    ## RStudio           createAnalysisProject.Rd:54
    ##                   createBasicProject.Rd:50
    ##                   createPackageProject.Rd:53
    ##                   createTrainingProject.Rd:60
    ##                   README.md:62,64,66
    ##                   README.Rmd:51,52,52
    ##                   starters.Rmd:54,56,56,58,58,76,101,128,186,244,298,310,363
    ## Silge's           starters.Rmd:70
    ## TAs               starters.Rmd:66
    ## travis            createAnalysisProject.Rd:47,48
    ##                   createBasicProject.Rd:43,44
    ##                   createPackageProject.Rd:46,47
    ##                   createTrainingProject.Rd:53,54
    ##                   starters.Rmd:171,212,271
    ## usethis           createPackageProject.Rd:6,56
    ##                   start_here.Rd:18
    ## wip               starters.Rmd:359
    ## WIP               starters.Rmd:126
