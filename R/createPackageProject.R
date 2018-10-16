#' Create a package the devtools way with a number of infrastructure
#' commands executed to save you hassle
#'
#' @param name Project / package name
#' @param bestPractices Run the additional [devtools::infrastructure()] commands
#' @param coverage What code coverage platform to use
#'
#' @export
#'
#' @examples
#' \dontrun{
#' proj<-"packageproj"
#' createPackageProject(proj)
#' list.files(proj)
#' unlink(proj)
#' }
createPackageProject <- function(name,
                                 bestPractices = TRUE,
                                 coverage = c("codecov", "coveralls")) {
  devtools::create(name)
  if (bestPractices) {
    tryCatch({
      devtools::use_travis(name)
      devtools::use_code_of_conduct(name)
      devtools::use_coverage(name, coverage)
      devtools::use_mit_license(name)
      use_news_md(name)
      use_package_doc(name)
      use_readme_rmd(name)
      devtools::use_testthat(name)
      devtools::use_vignette(name, name)
      devtools::use_git(pkg = name)
    }
    ,
    error = function(e) {
      e
      # delete folder created earlier
      unlink(name, recursive = TRUE)
      print(sprintf("Oops! An error was found and the `%s` directory was deleted", name))
    }
    )
  }
  invisible(TRUE)
}
