#' Create a very basic project directory
#'
#' @param name Project
#' @param title "What the Project Does (One Line, Title Case)"
#'              If NULL, a random one will be generated.
#' @param folder Folder under which to create the project
#' @param travis Configure Travis-CI
#' @param packagedeps Set a tool for package reproducibility
#' @param git Configure Git
#' @param github username or organization name to use for GitHub.
#'                If NULL, no GitHub repo is created.
#' @param private whether to make the created GitHub repo private
#' @param protocol "ssh" or "https", protocol to use for GitHub
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
createBasicProject <- function(name,
                               title = NULL,
                               folder = getwd(),
                               travis = TRUE,
                               packagedeps = "packrat",
                               git = TRUE,
                               github = gh::gh_whoami()$login,
                               private = FALSE,
                               protocol = "ssh",
                               reset = TRUE) {

  packagedeps <- match.arg(packagedeps, okpackagedeps())
  check_github_name(github, name)

  if(is.null(title)){
    title <- cool_stuff()
  }

  current_proj <- get_current_proj()
  tryCatch({
      dir.create(file.path(folder, name))

      usethis::proj_set(file.path(folder, name),
                        force = TRUE)

      usethis::create_project(file.path(folder, name), open = FALSE,
                              rstudio = TRUE)

      usethis::use_description()



  desc::desc_set("Title", title,
                 file = usethis::proj_get())

  setup_dep_system(packagedeps)

  usethis::use_readme_md(open = FALSE)


  if (git) usethis::use_git(message = cool_first_commit())

  if (!is.null(github)){
    setup_repo(username = github,
               private = private,
               protocol = protocol,
               title = title)
    if (travis) {
        setup_travis(github, name)
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
  if(reset){
    reset_proj(current_proj)
  }

  invisible(TRUE)
}
