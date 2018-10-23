#' Create a very basic project directory
#'
#' @param name Project
#' @param travis Configure Travis-CI
#' @param packrat Configure Packrat
#' @param git Configure Git
#' @param readme Include a README
#'
#' @export
#'
#' @examples
#' \dontrun{
#' proj<-"basicproj"
#' createBasicProject(proj)
#' list.files(proj)
#' unlink(proj)
#' }
createBasicProject <- function(name,
                               travis = TRUE,
                               packrat = TRUE,
                               git = TRUE,
                               readme = TRUE) {
  tryCatch({
    if (is_available(name)) {
      dir.create(name)
      devtools::setup(name, check = FALSE)
      file.remove(file.path(name, "NAMESPACE"))

      if (travis) {
        devtools::use_travis(name)
      }

      if (packrat) {
        devtools::use_package("packrat", pkg = name)
        packrat:::augmentRprofile(name)
        packrat::init(name, enter = FALSE)
      }
      if (readme) {
        use_readme_rmd(name)
      }

      if (git) {
        devtools::use_git(pkg = name)
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
