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
#'   reset = TRUE,
#'   open = FALSE
#' )
#' list.files(file.path(folder, "doggos"))
#' unlink(file.path(folder, "doggos"))
#' }
createTrainingProject <- function(name, title = NULL,
                                  folder = getwd(),
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
                                    ci_activation = "travis"
                                  ),
                                  reset = TRUE,
                                  open = FALSE) {
  if (missing(name)) stop("name is required")
  if (!is.character(name)) stop("name has to be a character")
  if (nchar(name) < 2) stop("name needs to have at least two characters")

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
    if(!is.null(external_setup)){
      external_setup$project_type <- "training"
    }
    .createBasicProject(
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
    git_add_infrastructure()


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
            package = "starters"
          ),
          full.names = TRUE
          ),
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
            package = "starters"
          ),
          full.names = TRUE
          ),
          file.path(folder, name, "slides"),
          overwrite = TRUE,
          recursive = TRUE
        )
      }
    }

    if (open) {
      rstudioapi::openProject(file.path(folder, name), newSession=TRUE)
    }
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

  if (reset) {
    reset_proj(current_proj)
  }

  invisible(TRUE)
}

handoutEngine <- function() {
  c("rmarkdown", "bookdown", "tufte")
}

slideEngine <- function() {
  c("rmarkdown", "revealjs", "xaringan")
}

#' @export

#' @describeIn createTrainingProject aesthetic addition for continuity purposes
create_training_project = createTrainingProject
