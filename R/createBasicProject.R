.createBasicProject <- function(name, title = NULL,
                               folder = getwd(),
                               initial_status = "wip",
                               packagedeps = "checkpoint",
                               git = TRUE,
                               external_setup = list(
                                 git_service = "GitHub",
                                 login = gh::gh_whoami()$login,
                                 private = FALSE,
                                 protocol = "ssh",
                                 ci_activation = "travis",
                                 project_type = "basic",
                               ),
                               reset = TRUE,
                               open = TRUE) {
  validate_name(name)

  packagedeps <- match.arg(packagedeps, okpackagedeps())

  # random title if needed
  if (is.null(title)) {
    title <- cool_stuff()
  }

  # for later resetting the project
  current_proj <- get_current_proj()

  tryCatch({

    # create the project
    usethis::create_project(file.path(folder, name),
                            open = FALSE,
                            rstudio = TRUE
    )
    usethis::proj_set(file.path(folder, name),
                      force = TRUE
    )

    # add DESCRIPTION file and fill title
    usethis::use_description()
    desc::desc_set("Title", title,
                   file = usethis::proj_get()
    )


    # add README
    use_readme(name)

    # status
    add_repo_status(initial_status)

    # git setup
    if (git) {
      usethis::use_git(message = cool_first_commit())
      add_styler_hook()
    }

    if (!is.null(external_setup)) {
      setup_repo(
        name = name,
        title = title,
        git_service = external_setup$git_service,
        login = external_setup$login,
        private = external_setup$private,
        protocol = external_setup$protocol,
        ci_activation = external_setup$ci_activation,
        project_type = external_setup$project_type
      )
    }

    # README
    knit_readme()

    # setup system for dependencies management
    setup_dep_system(packagedeps)

  },
  error = function(e) {
    message(paste("Error:", e$message))
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name)) # nolint
  }
  )
  if (reset) {
    reset_proj(current_proj)
  }

  invisible(TRUE)
}


#' Create a very basic project directory
#'
#' @param name Project
#' @param title "What the Project Does (One Line, Title Case)"
#'              If NULL, a random one will be generated.
#' @param folder Folder under which to create the project
#' @param initial_status initial repostatus.org status for the project,
#'                       whose badge will be added to the README.
#' @param packagedeps Set a tool for package reproducibility
#' @param git Configure Git
#' @param external_setup How to do the partly interactive setup
#'  of online git, CI and coverage platforms. If NULL, no setup.
#'  \itemize{
#'  \item \code{git_service} Only "GitHub" is supported at the moment.
#'  \item \code{login} username or organization name to use for the git service.
#'                If NULL, no GitHub repo is created.
#'  \item \code{private} whether to make the created repo private
#'  \item \code{protocol} "ssh" or "https", protocol to use for GitHub
#'  \item \code{ci_activation} Only NULL, and "travis" are supported at the moment.
#'  "travis" means calling \code{usethis::use_travis()} and adding the Travis
#'  badge to the README.
#'  }
#' @param reset Whether to reset the project to current project
#' @param open Whether to open the newly created project (in another RStudio session)
#'
#' @export
#'
#' @examples
#' \dontrun{
#' folder <- tempdir()
#' createBasicProject(
#'   name = "doggos", title = "Counting cute dogs",
#'   folder = folder,
#'   packagedeps = "none",
#'   git = TRUE, external_setup = NULL,
#'   reset = TRUE,
#'   open = FALSE
#' )
#' list.files(file.path(folder, "doggos"))
#' unlink(file.path(folder, "doggos"))
#' }
createBasicProject <- function(name, title = NULL,
                               folder = getwd(),
                               initial_status = "wip",
                               packagedeps = "checkpoint",
                               git = TRUE,
                               external_setup = list(
                                 git_service = "GitHub",
                                 login = gh::gh_whoami()$login,
                                 private = FALSE,
                                 protocol = "ssh",
                                 ci_activation = "travis"
                               ),
                               reset = TRUE,
                               open = FALSE) {
  if(!is.null(external_setup)){
    external_setup$project_type <- "basic"
  }
  .createBasicProject(name = name, title = title,
                      folder = folder,
                      initial_status = initial_status,
                      packagedeps = packagedeps,
                      git = git,
                      external_setup = external_setup,
                      reset = reset)

  if (open) {
    rstudioapi::openProject(file.path(folder, name),
                            newSession = TRUE)
  }
}

#' @export

#' @describeIn createBasicProject aesthetic addition for continuity purposes
create_basic_project = createBasicProject
