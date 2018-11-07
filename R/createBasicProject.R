#' Create a very basic project directory
#'
#' @param name Project
#' @param folder Folder under which to create the project
#' @param travis Configure Travis-CI
#' @param packagedeps Set a tool for package reproducibility
#' @param git Configure Git
#' @param github username or organization name to use for GitHub.
#'                If NULL, no GitHub repo is created.
#' @param private whether to make the created GitHub repo private
#' @param protocol "ssh" or "https", protocol to use for GitHub
#' @param readme Include a README
#' @param reset whether to reset the project to current project
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
                               github = gh::gh_whoami()$login,
                               private = FALSE,
                               protocol = "ssh",
                               readme = TRUE,
                               reset = TRUE) {

  packagedeps <- match.arg(packagedeps, okpackagedeps())
  current_proj <- get_current_proj()
  tryCatch({
      dir.create(file.path(folder, name))

      usethis::proj_set(file.path(folder, name),
                        force = TRUE)

      usethis::create_project(file.path(folder, name), open = FALSE,
                              rstudio = TRUE)

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
  if (!is.null(github)) setup_repo(username = github,
                                   private, protocol)

  }
  ,
  error = function(e) {
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name))
  }
  )
  if(reset){
    reset_proj(current_proj)
  }

  invisible(TRUE)
}
