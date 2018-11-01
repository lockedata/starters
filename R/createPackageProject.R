#' Create a package the usethis way with a number of infrastructure
#' commands executed to save you hassle
#'
#' @param name Project / package name
#' @param folder Folder under which to create the project
#' @param bestPractices Run additional best practice commands
#' @param coverage What code coverage platform to use, "codecov" or "coveralls".
#' @param private Whether to create the GH repo as private
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
createPackageProject <- function(name, folder = getwd(),
                                 bestPractices = TRUE,
                                 coverage = "codecov",
                                 private = TRUE) {
  tryCatch({
    if (is_available(name)) {
      fs::dir_create(file.path(folder, name))
      usethis::proj_set(file.path(folder, name),
                        force = TRUE)
      usethis::create_package(file.path(folder, name), open = FALSE,
                              rstudio = TRUE,
                              fields = list(License = "MIT + file LICENSE"))

      if (bestPractices) {
        usethis::use_template("travis.yml",
                              ".travis.yml",
                              ignore = TRUE)
        usethis::use_code_of_conduct()
        #usethis::use_coverage(type = coverage)
        # needs GH sorry

        maintainer <- try(whoami::fullname(), silent = TRUE)

        if(inherits(maintainer, "try-error")){
          maintainer <- "Jane Doe"
        }

        usethis::use_template("license-mit.md",
                              "LICENSE.md",
                              ignore = TRUE,
                              data = list(year = format(Sys.Date(), "%Y"),
                                          name = maintainer,
                                          project = name))
        usethis::use_template("license-mit.txt",
                              "LICENSE",
                              data = list(year = format(Sys.Date(), "%Y"),
                                          name = maintainer,
                                          project = name))
        usethis::use_news_md(open = FALSE)
        usethis::use_package_doc()
        usethis::use_readme_rmd(open = FALSE)
        usethis::use_testthat()
        usethis::use_vignette(name)
        usethis::use_git()
        #use_github(private = private)
      }
    }
  }
  ,
  error = function(e) {
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name))
  }
  )

  invisible(TRUE)
}
