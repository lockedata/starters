#' Create a very basic project directory
#'
#' @param name Project
#' @param folder Folder under which to create the project
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
createBasicProject <- function(name, folder = getwd(),
                               travis = TRUE,
                               packagedeps = "packrat",
                               git = TRUE,
                               readme = TRUE) {

  packagedeps <- match.arg(packagedeps, okpackagedeps())

  tryCatch({
    if (is_available(name)) {
      dir.create(file.path(folder, name))
      usethis::create_project(file.path(folder, name), open = FALSE)

      proj <- fs::dir_ls(file.path(folder, name),
                         regexp = "*.Rproj")
      file.rename(proj,
                  file.path(folder, name,
                            glue::glue(name, ".Rproj")))


      usethis::proj_set(file.path(folder, name))
      usethis::use_description()

      if (travis) {
        usethis::use_template("travis.yml",
                              ".travis.yml",
                              ignore = TRUE)
        #travis::travis_enable() needs GH repo
        #placeholder, BADGE stuff
      }


  setup_dep_system(packagedeps)


  if (git) usethis::use_git()
  if (readme) usethis::use_readme_rmd(open = FALSE)
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
