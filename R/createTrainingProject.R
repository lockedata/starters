#' @title Create a training project
#'
#' @description Create a project laid out for producing training materials
#'
#' @inheritParams createBasicProject
#' @param dirs Directories to create
#' @param handoutEngine Package for building handouts
#' @param slideEngine Package for building slides
#'
#' @export
#'
#' @examples
#' \dontrun{
#' folder <- tempdir()
#' createTrainingProject(
#'   name = "doggos", title = "Learning how to count cute dogs",
#'   folder = folder,
#'   dirs = c("data", "handouts", "slides", "dogs"),
#'   packagedeps = "none",
#'   git = TRUE, external_setup = NULL,
#'   reset = TRUE
#' )
#' list.files(file.path(folder, "doggos"))
#' unlink(file.path(folder, "doggos"))
#' }
createTrainingProject <- function(name, folder = getwd(),
                                  initial_status = "wip",
                                  dirs = c("data", "handouts", "slides"),
                                  handoutEngine = "rmarkdown",
                                  slideEngine = "rmarkdown",
                                  packagedeps = "packrat",
                                  git = TRUE,
                                  external_setup = list(
                                    git_service = "GitHub",
                                    login = gh::gh_whoami()$login,
                                    private = FALSE,
                                    protocol = "ssh",
                                    ci_activation = "tic"
                                  ),
                                  title = NULL,
                                  reset = TRUE) {

  if(missing(name)) stop("name is required")
  if(!is.character(name)) stop("name has to be a character")

  packagedeps <- match.arg(packagedeps, okpackagedeps())
  # Supported packages
  handoutEngine <- match.arg(
    handoutEngine,
    handoutEngine()
  )

  slideEngine <- match.arg(
    slideEngine,
    slideEngine()
  )

  if (!requireNamespace(handoutEngine, quietly = TRUE)) {
    stop("You need to install ", handoutEngine, " first")
  }
  if (!requireNamespace(slideEngine, quietly = TRUE)) {
    stop("You need to install ", slideEngine, " first")
  }

  # Skeleton
  message("Creating skeleton")
  current_proj <- get_current_proj()
  tryCatch({
    createBasicProject(
      name = name,
      title = title,
      folder = folder,
      initial_status = initial_status,
      packagedeps = packagedeps,
      git = git,
      external_setup = external_setup,
      reset = FALSE
    )
    createdirs(dirs)


    # Handouts prep
    if ("handouts" %in% dirs) {
      desc::desc_set_dep(
        package = handoutEngine,
        type = "Imports",
        file = usethis::proj_get()
      )
      if (handoutEngine != "rmarkdown") {
        message(paste(handoutEngine, "demo added"))
        file.copy(
          list.files(system.file("templates", handoutEngine,
                                 package = "pRojects"),
                     full.names = TRUE),
          file.path(folder, name, "handouts"),
          overwrite = TRUE,
          recursive = TRUE
        )
      }
    }

    # Slides prep
    if ("slides" %in% dirs) {
      desc::desc_set_dep(
        package = slideEngine,
        type = "Imports",
        file = usethis::proj_get()
      )

      if (slideEngine != "rmarkdown") {
        message(paste(slideEngine, "demo added"))
        file.copy(
          list.files(system.file("templates", slideEngine,
                                 package = "pRojects"),
                     full.names = TRUE),
          file.path(folder, name, "slides"),
          overwrite = TRUE,
          recursive = TRUE
        )
      }
    }

    createBasicProject(
      name = name,
      title = title,
      folder = folder,
      packagedeps = packagedeps,
      git = git,
      external_setup = external_setup,
      reset = FALSE
    )
    createdirs(dirs)
  },
  error = function(e) {
    message(paste("Error:", e$message))
    e
    # delete folder created earlier
    unlink(file.path(folder, name), recursive = TRUE)
    message(sprintf("Oops! An error was found and the `%s` directory was deleted", name)) # nolint
  }
  )
  setup_dep_system(packagedeps)

  reset_proj(current_proj)
  invisible(TRUE)
}

handoutEngine <- function() {
  c("rmarkdown", "bookdown", "tufte")
}

slideEngine <- function() {
  c("rmarkdown", "revealjs", "xaringan")
}
