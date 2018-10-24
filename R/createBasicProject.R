#' Create a very basic project directory
#'
#' @param name Project
#' @param travis Configure Travis-CI
#' @param packagedeps Set a tool for package reproducibility
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
                               packagedeps = "packrat",
                               git = TRUE,
                               readme = TRUE) {
  #  Validate name
  if(!validateName(name)){
    stop("Failed name validation: The name should contain only (ASCII) letters, numbers and dot, have at least two characters and start with a letter and not end in a dot.")
  }


  packagedeps<-match.arg(packagedeps, c("none","packrat","checkpoint"))

  tryCatch({
    if (is_available(name)) {
      dir.create(name)
      usethis::create_project(name, open = FALSE)
      usethis::proj_set(file.path(name))
      usethis::use_description()

      if (travis) {
        usethis::use_template("travis.yml",
                              ".travis.yml",
                              ignore = TRUE)
        #travis::travis_enable() needs GH repo
        #placeholder, BADGE stuff
      }


  if (packagedeps == "packrat") {
        desc::desc_set_dep(package = "packrat",
                           type = "Imports",
                           file = usethis::proj_get())
    packrat::init(name, enter = FALSE)
  }

  if (packagedeps == "checkpoint") {
        desc::desc_set_dep(package = "checkpoint",
                           type = "Imports",
                           file = usethis::proj_get())
    checkpoint::setSnapshot(Sys.Date(), online = TRUE)
  }

  if (readme) usethis::use_readme_rmd(open = FALSE)
  if (git) usethis::use_git()
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
