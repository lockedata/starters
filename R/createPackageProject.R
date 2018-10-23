#' Create a package the usethis way with a number of infrastructure
#' commands executed to save you hassle
#'
#' @param name Project / package name
#' @param bestPractices Run additional best practice commands
#' @param coverage What code coverage platform to use, "codecov" or "coveralls".
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
                                 coverage = "codecov") {
  tryCatch({
    if (is_available(name)) {
      usethis::create_package(name, open = FALSE)
      usethis::proj_set(file.path(name))
      if (bestPractices) {
        usethis::use_template("travis.yml",
                              ".travis.yml",
                              ignore = TRUE)
        usethis::use_code_of_conduct(name)
        #usethis::use_coverage(type = coverage)
        # needs GH sorry
        usethis::use_mit_license(whoami::fullname())
        usethis::use_news_md(open = FALSE)
        usethis::use_package_doc()
        usethis::use_readme_rmd(open = FALSE)
        usethis::use_testthat()
        usethis::use_vignette(name, open = FALSE)
        usethis::use_git()
      }
    }
  }
  ,
  error = function(e) {
    e
    # delete folder created earlier
    unlink(name, recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name))
  }
  )

  invisible(TRUE)
}
